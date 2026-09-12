package vn.iot.star.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import vn.iot.star.entity.User;

public interface IUserService {

    List<User> findAll();
    Page<User> search(String keyword, Pageable pageable);
    List<User> findLatest(int limit);
    Page<User> findLatest(Pageable pageable);
    User findById(int id);
    User findByUsername(String username);
    User save(User user);
    void deleteById(int id);
    long count();
}
