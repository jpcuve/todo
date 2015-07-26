package com.cycc.todo;

import java.math.BigDecimal;

/**
 * Created by jpc on 7/8/15.
 */
public class CostRecord {
    public static final CostRecord ZERO = new CostRecord(1, BigDecimal.ZERO, BigDecimal.ZERO, BigDecimal.ZERO, BigDecimal.ZERO, BigDecimal.ZERO);
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

    public static CostRecord combine(CostRecord cr1, CostRecord cr2){
        return new CostRecord(cr1.count + cr2.count, cr1.units.add(cr2.units), cr1.amountGross.add(cr2.amountGross), cr1.amountNet.add(cr2.amountNet), cr1.amountForHistogram.add(cr2.amountForHistogram), cr1.amountForMuac.add(cr2.amountForMuac));
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
