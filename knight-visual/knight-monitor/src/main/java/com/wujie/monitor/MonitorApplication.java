package com.wujie.monitor;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

/**
 * 监控中心
 *
 * @author wujie
 */
@EnableAdminServer
@SpringCloudApplication
public class MonitorApplication
{
    public static void main( String[] args )
    {
        SpringApplication.run(MonitorApplication.class,args);
    }
}
