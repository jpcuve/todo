package com.cycc.todo;

import java.math.BigDecimal;

/**
 * Created by jpc on 7/23/15.
 */
public class Range implements Comparable<Range> {
    private final BigDecimal lower;
    private final BigDecimal upper;

    public Range(int lower, int upper){
        this(new BigDecimal(lower), new BigDecimal(upper));
    }

    public Range(BigDecimal lower, BigDecimal upper) {
        this.lower = lower;
        this.upper = upper;
    }

    public BigDecimal getLower() {
        return lower;
    }

    public BigDecimal getUpper() {
        return upper;
    }

    public boolean includes(BigDecimal test){
        return test.compareTo(lower) >= 0 && test.compareTo(upper) < 0;
    }

    @Override
    public int compareTo(Range o) {
        if (o == null){
            return 1;
        }
        return lower.compareTo(o.lower);
    }
}
