package com.cycc.todo;

import com.google.common.base.Joiner;
import com.google.common.collect.LinkedHashMultimap;
import com.google.common.collect.Multimap;

import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.LineNumberReader;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Created by jpc on 7/8/15.
 */
public class Todo {
    private static final Joiner JOINER = Joiner.on(";");
    private final static Map<String, String> CONFIG_BY_CODE = new HashMap<>();
    private final static Map<String, String> CONFIG_BY_NAME = new HashMap<>();
    private final static Map<String, LineInfoRecord> OPTIFLEET = new HashMap<>();

    public static void main(String[] args) throws Exception {
        LineNumberReader lnr = new LineNumberReader(new FileReader("etc/sample/lhoist/input/FR_LHOISTP_01_Config_Matlab.txt"));
        final List<String> languages = new ArrayList<>();
        String s = lnr.readLine();
        String[] ss = s.split(";", -1);
        for (int i = 2; i < ss.length; i++){
            languages.add(ss[i]);
        }
        System.out.printf("languages detected: %s%n", JOINER.join(languages));
        while ((s = lnr.readLine()) != null){
            ss = s.split(";", -1);
            for (int i = 0; i < languages.size(); i++){
                CONFIG_BY_CODE.put(String.format("%s-%s", ss[1], languages.get(i)), ss[i + 2]);
                CONFIG_BY_NAME.put(String.format("%s-%s", ss[0], languages.get(i)), ss[i + 2]);
            }
        }
        lnr.close();
        lnr = new LineNumberReader(new FileReader("etc/sample/lhoist/input/FR_LHOISTP_01_Line_info_traffic_201412_(received from client 201412 and adapted by VBI).csv"));
        s = lnr.readLine();
        s = lnr.readLine();
        while ((s = lnr.readLine()) != null){
            final LineInfoRecord rec = new LineInfoRecord(s);
            if (rec.getLine().length() > 0){
                OPTIFLEET.put(rec.getLine(), rec);
            }
        }
        System.out.printf("count of lines in optifleet: %s%n", OPTIFLEET.size());
        final String cdrFileName = "Call_data_records_Lhoist France_traffic_201505.txt";
        lnr = new LineNumberReader(new FileReader("etc/sample/lhoist/input/" + cdrFileName));
        final CostAccumulator accLine = new CostAccumulator();
        final CostAccumulator accLineWithoutSubscription = new CostAccumulator();
        final CostAccumulator accLineRenaming = new CostAccumulator();
        final CostAccumulator accLineRemapping = new CostAccumulator();
        final Multimap<String, CallDataRecord> multimap = LinkedHashMultimap.create();
        s = lnr.readLine();
        while ((s = lnr.readLine()) != null){
            final CallDataRecord rec = new CallDataRecord(s.split(";", -1));
            multimap.put(rec.getLine(), rec);
            accLine.accumulate(new Key(rec.getLine()), rec.getCost());
            if (!rec.isSubscription()){
                accLineWithoutSubscription.accumulate(new Key(rec.getLine()), rec.getCost());
            }
            accLineRenaming.accumulate(new Key(rec.getLine(), rec.getRenaming()), rec.getCost());
            accLineRemapping.accumulate(new Key(rec.getLine(), rec.getRemapping()), rec.getCost());
        }
        System.out.printf("count of lines in cdr: %s%n", multimap.size());
        final Map<String, CostRecord> totalPerLine = accLine.extractMap();
        final Map<String, CostRecord> totalPerLineWithoutSubscription = accLineWithoutSubscription.extractMap();
        final Map<String, Map<String, CostRecord>> renamingPerLine = accLineRenaming.extractTable();
        final Map<String, Map<String, CostRecord>> remappingPerLine = accLineRemapping.extractTable();
        final ZipOutputStream zos = new ZipOutputStream(new FileOutputStream("output.zip"));
        final PrintWriter pw = new PrintWriter(zos);
        for (final Map.Entry<String, Collection<CallDataRecord>> entry: multimap.asMap().entrySet()){
            final String line = entry.getKey();
            final LineInfoRecord lineInfo = OPTIFLEET.get(line);
            final String language = lineInfo == null || lineInfo.getLanguage() == null ? "EN" : lineInfo.getLanguage();
            zos.putNextEntry(new ZipEntry(String.format("%s_(%s)_%s", entry.getKey(), lineInfo == null ? "" : lineInfo.getEmail(), cdrFileName)));
            final Map<String, CostRecord> costByRenaming = renamingPerLine.get(line);
            for (final Map.Entry<String, CostRecord> renamingEntry: costByRenaming.entrySet()){
                final String renaming = renamingEntry.getKey();
                final CostRecord rec = renamingEntry.getValue();
                String remapping = "";
                String key = String.format("%s-%s", remapping, language);
                pw.printf("%s%n", JOINER.join(new Object[]{ renaming, remapping , rec.getCount(), rec.getUnits(), rec.getCost(), "some cost per unit"}));
            }
/*
            CallDataRecord renamingTotalSubscriptionExcluded = new CallDataRecord("total subs excl");
            CallDataRecord renamingTotal = new CallDataRecord("total");
            for (final Map.Entry<String, CallDataRecord> renamingEntry: entry.getValue().entrySet()){
                final String renaming = renamingEntry.getKey();
                final CallDataRecord rec = renamingEntry.getValue();
                String key = String.format("%s-%s", rec.getRemapping(), language);
                pw.printf("%s%n", JOINER.join(new Object[]{ renaming, CONFIG_BY_NAME.get(key) , rec.getCount(), rec.getUnits(), rec.getCost(), rec.getCostPerUnit()}));
                renamingTotal = renamingTotal.combine(rec);
                if (!rec.isSubscription()){
                    renamingTotalSubscriptionExcluded = renamingTotalSubscriptionExcluded.combine(rec);
                }
            }
*/
            pw.printf("%s%n", JOINER.join(new Object[]{"*total cost subscription excluded", "", "", "", totalPerLineWithoutSubscription.containsKey(line) ? totalPerLineWithoutSubscription.get(line).getCost() : BigDecimal.ZERO, ""}));
            pw.printf("%s%n", JOINER.join(new Object[]{"*total cost line", "", "", "", totalPerLine.containsKey(line) ? totalPerLine.get(line).getCost() : BigDecimal.ZERO, ""}));
            pw.printf("%n");
            final String[] tableTitles = new String[]{ "TR_1", "TR_2", "TR_3" };
            for (int i = 0; i < tableTitles.length; i++){
                tableTitles[i] = CONFIG_BY_CODE.get(String.format("%s-%s", tableTitles[i], language));
            }
            pw.printf("%s%n", JOINER.join(tableTitles));
/*
            for (final Map.Entry<String, CallDataRecord> remappingEntry: CDR_BY_REMAPPING.get(line).entrySet()){
                final String remapping = remappingEntry.getKey();
                final CallDataRecord rec = remappingEntry.getValue();
                if (rec.getCost().signum() > 0){
                    // get average for remapping
                    final CallDataRecord totalRemapping = TOTAL_REMAPPING.get(remapping);
                    final BigDecimal averageCost = totalRemapping.getCost().divide(new BigDecimal(CDR_BY_RENAMING.size()), new MathContext(2, RoundingMode.CEILING));
                    pw.printf("%s%n", JOINER.join(new Object[]{ remapping, rec.getCost(), rec.getCost().subtract(averageCost)}));

                }
            }
            for (final Map.Entry<String, CallDataRecord> totalRemappingEntry: TOTAL_REMAPPING.entrySet()){
                final String remapping = totalRemappingEntry.getKey();
                final CallDataRecord rec = totalRemappingEntry.getValue();
                pw.printf("%s%n", JOINER.join(new Object[]{ "total", remapping, rec.getUnits(), rec.getCost()}));
            }
*/
            pw.printf("%nD�tails des appels%nType de trafic;Type d'appel;Destination / r�seau visit�;Date;Num�ro compos�;Unit�s;Co�t%n");
            final Collection<CallDataRecord> callDataRecords = multimap.get(line);
            if (callDataRecords != null){
                for (final CallDataRecord rec: callDataRecords){
                    pw.printf("%s%n", JOINER.join(rec.getRemapping(), rec.getRenaming(), rec.getDestinationService(), rec.getWhen(), rec.getDestinationNumber(), rec.getCost().getUnits(), rec.getCost().getCost()));
                    // TODO 3 more fields
                }
            }
            pw.flush();
            zos.closeEntry();
        }
        zos.close();

    }
}
