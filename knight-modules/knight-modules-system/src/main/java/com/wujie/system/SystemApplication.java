package com.wujie.system;

import com.wujie.common.security.annotation.EnableCustomConfig;
import com.wujie.common.security.annotation.EnableRyFeignClients;
import com.wujie.common.swagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

/**
 * 系统模块
 *
 * @author wujie
 */
@EnableCustomConfig
@EnableCustomSwagger2
@EnableRyFeignClients
@SpringCloudApplication
public class SystemApplication
{
    public static void main( String[] args )
    {
        SpringApplication.run(SystemApplication.class, args);
    }
}
