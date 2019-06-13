package com.zjh.domain;

import lombok.Data;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * @Author zjh
 * @Date 2019/06/10,10:46
 */
@Data
public class PrintBean implements InitializingBean {

    private String message;

    @Override
    public void afterPropertiesSet() throws Exception {
        System.out.println("===================" + message);
    }
}
