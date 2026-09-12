package vn.iot.star.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.iot.star.entity.Category;

@Repository
public interface ICategoryRepository extends JpaRepository<Category, Integer> {

}
