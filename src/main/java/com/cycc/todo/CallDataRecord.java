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
    private int count;
    private BigDecimal units;
    private BigDecimal cost;

    public CallDataRecord() {
    }

    public CallDataRecord(String renaming){
        this.renaming = renaming;
        this.units = BigDecimal.ZERO;
        this.cost = BigDecimal.ZERO;
    }

    public CallDataRecord(final String[] data) {
        this.line = data[26 + 0];
        this.histogram = data[26 + 3];
        this.remapping = data[26 + 4];
        this.renaming = data[26 + 5];
        this.included = Boolean.parseBoolean(data[26 + 19]);
        this.count = 1;
        this.units = new BigDecimal(data[26 + 12]).setScale(4, BigDecimal.ROUND_CEILING);
        if ("DURATION".equals(data[26 + 11])){
            this.units = this.units.divide(SIXTY, RoundingMode.CEILING).setScale(4, BigDecimal.ROUND_CEILING);
        }
        this.cost = new BigDecimal(data[26 + 17]).setScale(4, BigDecimal.ROUND_CEILING);
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

    public int getCount() {
        return count;
    }

    public BigDecimal getUnits() {
        return units;
    }

    public BigDecimal getCost() {
        return cost;
    }

    public BigDecimal getCostPerUnit() {
        return this.units.signum() == 0 ? BigDecimal.ZERO : this.cost.divide(this.units, RoundingMode.CEILING);
    }

    public CallDataRecord combine(CallDataRecord rec){
        final CallDataRecord combined = new CallDataRecord();
        combined.line = this.line;
        combined.renaming = this.renaming;
        combined.histogram = this.histogram;
        combined.remapping = this.remapping;
        combined.included = this.included;
        combined.count = this.count++;
        combined.units = this.units.add(rec.units);
        combined.cost = this.cost.add(rec.cost);
        return combined;
    }
}
