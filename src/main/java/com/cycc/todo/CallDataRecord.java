package com.cycc.todo;

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 * Created by jpc on 3/07/2015.
 */
public class CallDataRecord {
    public static final BigDecimal SIXTY = new BigDecimal(60.0);
    private static final String[] EMPTY_DATE = { "", "", "" };
    private final String line;
    private final String renaming;
    private final String histogram;
    private final String remapping;
    private final String destinationService;
    private final String destinationNumber;
    private final String when;
    private final boolean included;
    private final CostRecord cost;

    public CallDataRecord(final String[] data) {
        this.line = data[26 + 0];
        this.histogram = data[26 + 3];
        this.remapping = data[26 + 4];
        this.renaming = data[26 + 5];
        this.destinationService = data[26 + 6];
        this.destinationNumber = data[26 + 7];
        this.when = data[26 + 10];
        this.included = Boolean.parseBoolean(data[26 + 19]);
        BigDecimal units = new BigDecimal(data[26 + 12]).setScale(4, BigDecimal.ROUND_CEILING);
        if ("DURATION".equals(data[26 + 11])){
            units = units.divide(SIXTY, RoundingMode.CEILING).setScale(4, BigDecimal.ROUND_CEILING);
        }
        final BigDecimal amountGross = new BigDecimal(data[26 + 15]).setScale(4, BigDecimal.ROUND_CEILING);
        final BigDecimal amountNet = new BigDecimal(data[26 + 16]).setScale(4, BigDecimal.ROUND_CEILING);
        final BigDecimal amountForHistogram = new BigDecimal(data[26 + 17]).setScale(4, BigDecimal.ROUND_CEILING);
        final BigDecimal amountForMuac = new BigDecimal(data[26 + 18]).setScale(4, BigDecimal.ROUND_CEILING);
        this.cost = new CostRecord(1, units, amountGross, amountNet, amountForHistogram, amountForMuac);
    }

    public String[] getWhenDateAsCommaSeparatedString(){
        String[] ds = EMPTY_DATE;
        if (when != null && when.length() > 0){
            ds = when.substring(0, when.indexOf(' ')).split("/");
            ds[2] = ds[2].substring(2);
        }
        return ds;
    }

    public Key getKey(){
        return new Key(line, renaming, remapping);
    }

    public CostRecord getCost() {
        return cost;
    }

    public String getLine() {
        return line;
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

    public String getWhen() {
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
}
