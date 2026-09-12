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

import vn.iot.star.entity.User;
import vn.iot.star.service.IUserService;
import vn.iot.star.utils.Constant;
import vn.iot.star.utils.FileStorageService;

@Controller
@RequestMapping("/admin/user")
public class UserController {

    private static final String UPLOAD_SUB_DIR = "user";

    final IUserService userService;
    final FileStorageService fileStorageService;

    UserController(IUserService userService, FileStorageService fileStorageService) {
        this.userService = userService;
        this.fileStorageService = fileStorageService;
    }

    @GetMapping("/list")
    public String list(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "page", defaultValue = "1") int page,
            ModelMap model) {

        int pageIndex = Math.max(page - 1, 0);
        Pageable pageable = PageRequest.of(pageIndex, Constant.USER_PAGE_SIZE, Sort.by(Sort.Direction.DESC, "userId"));

        Page<User> userPage = userService.search(keyword, pageable);

        if (userPage.getTotalPages() > 0 && pageIndex >= userPage.getTotalPages()) {
            pageIndex = userPage.getTotalPages() - 1;
            pageable = PageRequest.of(pageIndex, Constant.USER_PAGE_SIZE, Sort.by(Sort.Direction.DESC, "userId"));
            userPage = userService.search(keyword, pageable);
        }

        model.addAttribute("userList", userPage.getContent());
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", pageIndex + 1);
        model.addAttribute("totalPages", userPage.getTotalPages());
        model.addAttribute("totalItems", userPage.getTotalElements());

        return "admin/users/list-user";
    }

    @GetMapping("/add")
    public String showAdd() {
        return "admin/users/add-user";
    }

    @PostMapping("/add")
    public String add(
            @RequestParam("fullName") String fullName,
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam(value = "email", required = false) String email,
            @RequestParam(value = "phone", required = false) String phone,
            @RequestParam(value = "address", required = false) String address,
            @RequestParam(value = "status", defaultValue = "1") int status,
            @RequestParam(value = "role", defaultValue = "USER") String role,
            @RequestParam(value = "avatar", required = false) MultipartFile avatar) {

        String avatarPath = fileStorageService.store(avatar, UPLOAD_SUB_DIR);

        User user = new User(fullName, username, password, email, phone, address, avatarPath, status, role);

        userService.save(user);

        return "redirect:/admin/user/list";
    }

    @GetMapping("/edit")
    public String showEdit(@RequestParam("id") int id, ModelMap model) {
        model.addAttribute("user", userService.findById(id));
        return "admin/users/edit-user";
    }

    @PostMapping("/edit")
    public String edit(
            @RequestParam("id") int id,
            @RequestParam("fullName") String fullName,
            @RequestParam("username") String username,
            @RequestParam(value = "password", required = false) String password,
            @RequestParam(value = "email", required = false) String email,
            @RequestParam(value = "phone", required = false) String phone,
            @RequestParam(value = "address", required = false) String address,
            @RequestParam(value = "status", defaultValue = "1") int status,
            @RequestParam(value = "role", defaultValue = "USER") String role,
            @RequestParam(value = "avatar", required = false) MultipartFile avatar) {

        User user = userService.findById(id);

        if (user == null) {
            return "redirect:/admin/user/list";
        }

        user.setFullName(fullName);
        user.setUsername(username);
        if (password != null && !password.isBlank()) {
            user.setPassword(password);
        }
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        user.setStatus(status);
        user.setRole(role);

        String newAvatar = fileStorageService.store(avatar, UPLOAD_SUB_DIR);
        if (newAvatar != null) {
            user.setAvatar(newAvatar);
        }

        userService.save(user);

        return "redirect:/admin/user/list";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") int id) {
        userService.deleteById(id);
        return "redirect:/admin/user/list";
    }
}
