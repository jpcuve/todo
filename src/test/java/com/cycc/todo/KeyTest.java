package com.cycc.todo;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 * Created by jpc on 7/6/15.
 */
public class KeyTest {

    @Test
    public void testPath(){
        final Key p1 = new Key("a", "b", "c");
        assertTrue("path1", p1.compareTo(p1) == 0);
        assertTrue("path2", p1.compareTo(new Key("a", "b", "e")) < 0);
        assertTrue("path3", p1.compareTo(new Key("a", "b", "a")) > 0);
        assertTrue("path4", p1.compareTo(new Key("a")) > 0);
        assertTrue("path5", p1.compareTo(new Key("a", "b")) > 0);
        assertTrue("path6", p1.compareTo(new Key("a", "b", "c", "d")) < 0);

    }
}
