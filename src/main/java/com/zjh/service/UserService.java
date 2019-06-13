//package com.zjh.service;
//
//import org.springframework.security.core.authority.AuthorityUtils;
//import org.springframework.security.core.userdetails.User;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.core.userdetails.UsernameNotFoundException;
//import org.springframework.stereotype.Service;
//
///**
// * @Author zjh
// * @Date 2019/04/15,21:55
// */
//@Service("UserDetailsService")
//public class UserService implements UserDetailsService {
//
//        @Override
//        public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
//            //根据用户名查找用户信息
//            return new User(userName,"password", AuthorityUtils.commaSeparatedStringToAuthorityList("admin"));
//        }
//}
