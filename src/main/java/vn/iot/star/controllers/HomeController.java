package vn.iot.star.controllers;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.iot.star.entity.Category;
import vn.iot.star.service.ICategoryService;
import vn.iot.star.utils.Constant;

@Controller
public class HomeController {

	final ICategoryService categoryService;

	HomeController(ICategoryService categoryService) {
		this.categoryService = categoryService;
	}

	@GetMapping("/")
	public String root(@RequestParam(value = "page", defaultValue = "1") int page, ModelMap model) {
		return home(page, model);
	}

	@GetMapping("/home")
	public String home(@RequestParam(value = "page", defaultValue = "1") int page, ModelMap model) {

		int pageIndex = Math.max(page - 1, 0);
		Pageable pageable = PageRequest.of(pageIndex, Constant.HOME_CATEGORY_PAGE_SIZE,
				Sort.by(Sort.Direction.DESC, "categoryId"));

		Page<Category> categoryPage = categoryService.findAll(pageable);

		if (categoryPage.getTotalPages() > 0 && pageIndex >= categoryPage.getTotalPages()) {
			pageIndex = categoryPage.getTotalPages() - 1;
			pageable = PageRequest.of(pageIndex, Constant.HOME_CATEGORY_PAGE_SIZE,
					Sort.by(Sort.Direction.DESC, "categoryId"));
			categoryPage = categoryService.findAll(pageable);
		}

		model.addAttribute("categories", categoryPage.getContent());
		model.addAttribute("currentPage", pageIndex + 1);
		model.addAttribute("totalPages", categoryPage.getTotalPages());

		return "index";
	}
}