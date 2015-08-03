package com.cycc.todo;

/**
 * Created by jpc on 7/23/15.
 */
public class Range implements Comparable<Range> {
    private final double lower;
    private final double upper;

    public Range(double lower, double upper) {
        this.lower = lower;
        this.upper = upper;
    }

    public double getLower() {
        return lower;
    }

    public double getUpper() {
        return upper;
    }

    public boolean includes(double test){
        return Math.signum(test - lower) >= 0 && Math.signum(test - upper) < 0;
    }

    @Override
    public int compareTo(Range o) {
        if (o == null){
            return 1;
        }
        return (int) Math.signum(lower - o.lower);
    }
}
