package net.koreate.testt.common.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import net.koreate.testt.user.service.UserService;
import net.koreate.testt.user.vo.UserVO;


public class CheckCookieInterceptor extends HandlerInterceptorAdapter{

	@Inject
	UserService us;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfo") != null) {
			System.out.println("사용자 정보 이미 존재");
			return true;
		}
		
		Cookie cookie = WebUtils.getCookie(request, "signInCookie");
		if(cookie != null) {
			UserVO userInfo = us.getUserById(cookie.getValue());
			System.out.println("cookir user : " + userInfo);
			if(userInfo != null) {
				session.setAttribute("userInfo", userInfo);
			}
		}
		return true;
	}
}
