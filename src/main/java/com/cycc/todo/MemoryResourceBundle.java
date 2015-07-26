package com.cycc.todo;

import java.util.*;

/**
 * Created by jpc on 26/07/15.
 */
public class MemoryResourceBundle extends ResourceBundle {
    private Map<String, String> map = new HashMap<>();

    public void putProperty(String key, String property){
        map.put(key, property);
    }

    @Override
    protected Object handleGetObject(String key) {
        return map.get(key);
    }

    @Override
    public Enumeration<String> getKeys() {
        return Collections.enumeration(map.keySet());
    }
}
