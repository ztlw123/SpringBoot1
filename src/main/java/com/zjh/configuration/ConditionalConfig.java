package com.zjh.configuration;

import com.zjh.domain.MagicCondition;
import com.zjh.domain.PrintBean;
import com.zjh.domain.User;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Conditional;
import org.springframework.context.annotation.Configuration;

/**
 * @Author zjh
 * @Date 2019/06/11,10:28
 */
@Configuration
public class ConditionalConfig {

    @Bean
    @Conditional(MagicCondition.class)
    @ConditionalOnProperty(prefix = "init", value = "message")
    public PrintBean getUser() {
        return new PrintBean();
    }
}
