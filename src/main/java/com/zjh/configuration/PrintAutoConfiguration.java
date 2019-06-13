package com.zjh.configuration;

import com.zjh.domain.PrintBean;
import com.zjh.domain.User;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @Author zjh
 * @Date 2019/06/10,10:48
 */
@Configuration
public class PrintAutoConfiguration {

//    @Bean
//    public PrintBean getUser() {
//        return new PrintBean();
//    }
//
//    @Bean
//    @ConfigurationProperties(prefix = "init")
//    @ConditionalOnBean(User.class)
//    @ConditionalOnProperty(prefix = "init", value = "message")
//    public PrintBean getPrintBean() {
//        return new PrintBean();
//    }
}
