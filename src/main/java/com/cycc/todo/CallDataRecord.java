package com.cycc.todo;

import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;

/**
 * Created by jpc on 3/07/2015.
 */
public class CallDataRecord {
    public static final BigDecimal SIXTY = new BigDecimal(60.0);
    private String line;
    private String renaming;
    private String histogram;
    private String remapping;
    private boolean included;
    private CostRecord cost;

    public CallDataRecord() {
    }

    public CallDataRecord(String renaming){
        this.renaming = renaming;
        this.cost = new CostRecord();
    }

    public CallDataRecord(final String[] data) {
        this.line = data[26 + 0];
        this.histogram = data[26 + 3];
        this.remapping = data[26 + 4];
        this.renaming = data[26 + 5];
        this.included = Boolean.parseBoolean(data[26 + 19]);
        BigDecimal units = new BigDecimal(data[26 + 12]).setScale(4, BigDecimal.ROUND_CEILING);
        if ("DURATION".equals(data[26 + 11])){
            units = units.divide(SIXTY, RoundingMode.CEILING).setScale(4, BigDecimal.ROUND_CEILING);
        }
        this.cost = new CostRecord(1, units, new BigDecimal(data[26 + 17]).setScale(4, BigDecimal.ROUND_CEILING));
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
