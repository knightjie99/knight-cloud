package com.wujie;


import com.wujie.common.security.annotation.EnableCustomConfig;
import com.wujie.common.security.annotation.EnableRyFeignClients;
import com.wujie.common.swagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

/**
 * 代码生成
 *
 * @author wujie
 */
@EnableCustomConfig
@EnableCustomSwagger2
@EnableRyFeignClients
@SpringCloudApplication
public class GenApplication
{
    public static void main( String[] args )
    {
        SpringApplication.run(GenApplication.class, args);
    }
}
