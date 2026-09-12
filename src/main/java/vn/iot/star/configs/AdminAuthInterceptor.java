package vn.iot.star.configs;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import vn.iot.star.entity.User;

public class AdminAuthInterceptor implements HandlerInterceptor {

	private static final String SESSION_ACCOUNT = "account";
	private static final String ROLE_ADMIN = "ADMIN";

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		HttpSession session = request.getSession(false);
		Object account = (session != null) ? session.getAttribute(SESSION_ACCOUNT) : null;

		if (!(account instanceof User user)) {
			response.sendRedirect(request.getContextPath() + "/login");
			return false;
		}

		if (!ROLE_ADMIN.equalsIgnoreCase(user.getRole())) {
			response.sendRedirect(request.getContextPath() + "/home?error=forbidden");
			return false;
		}

		return true;
	}
}
