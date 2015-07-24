package com.cycc.todo;

/**
 * Created by jpc on 3/07/2015.
 */
public class LineInfoRecord {
    private final String data;
    private String line;
    private String name;
    private String email;
    private String language;

    public LineInfoRecord() {
        this(";;;;;;;EN;");
    }

    public LineInfoRecord(final String data) {
        this.data = data;
        final String[] ss = data.split(";", -1);
        this.line = ss[0];
        this.name = ss[1];
        this.language = ss[7];
        this.email = ss[8];
    }

    public String getData() {
        return data;
    }

    public String getLine() {
        return line;
    }

    public String getEmail() {
        return email;
    }

    public String getLanguage() {
        return language;
    }

    public String getName() {
        return name;
    }
}
