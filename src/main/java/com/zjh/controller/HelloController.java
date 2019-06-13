package com.zjh.controller;

import com.zjh.domain.PrintBean;
import com.zjh.domain.User;
import com.zjh.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@EnableScheduling
@RestController
public class HelloController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/save")
    public ResponseEntity<User> save() {
        User user =new User("zjh", 22);
        userRepository.save(user);
        return ResponseEntity.ok(user);
    }

    @GetMapping("/findByName")
    public ResponseEntity<List<User>> findByName(@RequestParam String name) {
        List<User> list = userRepository.find(name);
        return ResponseEntity.ok(list);
    }

    @GetMapping("/findAll")
    public ResponseEntity<List<User>> findAll() {

        Sort sort = new Sort(Sort.Direction.ASC,"id");
        return ResponseEntity.ok(userRepository.findAll(sort));
    }

    @GetMapping("/updateName")
    public ResponseEntity<Integer> setNameById(@RequestParam Long id, @RequestParam String name) {

        return ResponseEntity.ok(userRepository.updateNameById(name, id));
    }
    @RequestMapping("/hello")
    public String hello(){
        return "hello";
    }

    @Scheduled(cron = "0 24-27 * * *  ?")
    public void scheduled() throws InterruptedException {
        DateFormat format = new SimpleDateFormat("HH:mm:ss");
        Thread.sleep(3000);
        System.out.println("========" + format.format(new Date()));
    }


//
//    @RequestMapping("/success")
//    public String success(Map<String, Object> map){
//        map.put("hello",15);
//        map.put("chenxing",20);
//        map.put("users", Arrays.asList("11","12","13"));
//        return "hello";
//    }
}
