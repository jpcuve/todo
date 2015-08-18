package com.cycc.todo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.profiler.Profiler;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.*;
import java.util.function.Function;
import java.util.logging.LogManager;
import java.util.stream.Collector;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Created by jpc on 26/07/15.
 */
public class Todo {
    private static final Logger LOGGER = LoggerFactory.getLogger(Todo.class);
    private static final int[] BOUNDARIES = {0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 300, 3000, Integer.MAX_VALUE };
    private static final String NO_NUMBER = "No Number";
    private static final Collector<CharSequence, ?, String> JOINING = Collectors.joining(";");

    private static String semicolons(int quantity){
        final StringBuilder sb = new StringBuilder();
        for (int i = 0; i < quantity; i++){
            sb.append(';');
        }
        return sb.toString();
    }

    public static void main(String[] args) throws Exception {
        LogManager.getLogManager().readConfiguration(Todo.class.getClassLoader().getResourceAsStream("logging.properties"));
        final Profiler profiler = new Profiler("todo");
        profiler.setLogger(LOGGER);
        profiler.start("Reading matlab config file");
        final File fMatlab = new File("etc/sample/lhoist/input/FR_LHOISTP_01_Config_Matlab.txt");
        final Map<String, MemoryResourceBundle> resourceBundleMap = new HashMap<>();
        final Optional<String> o = Files.lines(fMatlab.toPath(), StandardCharsets.ISO_8859_1).findFirst();
        if (o.isPresent()){
            final String[] first = o.get().toLowerCase().split(";", -1);
            final List<String> languages = Arrays.asList(Arrays.copyOfRange(first, 2, first.length));
            languages.stream().forEach(language -> resourceBundleMap.put(language, new MemoryResourceBundle()));
            LOGGER.info("languages detected: {}", languages.stream().collect(Collectors.joining(";")));
            Files.lines(fMatlab.toPath(), StandardCharsets.ISO_8859_1).skip(1).forEach(line -> {
                final String[] rest = line.split(";", -1);
                for (int i = 0; i < languages.size(); i++) {
                    final MemoryResourceBundle bundle = resourceBundleMap.get(languages.get(i));
                    bundle.putProperty(rest[1], rest[i + 2]);
                    bundle.putProperty(rest[0], rest[i + 2]);
                }
            });
            resourceBundleMap.put("", resourceBundleMap.get(languages.get(0))); // defaults to first language
        }
        profiler.start("Reading line info file");
        final File fLineInfo = new File("etc/sample/lhoist/input/FR_LHOISTP_01_Line_info_traffic_201412_(received from client 201412 and adapted by VBI).csv");
        final Map<String, LineInfoRecord> lineInfoByLine = Files
                .lines(fLineInfo.toPath(), StandardCharsets.ISO_8859_1)
                .skip(2)
                .filter(line -> !line.startsWith(";"))
                .map(LineInfoRecord::new)
                .collect(Collectors.toMap(LineInfoRecord::getLineNumber, Function.identity()));
        LOGGER.debug("count of lines in optifleet line info file: {}", lineInfoByLine.size());
        profiler.start("Reading martyr file");
        final String cdrFileName = "Call_data_records_Lhoist France_traffic_201505.txt";
        final File fMartyr = new File("etc/sample/lhoist/input/" + cdrFileName);
        final Map<String, List<CallDataRecord>> martyrsByLine = Files
                .lines(fMartyr.toPath(), StandardCharsets.ISO_8859_1)
                .skip(1)
                .map(CallDataRecord::new)
                .sorted()
                .collect(Collectors.groupingBy(CallDataRecord::getLine));
        LOGGER.debug("count of lines in martyr file: {}", martyrsByLine.size());
        final List<CallDataRecord> martyrs = new ArrayList<>();
        martyrsByLine.values().stream().forEach(martyrs::addAll);
        final CostRecord total = martyrs.stream().map(CallDataRecord::getCost).reduce(CostRecord.ZERO, CostRecord::combine);
        profiler.start("Computing summaries");
        final Collector<CallDataRecord, ?, CostRecord> reducing = Collectors.reducing(CostRecord.ZERO, CallDataRecord::getCost, CostRecord::combine);
        final Map<String, CostRecord> totalPerLine = martyrs.stream().collect(Collectors.groupingBy(CallDataRecord::getLine, reducing));
        final Map<String, CostRecord> totalPerLineWithoutSubscription = martyrs.stream().filter(cdr -> !cdr.isSubscription()).collect(Collectors.groupingBy(CallDataRecord::getLine, reducing));
        final Map<String, Map<String, CostRecord>> totalPerLinePerRemapping = martyrs.stream().collect(Collectors.groupingBy(CallDataRecord::getLine, Collectors.groupingBy(CallDataRecord::getRemapping, TreeMap::new, reducing)));
        final Map<String, Map<String, CostRecord>> totalPerLinePerRenaming = martyrs.stream().collect(Collectors.groupingBy(CallDataRecord::getLine, Collectors.groupingBy(CallDataRecord::getRenaming, TreeMap::new, reducing)));
        final Map<String, CostRecord> totalPerRemapping = martyrs.stream().collect(Collectors.groupingBy(CallDataRecord::getRemapping, reducing));
        final Map<String, String> remappingPerRenaming = martyrs.stream().collect(Collectors.groupingBy(CallDataRecord::getRenaming, Collectors.reducing(null, CallDataRecord::getRemapping, (remapping1, remapping2) -> remapping2)));
        final Set<String> lines = new TreeSet<>(totalPerLine.keySet());
        final int lineCount = lines.size();
        profiler.start("Computing positions");
        final Map<String, List<String>> positionsPerRemapping = new HashMap<>();
        for (final String remapping: totalPerRemapping.keySet()){
            positionsPerRemapping.put(remapping, totalPerLine.keySet().stream().sorted((line1, line2) -> CostRecord.compareByHistogram(totalPerLinePerRemapping.get(line1).get(remapping), totalPerLinePerRemapping.get(line2).get(remapping))).collect(Collectors.toList()));
        }
        final List<String> positions = totalPerLine.keySet().stream().sorted(Comparator.comparing(totalPerLine::get, CostRecord::compareByHistogram)).collect(Collectors.toList());
        final Map<String, Integer> positionPerLine = new HashMap<>();
        profiler.start("Computing ranges");
        final Map<Range, Integer> ranges = new TreeMap<>();
        for (int i = 0; i < BOUNDARIES.length - 1; i++){
            ranges.put(new Range(BOUNDARIES[i], BOUNDARIES[i + 1]), 0);
        }
        for (final CostRecord rec: totalPerLine.values()){
            final double cost = rec.getAmountForHistogram();
            for (final Map.Entry<Range, Integer> entry: ranges.entrySet()){
                if (entry.getKey().includes(cost)){
                    entry.setValue(entry.getValue() + 1);
                }
            }
        }
        profiler.start("Computing mean and median");
        final double mean = total.getAmountForHistogram() / lineCount;
        final List<CostRecord> costRecords2 = totalPerLine.values().stream().sorted(CostRecord::compareByHistogram).collect(Collectors.toList());
        final double median = costRecords2.size() == 0 ? 0 : costRecords2.get(costRecords2.size() / 2).getAmountForHistogram();
        try (
                final ZipOutputStream zos = new ZipOutputStream(new FileOutputStream("output.zip"));
                final PrintWriter pw = new PrintWriter(zos)
        ){
            profiler.start("Outputting individual files");
            for (final Map.Entry<String, List<CallDataRecord>> entry: martyrsByLine.entrySet()){
                final String line = entry.getKey();
                final CostRecord totalLine = totalPerLine.get(line);
                final double totalLineCost = totalLine == null ? 0 : totalLine.getAmountForHistogram();
                final CostRecord totalLineWithoutSubscription = totalPerLineWithoutSubscription.get(line);
                final double totalLineCostWithoutSubscription = totalLineWithoutSubscription == null ? 0 : totalLineWithoutSubscription.getAmountForHistogram();
                final int totalLineCountWithoutSubscription = totalLineWithoutSubscription == null ? 0 : totalLineWithoutSubscription.getCount();
                LineInfoRecord lineInfo = lineInfoByLine.get(line);
                if (lineInfo == null){
                    lineInfo = LineInfoRecord.DEFAULT;
                }
                final int position = lineInfo.isRanking() ? lineCount - positions.indexOf(line) : 0;
                positionPerLine.put(line, position);
                final String language = lineInfo.getLanguage();
                final ResourceBundle rb = ResourceBundle.getBundle("", Locale.forLanguageTag(language.toLowerCase()), new ResourceBundle.Control(){
                    @Override
                    public ResourceBundle newBundle(String baseName, Locale locale, String format, ClassLoader loader, boolean reload) throws IllegalAccessException, InstantiationException, IOException {
                        return resourceBundleMap.get(locale.toLanguageTag());
                    }
                });
                final Map<String, CostRecord> costByRenaming = totalPerLinePerRenaming.get(line);
                zos.putNextEntry(new ZipEntry(String.format("%s_(%s)_%s", line, lineInfo.getEmailForMuac(), cdrFileName)));
                pw.printf("%s", Stream.of("CS_1", "CS_2", "CS_3", "CS_4", "CS_5", "CS_6").map(rb::getString).collect(JOINING));
                int contest = 1; // TODO ?
                pw.printf(";;;;;;%s", Stream.of(totalLineCostWithoutSubscription, totalLineCost, position, totalLineCountWithoutSubscription, costByRenaming.size(), contest, median, mean).map(Object::toString).collect(JOINING));
                pw.printf(";%s", Stream.of(line, lineInfo.getIdentification1(), lineInfo.getLineNumber(), lineInfo.getIdentification1(), lineInfo.getIdentification2(), lineInfo.getDeviceType(), lineInfo.getOwnDevice(), lineInfo.getMuac(), lineInfo.getRanking(), lineInfo.getLanguage(), lineInfo.getEmailForMuac()).collect(JOINING));
                pw.printf(";%s", Stream.of("", "").collect(JOINING)); // reserved1 & reserved2
                pw.printf(";%s", Stream.of(lineInfo.getCompany(), lineInfo.getSite(), lineInfo.getGroupDepartment(), lineInfo.getUserId(), lineInfo.getCostCenter(), lineInfo.getAccountNumber(), lineInfo.getSubAccountNumber(), lineInfo.getProjectId(), lineInfo.getMnoProvider(), lineInfo.getMnoAccountNumber(), lineInfo.getCustomerAccountNumber()).collect(JOINING));
                pw.printf(";%s", ""); // reserved3
                pw.printf(";%s", Stream.of(lineInfo.getManagerEmail1(), lineInfo.getManagerEmail2(), lineInfo.getBccEmail(), lineInfo.getDynamicWarning1(), lineInfo.getDynamicWarning2()).collect(JOINING));
                pw.printf(";%s", Stream.of("", "", "").collect(JOINING)); // reserved4, reserved5 & reserved6
                pw.printf(";%s", Stream.of(lineInfo.getDataNationalMb(), lineInfo.getDataNationalSub(), lineInfo.getDataRoamingMb(), lineInfo.getDataRoamingSub(), lineInfo.getThresholdAmount(), lineInfo.getBudget(), lineInfo.getThresholdAmountVoice()).collect(JOINING));
                pw.printf(";%s", Stream.of("", "", "").collect(JOINING)); // reserved7, reserved8 & reserved9
                pw.printf(";%s", Stream.of("HIST_1", "HIST_2", "HIST_3", "HIST_4", "HIST_5", "HIST_6").map(rb::getString).collect(JOINING));
                pw.printf(";%s%n", lineCount);
                costByRenaming.entrySet().stream().forEach(kv -> {
                    final String renaming = kv.getKey();
                    final CostRecord rec = kv.getValue();
                    pw.printf("%s%n", Stream.of(renaming, rb.getString(remappingPerRenaming.get(renaming)), rec.getCount(), rec.getUnits(), rec.getAmountForHistogram(), rec.getCostPerUnit()).map(Object::toString).collect(JOINING));
                });
                pw.printf("%s%n", Stream.of(rb.getString("CS_7"), "", "", "", totalLineCostWithoutSubscription).map(Object::toString).collect(JOINING));
                pw.printf("%s%n", Stream.of(rb.getString("CS_8"), "", "", "", totalLineCost).map(Object::toString).collect(JOINING));
                pw.println();
                pw.printf("%s%n", Stream.of("TR_1", "TR_2", "TR_3").map(rb::getString).collect(JOINING));
                final Map<String, CostRecord> costByRemapping = totalPerLinePerRemapping.get(line);
                costByRemapping.entrySet().stream().filter(kv -> kv.getValue().getAmountForHistogram() != 0).forEach(kv -> {
                    final String remapping = kv.getKey();
                    final CostRecord rec = kv.getValue();
                    final CostRecord totalRec = totalPerRemapping.get(remapping);
                    final double deviation = rec.getAmountForHistogram() - (totalRec.getAmountForHistogram() / lineCount);
                    pw.printf("%s%n", Stream.of(rb.getString(remapping), lineCount - positionsPerRemapping.get(remapping).indexOf(line), deviation).map(Object::toString).collect(JOINING));
                });
                pw.printf("%s%n", Stream.of(rb.getString("TR_14"), position, totalLineCost - (total.getAmountForHistogram() / lineCount)).map(Object::toString).collect(JOINING));
                pw.printf("%s%n", Stream.of(rb.getString("TR_15"), lineCount).map(Object::toString).collect(JOINING));
                for (final Map.Entry<Range, Integer> entry2: ranges.entrySet()){
                    if (entry2.getKey().includes(totalLineCost)){
                        pw.printf("%s%n", Stream.of(rb.getString("TR_2"), entry2.getValue(), entry2.getValue()).map(Object::toString).collect(JOINING));
                    } else{
                        pw.printf("%s%n", Stream.of(entry2.getKey().getLower(), entry2.getValue()).map(Object::toString).collect(JOINING));
                    }
                }
                pw.println();
                pw.printf("%s%n", rb.getString("CD_1"));
                pw.printf("%s%n", Stream.of("CD_2", "CD_3", "CD_4", "CD_5", "CD_6", "CD_7", "CD_8").map(rb::getString).collect(JOINING));
                martyrsByLine.get(line).stream().filter(cdr -> !cdr.isSubscription()).forEach(cdr -> {
                    pw.printf("%s%n", Stream.of(rb.getString(cdr.getRemapping()), cdr.getRenaming(), cdr.getDestinationService(), cdr.getWhen() == null ? "" : CallDataRecord.INPUT_DATE_TIME_FORMATTER.format(cdr.getWhen()), cdr.getDestinationNumber().length() == 0 ? NO_NUMBER : cdr.getDestinationNumber(), cdr.getCost().getUnits(), cdr.getCost().getAmountForHistogram(), cdr.getWhenDateAsCommaSeparatedString()).map(Object::toString).collect(JOINING));
                });
                pw.printf("%s%n", Stream.of(" #Appels/Oproepen/Calls:", totalLineCountWithoutSubscription).map(Object::toString).collect(JOINING));
                pw.flush();
                zos.closeEntry();
            }
            profiler.start("Outputting overview file");
            zos.putNextEntry(new ZipEntry(String.format("Overview_par_GSM_sur_base_de_Call_data_records_%s", cdrFileName)));
            pw.printf("%sSUMMARY;;;", semicolons(LineInfoRecord.TITLES.length + 2)); // 2 for Operator and Account
            for (final Ranking ranking: Ranking.values()){
                pw.printf("%s;;;", ranking);
            }
            pw.println(";;;"); // this is strange since there is only one field, the ranking
            pw.printf("%sUnits;Gross Amount;Net_Amount;", semicolons(LineInfoRecord.TITLES.length + 2));
            for (int i = 0; i < Ranking.values().length; i++){
                pw.printf("UNITS;UNITS;COSTS;");
            }
            pw.println();
            for (final String title: LineInfoRecord.TITLES){
                pw.printf("%s;", title);
            }
            pw.printf("Operator;Account;%s;%s;%s;", total.getUnits(), total.getAmountGross(), total.getAmountNet());
            for (final Ranking ranking: Ranking.values()){
                final CostRecord costRecord = totalPerRemapping.get(ranking.toString());
                if (costRecord != null){
                    pw.printf("%s;%s;%s;", costRecord.getCount(), costRecord.getUnits(), costRecord.getAmountNet());
                } else {
                    pw.print("0;0;0;");
                }
            }
            pw.println();
            for (final String line: lines){
                final LineInfoRecord lineInfo = lineInfoByLine.get(line);
                if (lineInfo == null){
                    pw.printf("%s;Line_not_identified;%s", line, semicolons(LineInfoRecord.TITLES.length - 2));
                } else{
                    pw.printf("%s;", lineInfo.getData());
                }
                final CallDataRecord callData = martyrsByLine.get(line).get(0);
                pw.printf("%s;%s;", callData.getOperator(), callData.getAccountNumber().trim());
                final CostRecord totalCostRecord = totalPerLine.get(line);
                pw.printf("%s;%s;%s;", totalCostRecord.getUnits(), totalCostRecord.getAmountGross(), totalCostRecord.getAmountNet());
                for (final Ranking ranking: Ranking.values()){
                    final CostRecord costRecord = totalPerLinePerRemapping.get(line).get(ranking.toString());
                    if (costRecord != null){
                        pw.printf("%s;%s;%s;", costRecord.getCount(), costRecord.getUnits(), costRecord.getAmountNet());
                    } else {
                        pw.print("0;0;0;");
                    }
                }
                pw.println(positionPerLine.get(line) == 0 ? "NotRanked" : positionPerLine.get(line));
            }
            pw.printf("%s%n%n", "FIN OVERVIEW");
            pw.flush();
            zos.closeEntry();
            profiler.stop().log();
        }
    }
}
