package com.cycc.todo;

import com.google.common.base.Joiner;
import com.google.common.collect.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.profiler.Profiler;

import java.io.*;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.logging.LogManager;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Created by jpc on 7/8/15.
 */
public class Todo {
    private static final Logger LOGGER = LoggerFactory.getLogger(Todo.class);
    private static final Joiner JOINER = Joiner.on(";");
    private static final int[] BOUNDARIES = {0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 300, 3000, Integer.MAX_VALUE };
    private static final String[] EMPTY_DATE = { "", "", "" };
    private static final String NO_NUMBER = "No Number";
    private final static Map<Key, String> CONFIG = new HashMap<>();
    private final static Map<String, LineInfoRecord> LINE_INFO_BY_LINE = new HashMap<>();

    private static void putCode(String language, String code, String value){
        CONFIG.put(new Key(code, language), value);
    }

    private static String getCode(String language, String code){
        return CONFIG.get(new Key(code, language));
    }

    private static String[] getCodes(String language, String... codes){
        final String[] ss = new String[codes.length];
        for (int i = 0; i < codes.length; i++){
            ss[i] = CONFIG.get(new Key(codes[i], language));
        }
        return ss;
    }

    public static void main(String[] args) throws Exception {
        LogManager.getLogManager().readConfiguration(Todo.class.getClassLoader().getResourceAsStream("logging.properties"));
        final Profiler profiler = new Profiler("todo");
        profiler.setLogger(LOGGER);
        profiler.start("Reading matlab config file");
        LineNumberReader lnr = new LineNumberReader(new FileReader("etc/sample/lhoist/input/FR_LHOISTP_01_Config_Matlab.txt"));
        final List<String> languages = new ArrayList<>();
        String s = lnr.readLine();
        String[] ss = s.split(";", -1);
        for (int i = 2; i < ss.length; i++) {
            languages.add(ss[i]);
        }
        LOGGER.info("languages detected: {}", JOINER.join(languages));
        while ((s = lnr.readLine()) != null){
            ss = s.split(";", -1);
            for (int i = 0; i < languages.size(); i++){
                final String language = languages.get(i);
                putCode(language, ss[1], ss[i + 2]);
                putCode(language, ss[0], ss[i + 2]);
            }
        }
        lnr.close();
        profiler.start("Reading line info file");
        lnr = new LineNumberReader(new FileReader("etc/sample/lhoist/input/FR_LHOISTP_01_Line_info_traffic_201412_(received from client 201412 and adapted by VBI).csv"));
        s = lnr.readLine();
        s = lnr.readLine();
        while ((s = lnr.readLine()) != null){
            final LineInfoRecord rec = new LineInfoRecord(s);
            if (rec.getLine().length() > 0){
                LINE_INFO_BY_LINE.put(rec.getLine(), rec);
            }
        }
        LOGGER.debug("count of lines in optifleet line info file: {}", LINE_INFO_BY_LINE.size());
        final String cdrFileName = "Call_data_records_Lhoist France_traffic_201505.txt";
        profiler.start("Reading martyr file");
        lnr = new LineNumberReader(new FileReader("etc/sample/lhoist/input/" + cdrFileName));
        final CostAccumulator accLine = new CostAccumulator();
        final CostAccumulator accLineWithoutSubscription = new CostAccumulator();
        final CostAccumulator accLineRenaming = new CostAccumulator();
        final CostAccumulator accLineRemapping = new CostAccumulator();
        final CostAccumulator accRemapping = new CostAccumulator();
        final Multimap<String, CallDataRecord> multimap = LinkedHashMultimap.create();
        s = lnr.readLine();
        while ((s = lnr.readLine()) != null){
            final CallDataRecord rec = new CallDataRecord(s.split(";", -1));
            multimap.put(rec.getLine(), rec);
            accLine.accumulate(new Key(rec.getLine()), rec.getCost());
            if (!rec.isSubscription()){
                accLineWithoutSubscription.accumulate(new Key(rec.getLine()), rec.getCost());
            }
            accLineRenaming.accumulate(new Key(rec.getLine(), new Key(rec.getRenaming(), rec.getRemapping())), rec.getCost());
            accLineRemapping.accumulate(new Key(rec.getLine(), rec.getRemapping()), rec.getCost());
            accRemapping.accumulate(new Key(rec.getRemapping()), rec.getCost());
        }
        LOGGER.debug("count of lines in cdr: {}", multimap.size());
        profiler.start("Computing summaries");
        final Map<String, CostRecord> totalPerLine = accLine.extractMap();
        final Map<String, CostRecord> totalPerLineWithoutSubscription = accLineWithoutSubscription.extractMap();
        final Map<String, Map<Key, CostRecord>> renamingPerLine = accLineRenaming.extractTable();
        final Map<String, Map<String, CostRecord>> remappingPerLine = accLineRemapping.extractTable();
        final Map<String, CostRecord> remappingTotal = accRemapping.extractMap();
        final List<String> lines = new ArrayList<>(multimap.keySet());
        final BigDecimal lineCount = new BigDecimal(lines.size());
        profiler.start("Computing positions");
        final Map<String, List<String>> positionsPerRemapping = new HashMap<>();
        for (final String remapping: remappingTotal.keySet()){
            final List<String> sortedLines = new ArrayList<>(lines);
            Collections.sort(sortedLines, new Comparator<String>() {
                @Override
                public int compare(String line1, String line2) {
                    final CostRecord cost1 = remappingPerLine.get(line1).get(remapping);
                    final CostRecord cost2 = remappingPerLine.get(line2).get(remapping);
                    final BigDecimal c1 = cost1 == null ? BigDecimal.ZERO : cost1.getCost();
                    final BigDecimal c2 = cost2 == null ? BigDecimal.ZERO : cost2.getCost();
                    return c1.subtract(c2).signum();
                }
            });
            positionsPerRemapping.put(remapping, sortedLines);
        }
        final List<String> positions = new ArrayList<>(lines);
        Collections.sort(positions, new Comparator<String>() {
            @Override
            public int compare(String line1, String line2) {
                final CostRecord cost1 = totalPerLine.get(line1);
                final CostRecord cost2 = totalPerLine.get(line2);
                final BigDecimal c1 = cost1 == null ? BigDecimal.ZERO : cost1.getCost();
                final BigDecimal c2 = cost2 == null ? BigDecimal.ZERO : cost2.getCost();
                return c1.subtract(c2).signum();
            }
        });
        profiler.start("Computing ranges");
        final Map<Range, Integer> ranges = new TreeMap<>();
        for (int i = 0; i < BOUNDARIES.length - 1; i++){
            ranges.put(new Range(BOUNDARIES[i], BOUNDARIES[i + 1]), 0);
        }
        for (final CostRecord rec: totalPerLine.values()){
            final BigDecimal cost = rec.getCost();
            for (final Map.Entry<Range, Integer> entry: ranges.entrySet()){
                if (entry.getKey().includes(cost)){
                    entry.setValue(entry.getValue() + 1);
                }
            }
        }
        profiler.start("Outputting files");
        final ZipOutputStream zos = new ZipOutputStream(new FileOutputStream("output.zip"));
        final PrintWriter pw = new PrintWriter(zos);
        for (final Map.Entry<String, Collection<CallDataRecord>> entry: multimap.asMap().entrySet()){
            final String line = entry.getKey();
            final BigDecimal totalLineCost = totalPerLine.get(line) == null ? BigDecimal.ZERO : totalPerLine.get(line).getCost();
            final BigDecimal totalLineCostWithoutSubscription = totalPerLineWithoutSubscription.get(line) == null ? BigDecimal.ZERO : totalPerLineWithoutSubscription.get(line).getCost();
            final int position = lineCount.intValue() - positions.indexOf(line);
            LineInfoRecord lineInfo = LINE_INFO_BY_LINE.get(line);
            if (lineInfo == null){
                lineInfo = new LineInfoRecord();
            }
            final String language = lineInfo.getLanguage();
            zos.putNextEntry(new ZipEntry(String.format("%s_(%s)_%s", entry.getKey(), lineInfo.getEmail(), cdrFileName)));
            pw.printf("%s", JOINER.join(getCodes(language, "CS_1", "CS_2", "CS_3", "CS_4", "CS_5", "CS_6")));
            // todo missing stuff
            pw.printf(";%s", JOINER.join(totalLineCostWithoutSubscription, totalLineCost, position));
            // todo missing stuff
            pw.printf(";%s", JOINER.join(lineInfo.getLine(), lineInfo.getEmail(), lineInfo.getLine(), lineInfo.getName(), lineInfo.getLanguage(), lineInfo.getEmail()));
            // todo missing stuff
            pw.printf(";%s", JOINER.join(getCodes(language, "HIST_1", "HIST_2", "HIST_3", "HIST_4", "HIST_5", "HIST_6")));
            pw.printf(";%s%n", lineCount);
            final Map<Key, CostRecord> costByRenaming = renamingPerLine.get(line);
            for (final Map.Entry<Key, CostRecord> renamingEntry: costByRenaming.entrySet()){
                final Key renaming = renamingEntry.getKey();
                final CostRecord rec = renamingEntry.getValue();
                pw.printf("%s%n", JOINER.join(new Object[]{ renaming.getComponent(0), getCode(language, renaming.getComponent(1).toString()), rec.getCount(), rec.getUnits(), rec.getCost(), rec.getCostPerUnit()}));
            }
            pw.printf("%s%n", JOINER.join(new Object[]{ getCode(language, "CS_7"), "", "", "", totalLineCostWithoutSubscription }));
            pw.printf("%s%n", JOINER.join(new Object[]{ getCode(language, "CS_8"), "", "", "", totalLineCost }));
            pw.println();
            pw.printf("%s%n", JOINER.join(getCodes(language, "TR_1", "TR_2", "TR_3")));
            final Map<String, CostRecord> costByRemapping = remappingPerLine.get(line);
            for (final Map.Entry<String, CostRecord> remappingEntry: costByRemapping.entrySet()){
                final String remapping = remappingEntry.getKey();
                final CostRecord rec = remappingEntry.getValue();
                final CostRecord totalRec = remappingTotal.get(remapping);
                if (rec.getCost().signum() != 0){
                    // get average for remapping
                    final BigDecimal deviation = rec.getCost().subtract(totalRec.getCost().divide(lineCount, 4, RoundingMode.CEILING));
                    pw.printf("%s%n", JOINER.join(getCode(language, remapping), lineCount.intValue() - positionsPerRemapping.get(remapping).indexOf(line), deviation));
                }
            }
            pw.printf("%s%n", JOINER.join(getCode(language, "TR_14"), position, totalLineCost.subtract(accLine.getTotal().getCost().divide(lineCount, 4, BigDecimal.ROUND_CEILING))));
            pw.printf("%s%n", JOINER.join(getCode(language, "TR_15"), lineCount));
            for (final Map.Entry<Range, Integer> entry2: ranges.entrySet()){
                if (entry2.getKey().includes(totalLineCost)){
                    pw.printf("%s%n", JOINER.join(getCode(language, "TR_2"), entry2.getValue(), entry2.getValue()));
                } else{
                    pw.printf("%s%n", JOINER.join(entry2.getKey().getLower(), entry2.getValue()));
                }
            }
            pw.println();
            pw.printf("%s%n", getCode(language, "CD_1"));
            pw.printf("%s%n", JOINER.join(getCodes(language, "CD_2", "CD_3", "CD_4", "CD_5", "CD_6", "CD_7", "CD_8")));
            final Collection<CallDataRecord> callDataRecords = multimap.get(line);
            if (callDataRecords != null){
                int count = 0;
                for (final CallDataRecord rec: callDataRecords){
                    if (!rec.isSubscription()){
                        final int space = rec.getWhen().indexOf(' ');
                        String[] ds;
                        if (space != -1){
                            ds = rec.getWhen().substring(0, space).split("/");
                            ds[2] = ds[2].substring(2);
                        } else{
                            ds = EMPTY_DATE;
                        }
                        pw.printf("%s%n", JOINER.join(getCode(language, rec.getRemapping()), rec.getRenaming(), rec.getDestinationService(), rec.getWhen(), rec.getDestinationNumber().length() == 0 ? NO_NUMBER : rec.getDestinationNumber(), rec.getCost().getUnits(), rec.getCost().getCost(), ds[0], ds[1], ds[2]));
                        count++;
                    }
                }
                pw.printf("%s%n", JOINER.join(" #Appels/Oproepen/Calls:", count));
            }
            pw.flush();
            zos.closeEntry();
        }
        profiler.stop().log();
        zos.close();
    }
}
