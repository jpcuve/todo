package com.cycc.todo;

/**
 * Created by jpc on 7/8/15.
 */
public class CostRecord {
    public static final CostRecord ZERO = new CostRecord(0, 0.0, 0.0, 0.0, 0.0, 0.0);
    private final int count;
    private final double units;
    private final double amountGross;
    private final double amountNet;
    private final double amountForHistogram;
    private final double amountForMuac;

    public CostRecord(int count, double units, double amountGross, double amountNet, double amountForHistogram, double amountForMuac) {
        this.count = count;
        this.units = units;
        this.amountGross = amountGross;
        this.amountNet = amountNet;
        this.amountForHistogram = amountForHistogram;
        this.amountForMuac = amountForMuac;
    }

    public static CostRecord combine(CostRecord cr1, CostRecord cr2){
        return new CostRecord(cr1.count + cr2.count, cr1.units + cr2.units, cr1.amountGross + cr2.amountGross, cr1.amountNet + cr2.amountNet, cr1.amountForHistogram + cr2.amountForHistogram, cr1.amountForMuac + cr2.amountForMuac);
    }

    public int getCount() {
        return count;
    }

    public double getUnits() {
        return units;
    }

    public double getAmountGross() {
        return amountGross;
    }

    public double getAmountNet() {
        return amountNet;
    }

    public double getAmountForHistogram() {
        return amountForHistogram;
    }

    public double getAmountForMuac() {
        return amountForMuac;
    }

    public double getCostPerUnit(){
        return units == 0 ? 0 : amountForHistogram / units;
    }
}
