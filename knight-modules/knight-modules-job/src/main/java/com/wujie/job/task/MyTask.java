package com.wujie.job.task;

import org.springframework.stereotype.Component;
import com.wujie.common.core.utils.StringUtils;

/**
 * 定时任务调度测试
 * 
 * @author wujie
 */
@Component("myTask")
public class MyTask
{
    public void myMultipleParams(String s, Boolean b, Long l, Double d, Integer i)
    {
        System.out.println(StringUtils.format("执行多参方法： 字符串类型{}，布尔类型{}，长整型{}，浮点型{}，整形{}", s, b, l, d, i));
    }

    public void myParams(String params)
    {
        System.out.println("执行有参方法：" + params);
    }

    public void myNoParams()
    {
        System.out.println("执行无参方法");
    }
}
