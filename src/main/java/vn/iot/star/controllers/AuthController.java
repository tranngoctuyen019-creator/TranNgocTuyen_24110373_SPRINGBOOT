package vn.iot.star.controllers;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.iot.star.entity.User;
import vn.iot.star.service.IUserService;

@Controller
public class AuthController {

	private static final String SESSION_ACCOUNT = "account";
	private static final String ROLE_ADMIN = "ADMIN";

	final IUserService userService;

	AuthController(IUserService userService) {
		this.userService = userService;
	}

	@GetMapping("/login")
	public String showLogin(HttpSession session) {

		Object account = session.getAttribute(SESSION_ACCOUNT);

		if (account instanceof User user) {
			return ROLE_ADMIN.equalsIgnoreCase(user.getRole()) ? "redirect:/admin/home" : "redirect:/home";
		}

		return "login";
	}

	@PostMapping("/login")
	public String login(
			@RequestParam("username") String username,
			@RequestParam("password") String password,
			HttpServletRequest request,
			ModelMap model) {

		User user = userService.findByUsername(username);

		if (user == null || user.getPassword() == null || !user.getPassword().equals(password)) {
			model.addAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng.");
			model.addAttribute("username", username);
			return "login";
		}

		if (user.getStatus() == 0) {
			model.addAttribute("error", "Tài khoản của bạn đã bị khóa.");
			model.addAttribute("username", username);
			return "login";
		}

		request.getSession(true).setAttribute(SESSION_ACCOUNT, user);

		if (ROLE_ADMIN.equalsIgnoreCase(user.getRole())) {
			return "redirect:/admin/home";
		}

		return "redirect:/home";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/home";
	}
}
