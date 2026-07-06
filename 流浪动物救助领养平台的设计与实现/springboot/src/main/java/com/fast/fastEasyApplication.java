package com.fast;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class fastEasyApplication {

    public static void main(String[] args) {
        SpringApplication.run(fastEasyApplication.class, args);
        System.out.println("后端启动成功");
    }
}
