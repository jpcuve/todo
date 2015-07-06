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
public class Path<E extends Comparable<E>> implements Comparable<Path<E>> {
    private final Path<E> parentPath;
    private final E lastPathComponent;

    public Path(E e) {
        if (e == null) throw new IllegalArgumentException("Cannot be null");
        parentPath = null;
        lastPathComponent = e;
    }

    public Path(Path<E> parentPath, E lastPathComponent) {
        this.parentPath = parentPath;
        this.lastPathComponent = lastPathComponent;
    }

    public Path(E[] components, int length) {
        lastPathComponent = components[length - 1];
        parentPath = length > 1 ? new Path<>(components, length - 1) : null;
    }

    @SafeVarargs
    public Path(E... components){
        lastPathComponent = components[components.length - 1];
        parentPath = components.length > 1 ? new Path<>(components, components.length - 1) : null;
    }

    public Path<E> getParentPath() {
        return parentPath;
    }

    public E getLastPathComponent() {
        return lastPathComponent;
    }

    public int getPathCount() {
        int count = 0;
        for (Path<E> path = this; path != null; path = path.parentPath) count++;
        return count;
    }

    public List<E> getPath() {
        final List<E> list = new ArrayList<>();
        for (Path<E> path = this; path != null; path = path.parentPath) list.add(0, path.lastPathComponent);
        return list;
    }

    public E getPathComponent(int index) {
        int count = getPathCount();
        if (index < 0 || index >= count) throw new IllegalArgumentException("Out of range");
        Path<E> path = this;
        for (int i = count - 1; i != index; i--) path = path.parentPath;
        return path.lastPathComponent;
    }

    public boolean isDescendant(Path aPath) {
        if (aPath == this) return true;
        if (aPath != null) {
            int pathCount = getPathCount();
            int aPathCount = aPath.getPathCount();
            if (aPathCount < pathCount) return false;
            while (aPathCount-- > pathCount) aPath = aPath.parentPath;
            return equals(aPath);
        }
        return false;
    }

    public Path<E> pathByAddingChild(E child) {
        if (child == null) throw new NullPointerException("Null child not allowed");
        return new Path<>(this, child);
    }

    public boolean equals(Object o) {
        if (o == this) return true;
        if (o instanceof Path) {
            Path oPath = (Path) o;
            if (oPath.getPathCount() != getPathCount()) return false;
            for (Path<E> path = this; path != null; path = path.parentPath) {
                if (!path.lastPathComponent.equals(oPath.lastPathComponent)) return false;
                oPath = oPath.parentPath;
            }
            return true;
        }
        return false;
    }

    public String toString() {
        final StringBuilder sb = new StringBuilder("[");
        boolean comma = false;
        for (final E e : this.getPath()){
            if (comma) sb.append(",");
            sb.append(e);
            comma = true;
        }
        sb.append("]");
        return sb.toString();
    }

    public int hashCode() {
        return lastPathComponent.hashCode() + (parentPath == null ? 0 : parentPath.hashCode());
    }

    @Override
    public int compareTo(Path<E> oPath) {
        int count = getPathCount();
        int oCount = oPath.getPathCount();
        for (int i = 0; i < Math.min(count, oCount); i++){
            int comp = getPathComponent(i).compareTo(oPath.getPathComponent(i));
            if (comp != 0){
                return comp;
            }
        }
        return count - oCount;
    }
}
