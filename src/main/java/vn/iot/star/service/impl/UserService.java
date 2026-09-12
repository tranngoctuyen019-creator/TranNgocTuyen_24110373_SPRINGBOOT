package vn.iot.star.service.impl;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.iot.star.entity.User;
import vn.iot.star.repository.IUserRepository;
import vn.iot.star.service.IUserService;

@Service
public class UserService implements IUserService {

    final IUserRepository userRepository;

    UserService(IUserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public Page<User> search(String keyword, Pageable pageable) {
        if (keyword == null || keyword.isBlank()) {
            return userRepository.findAll(pageable);
        }
        return userRepository.search(keyword.trim(), pageable);
    }

    @Override
    public List<User> findLatest(int limit) {
        return userRepository.findLatest(PageRequest.of(0, limit)).getContent();
    }

    @Override
    public Page<User> findLatest(Pageable pageable) {
        return userRepository.findLatest(pageable);
    }

    @Override
    public User findById(int id) {
        return userRepository.findById(id).orElse(null);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public User save(User user) {
        return userRepository.save(user);
    }

    @Override
    public void deleteById(int id) {
        userRepository.deleteById(id);
    }

    @Override
    public long count() {
        return userRepository.count();
    }
}
