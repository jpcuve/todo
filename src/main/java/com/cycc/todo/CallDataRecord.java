package com.cycc.todo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Created by jpc on 3/07/2015.
 */
public class CallDataRecord implements Comparable<CallDataRecord> {
    public static final DateTimeFormatter INPUT_DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
    private static final DateTimeFormatter OUTPUT_DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("dd;MM;yyyy");
    private static final String[] EMPTY_DATE = { "", "", "" };
    private final String line;
    private final String operator;
    private final String accountNumber;
    private final String renaming;
    private final String histogram;
    private final String remapping;
    private final String destinationService;
    private final String destinationNumber;
    private final LocalDateTime when;
    private final boolean included;
    private final CostRecord cost;

    public CallDataRecord(String s){
        this(s.split(";", -1));
    }

    public CallDataRecord(final String[] data) {
        this.line = data[26 + 0];
        this.operator = data[26 + 1];
        this.accountNumber = data[26 + 2];
        this.histogram = data[26 + 3];
        this.remapping = data[26 + 4];
        this.renaming = data[26 + 5];
        this.destinationService = data[26 + 6];
        this.destinationNumber = data[26 + 7];
        this.when = data[26 + 10].length() == 0 ? null : LocalDateTime.parse(data[26 + 10], INPUT_DATE_TIME_FORMATTER);
        this.included = Boolean.parseBoolean(data[26 + 19]);
        double units = Double.parseDouble(data[26 + 12]);
        if ("DURATION".equals(data[26 + 11])){
            units = units / 60.0;
        }
        final double amountGross = Double.parseDouble(data[26 + 15]);
        final double amountNet = Double.parseDouble(data[26 + 16]);
        final double amountForHistogram = Double.parseDouble(data[26 + 17]);
        final double amountForMuac = Double.parseDouble(data[26 + 18]);
        this.cost = new CostRecord(1, units, amountGross, amountNet, amountForHistogram, amountForMuac);
    }

    public String getWhenDateAsCommaSeparatedString(){
        return when == null ? ";;" : OUTPUT_DATE_TIME_FORMATTER.format(when);
    }

    public CostRecord getCost() {
        return cost;
    }

    public String getLine() {
        return line;
    }

    public String getOperator() {
        return operator;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public String getRenaming() {
        return renaming;
    }

    public String getRemapping() {
        return remapping;
    }

    public String getDestinationService() {
        return destinationService;
    }

    public String getDestinationNumber() {
        return destinationNumber;
    }

    public LocalDateTime getWhen() {
        return when;
    }

    public String getHistogram() {
        return histogram;
    }

    public boolean isIncluded() {
        return included;
    }

    public boolean isSubscription(){
        return "SUBSCRIPTION".equals(histogram);
    }

    @Override
    public int compareTo(CallDataRecord o) {
        return when == null ? -1 : (o.when == null ? 1 : when.compareTo(o.when));
    }
}
