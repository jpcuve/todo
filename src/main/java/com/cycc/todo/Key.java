package com.cycc.todo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: jpc
 * Date: 5/16/13
 * Time: 3:25 PM
 * To change this template use File | Settings | File Templates.
 */
public class Key implements Comparable<Key> {
    private final Key parentKey;
    private final Comparable lastComponent;

    public Key(Comparable component) {
        this(null, component);
    }

    public Key(Key parentKey, Comparable lastComponent) {
        if (lastComponent == null){
            throw new IllegalArgumentException("Component cannot be null");
        }
        this.parentKey = parentKey;
        this.lastComponent = lastComponent;
    }

    public Key(Comparable[] components, int length) {
        this(length > 1 ? new Key(components, length - 1) : null, components[length - 1]);
    }

    public Key(Comparable... components){
        this(components.length > 1 ? new Key(components, components.length - 1) : null, components[components.length - 1]);
    }

    public Key getParentKey() {
        return parentKey;
    }

    public Comparable getLastComponent() {
        return lastComponent;
    }

    public int size() {
        int count = 0;
        for (Key key = this; key != null; key = key.parentKey){
            count++;
        }
        return count;
    }

    public List<Comparable> getPath() {
        final List<Comparable> list = new ArrayList<>();
        for (Key key = this; key != null; key = key.parentKey){
            list.add(0, key.lastComponent);
        }
        return list;
    }

    public Comparable getComponent(int index) {
        int count = size();
        if (index < 0 || index >= count){
            throw new IllegalArgumentException("Out of range");
        }
        Key key = this;
        for (int i = count - 1; i != index; i--) key = key.parentKey;
        return key.lastComponent;
    }

    public boolean equals(Object o) {
        if (o == this) return true;
        if (o instanceof Key) {
            Key oKey = (Key) o;
            if (oKey.size() != size()) return false;
            for (Key path = this; path != null; path = path.parentKey) {
                if (!path.lastComponent.equals(oKey.lastComponent)){
                    return false;
                }
                oKey = oKey.parentKey;
            }
            return true;
        }
        return false;
    }

    public String toString() {
        final StringBuilder sb = new StringBuilder("[");
        boolean comma = false;
        for (final Comparable component : this.getPath()){
            if (comma) sb.append(",");
            sb.append(component);
            comma = true;
        }
        sb.append("]");
        return sb.toString();
    }

    public int hashCode() {
        return lastComponent.hashCode() + (parentKey == null ? 0 : parentKey.hashCode());
    }

    @Override
    public int compareTo(Key oKey) {
        int count = size();
        int oCount = oKey.size();
        for (int i = 0; i < Math.min(count, oCount); i++){
            final Comparable component = getComponent(i);
            int comp = component.compareTo(oKey.getComponent(i));
            if (comp != 0){
                return comp;
            }
        }
        return count - oCount;
    }
}
