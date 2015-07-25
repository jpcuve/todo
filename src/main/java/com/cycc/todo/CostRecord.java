package com.cycc.todo;

import java.math.BigDecimal;

/**
 * Created by jpc on 7/8/15.
 */
public class CostRecord {
    private final int count;
    private final BigDecimal units;
    private final BigDecimal amountGross;
    private final BigDecimal amountNet;
    private final BigDecimal amountForHistogram;
    private final BigDecimal amountForMuac;

    public CostRecord(int count, BigDecimal units, BigDecimal amountGross, BigDecimal amountNet, BigDecimal amountForHistogram, BigDecimal amountForMuac) {
        this.count = count;
        this.units = units;
        this.amountGross = amountGross;
        this.amountNet = amountNet;
        this.amountForHistogram = amountForHistogram;
        this.amountForMuac = amountForMuac;
    }

    public int getCount() {
        return count;
    }

    public BigDecimal getUnits() {
        return units;
    }

    public BigDecimal getAmountGross() {
        return amountGross;
    }

    public BigDecimal getAmountNet() {
        return amountNet;
    }

    public BigDecimal getAmountForHistogram() {
        return amountForHistogram;
    }

    public BigDecimal getAmountForMuac() {
        return amountForMuac;
    }

    public BigDecimal getCostPerUnit(){
        return units.signum() == 0 ? BigDecimal.ZERO : amountForHistogram.divide(units, 4, BigDecimal.ROUND_CEILING);
    }
}
