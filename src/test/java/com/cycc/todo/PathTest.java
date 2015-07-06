package com.cycc.todo;

/**
 * Created by jpc on 7/6/15.
 */
public class PathTest {
    public void testPath(){
        final Path<String> p1 = new Path<>("a", "b", "c");
        System.out.println(p1.compareTo(p1));
        System.out.println(p1.compareTo(new Path<>("a", "b", "e")));
        System.out.println(p1.compareTo(new Path<>("a", "b", "a")));
        System.out.println(p1.compareTo(new Path<>("a")));
        System.out.println(p1.compareTo(new Path<>("a", "b")));
        System.out.println(p1.compareTo(new Path<>("a", "b", "c", "d")));

    }
}
