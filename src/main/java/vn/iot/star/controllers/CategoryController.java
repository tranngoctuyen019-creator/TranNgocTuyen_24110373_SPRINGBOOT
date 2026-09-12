package vn.iot.star.controllers;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import vn.iot.star.entity.Category;
import vn.iot.star.service.ICategoryService;
import vn.iot.star.utils.Constant;
import vn.iot.star.utils.FileStorageService;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

    private static final String UPLOAD_SUB_DIR = "category";

    final ICategoryService categoryService;
    final FileStorageService fileStorageService;

    CategoryController(ICategoryService categoryService, FileStorageService fileStorageService) {
        this.categoryService = categoryService;
        this.fileStorageService = fileStorageService;
    }

    @GetMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page, ModelMap model) {

        int pageIndex = Math.max(page - 1, 0);
        Pageable pageable = PageRequest.of(pageIndex, Constant.CATEGORY_PAGE_SIZE, Sort.by(Sort.Direction.DESC, "categoryId"));

        Page<Category> categoryPage = categoryService.findAll(pageable);

        if (categoryPage.getTotalPages() > 0 && pageIndex >= categoryPage.getTotalPages()) {
            pageIndex = categoryPage.getTotalPages() - 1;
            pageable = PageRequest.of(pageIndex, Constant.CATEGORY_PAGE_SIZE, Sort.by(Sort.Direction.DESC, "categoryId"));
            categoryPage = categoryService.findAll(pageable);
        }

        model.addAttribute("categories", categoryPage.getContent());
        model.addAttribute("currentPage", pageIndex + 1);
        model.addAttribute("totalPages", categoryPage.getTotalPages());
        model.addAttribute("totalItems", categoryPage.getTotalElements());

        return "admin/categories/list-category";
    }

    @GetMapping("/add")
    public String showAdd() {
        return "admin/categories/add-category";
    }

    @PostMapping("/add")
    public String add(
            @RequestParam("name") String name,
            @RequestParam(value = "icon", required = false) MultipartFile icon) {

        Category category = new Category();
        category.setCategoryname(name);
        category.setStatus(1);
        category.setImages(fileStorageService.store(icon, UPLOAD_SUB_DIR));

        categoryService.save(category);

        return "redirect:/admin/categories/list";
    }

    @GetMapping("/edit")
    public String showEdit(@RequestParam("id") int id, ModelMap model) {
        Category category = categoryService.findById(id);
        model.addAttribute("category", category);
        return "admin/categories/edit-category";
    }

    @PostMapping("/edit")
    public String edit(
            @RequestParam("id") int id,
            @RequestParam("name") String name,
            @RequestParam(value = "icon", required = false) MultipartFile icon) {

        Category category = categoryService.findById(id);

        if (category == null) {
            return "redirect:/admin/categories/list";
        }

        category.setCategoryname(name);

        String newImage = fileStorageService.store(icon, UPLOAD_SUB_DIR);
        if (newImage != null) {
            category.setImages(newImage);
        }

        categoryService.save(category);

        return "redirect:/admin/categories/list";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") int id) {
        categoryService.deleteById(id);
        return "redirect:/admin/categories/list";
    }

    @GetMapping("/download")
    public String download() {
        return "admin/categories/download";
    }
}
