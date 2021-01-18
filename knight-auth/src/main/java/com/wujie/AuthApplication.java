package com.wujie;

import com.wujie.common.security.annotation.EnableRyFeignClients;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

/**
 * 认证授权中心
 *
 * @author wujie
 */
@EnableRyFeignClients
@SpringCloudApplication
public class AuthApplication
{
    public static void main( String[] args )
    {
        SpringApplication.run(AuthApplication.class, args);
    }
}
