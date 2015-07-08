package com.cycc.todo;

/**
 * Created by jpc on 7/8/15.
 */
public class CostAccumulator extends Accumulator<CostRecord> {
    @Override
    public CostRecord accumulate(CostRecord e1, CostRecord e2) {
        return new CostRecord(e1.getCount() + e2.getCount(), e1.getUnits().add(e2.getUnits()), e1.getCost().add(e2.getCost()));
    }
}
