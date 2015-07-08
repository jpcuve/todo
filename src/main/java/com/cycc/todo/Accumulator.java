package com.cycc.todo;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 * Created by jpc on 7/8/15.
 */
public abstract class Accumulator<E> extends HashMap<Key, E> {

    public void accumulate(Key key, E e){
        E existing = get(key);
        put(key, existing == null ? e : accumulate(existing, e));
    }

    public abstract E accumulate(E e1, E e2);

    public E extractSingle(){
        if (size() != 1){
            throw new IllegalArgumentException("Accumulator has more than one element");
        }
        E e = null;
        for (final Map.Entry<Key, E> entry: entrySet()){
            e = entry.getValue();
        }
        return e;
    }

    public <F> Map<F, E> extractMap(){
        final Map<F, E> map = new TreeMap<>();
        for (final Map.Entry<Key, E> entry: entrySet()){
            final Key key = entry.getKey();
            if (key.size() != 1){
                throw new IllegalArgumentException("Invalid key size");
            }
            final F f = (F) key.getComponent(0);
            map.put(f, entry.getValue());
        }
        return map;
    }

    public <F, G> Map<F, Map<G, E>> extractTable(){
        final Map<F, Map<G, E>> map1 = new TreeMap<>();
        for (final Map.Entry<Key, E> entry: entrySet()){
            final Key key = entry.getKey();
            if (key.size() != 2){
                throw new IllegalArgumentException("Invalid key size");
            }
            final F f = (F) key.getComponent(0);
            final G g = (G) key.getComponent(1);
            Map<G, E> map2 = map1.get(f);
            if (map2 == null){
                map2 = new TreeMap<>();
                map1.put(f, map2);
            }
            map2.put(g, entry.getValue());
        }
        return map1;
    }
}
