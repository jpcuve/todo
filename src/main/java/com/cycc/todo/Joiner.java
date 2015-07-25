package com.cycc.todo;

/**
 * Created by jpc on 25/07/15.
 */
public class Joiner {
    private final String separator;

    private Joiner(String separator) {
        this.separator = separator;
    }

    public String join(Object... os){
        final StringBuilder sb = new StringBuilder();
        boolean sep = false;
        for (final Object o: os){
            if (sep){
                sb.append(separator);
            }
            sb.append(o == null ? "null" : o.toString());
            sep = true;
        }
        return sb.toString();
    }

    public static Joiner on(String separator){
        return new Joiner(separator);
    }
}
