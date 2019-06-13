package com.zjh.domain;

import lombok.*;
import org.hibernate.annotations.NamedQuery;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * @Author zjh
 * @Date 2018/12/27,15:55
 */
@NoArgsConstructor
@RequiredArgsConstructor
@Entity
@NamedQuery(name="User.find", query="select u from User u where u.name=?1")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Getter
    private Long id;

    @Getter
    @NonNull
    private String name;

    @Getter
    @NonNull
    private int age;

//    public void setName(String name) {
//        this.name = name;
//    }
//
//    public void setAge(int age) {
//        this.age = age;
//    }
}
