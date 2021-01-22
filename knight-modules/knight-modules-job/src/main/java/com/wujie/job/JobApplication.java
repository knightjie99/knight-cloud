package com.wujie.job;


import com.wujie.common.security.annotation.EnableCustomConfig;
import com.wujie.common.security.annotation.EnableMyFeignClients;
import com.wujie.common.swagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

/**
 * 定时任务
 *
 * @author wujie
 */
@EnableCustomConfig
@EnableCustomSwagger2
@EnableMyFeignClients
@SpringCloudApplication
public class JobApplication {
    public static void main(String[] args) {
        SpringApplication.run(JobApplication.class, args);
    }
}
