package com.cristik.pattern.bridge;

import com.cristik.pattern.bridge.abstra.People;

/**
 * @Package: com.cristik.pattern.bridge.Man
 * @ClassName: Man.java
 * @Description:
 * @Author: zhenghua
 * @CreateDate: 2016/6/14 15:22
 * @Version: v1.0
 */
public class Man extends People {

    @Override
    public void run() {
        super.run();
        System.out.print("男人开着");
        road.run();
    }
}
