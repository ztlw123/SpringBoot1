package com.zjh.repository;

import com.zjh.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author zjh
 * @Date 2018/12/27,16:31
 */
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    List<User> find(String name);

    @Transactional
    @Modifying
    @Query(value = "update User u set u.name = ?1 where u.id = ?2")
    int updateNameById(String name, Long id);
}
