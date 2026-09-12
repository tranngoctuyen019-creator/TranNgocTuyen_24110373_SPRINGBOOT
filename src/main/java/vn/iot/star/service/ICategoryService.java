package vn.iot.star.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import vn.iot.star.entity.Category;

public interface ICategoryService {

    List<Category> findAll();
    Page<Category> findAll(Pageable pageable);
    Category findById(int id);
    Category save(Category category);
    void deleteById(int id);
    long count();
}
