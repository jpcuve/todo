package com.cycc.todo;

import java.math.BigDecimal;

/**
 * Created by jpc on 7/8/15.
 */
public class CostRecord {
    private int count = 1;
    private BigDecimal units = BigDecimal.ZERO;
    private BigDecimal cost = BigDecimal.ZERO;

    public CostRecord() {
    }

    public CostRecord(int count, BigDecimal units, BigDecimal cost) {
        this.count = count;
        this.units = units;
        this.cost = cost;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public BigDecimal getUnits() {
        return units;
    }

    public void setUnits(BigDecimal units) {
        this.units = units;
    }

    public BigDecimal getCost() {
        return cost;
    }

    public void setCost(BigDecimal cost) {
        this.cost = cost;
    }

    public BigDecimal getCostPerUnit(){
        return units.signum() == 0 ? BigDecimal.ZERO : cost.divide(units, 4, BigDecimal.ROUND_CEILING);
    }
}
