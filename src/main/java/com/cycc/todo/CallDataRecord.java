package com.cycc.todo;

/**
 * Created by jpc on 3/07/2015.
 */
public class CallDataRecord implements Comparable<CallDataRecord> {
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

    public CallDataRecord(String s){
        this(s.split(";", -1));
    }

    public CallDataRecord(final String[] data) {
        this.line = data[26 + 0];
        this.histogram = data[26 + 3];
        this.remapping = data[26 + 4];
        this.renaming = data[26 + 5];
        this.destinationService = data[26 + 6];
        this.destinationNumber = data[26 + 7];
        this.when = data[26 + 10];
        this.included = Boolean.parseBoolean(data[26 + 19]);
        double units = Double.parseDouble(data[26 + 12]);
        if ("DURATION".equals(data[26 + 11])){
            units = units / 60.0;
        }
        final double amountGross = Double.parseDouble(data[26 + 15]);
        final double amountNet = Double.parseDouble(data[26 + 16]);
        final double amountForHistogram = Double.parseDouble(data[26 + 17]);
        final double amountForMuac = Double.parseDouble(data[26 + 18]);
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

    @Override
    public int compareTo(CallDataRecord o) {
        return when.compareTo(o.when);
    }
}
