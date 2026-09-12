package vn.iot.star.controllers;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.iot.star.entity.User;
import vn.iot.star.service.ICategoryService;
import vn.iot.star.service.IUserService;
import vn.iot.star.utils.Constant;

@Controller
public class AdminHomeController {

    final IUserService userService;
    final ICategoryService categoryService;

    AdminHomeController(IUserService userService, ICategoryService categoryService) {
        this.userService = userService;
        this.categoryService = categoryService;
    }

    @GetMapping("/admin/home")
    public String home(@RequestParam(value = "page", defaultValue = "1") int page, ModelMap model) {

        int pageIndex = Math.max(page - 1, 0);
        Pageable pageable = PageRequest.of(pageIndex, Constant.HOME_LATEST_USER_PAGE_SIZE);

        Page<User> latestUsersPage = userService.findLatest(pageable);

        if (latestUsersPage.getTotalPages() > 0 && pageIndex >= latestUsersPage.getTotalPages()) {
            pageIndex = latestUsersPage.getTotalPages() - 1;
            pageable = PageRequest.of(pageIndex, Constant.HOME_LATEST_USER_PAGE_SIZE);
            latestUsersPage = userService.findLatest(pageable);
        }

        model.addAttribute("totalUsers", userService.count());
        model.addAttribute("totalCategories", categoryService.count());
        model.addAttribute("latestUsers", latestUsersPage.getContent());
        model.addAttribute("currentPage", pageIndex + 1);
        model.addAttribute("totalPages", latestUsersPage.getTotalPages());

        return "admin/categories/home";
    }
}
