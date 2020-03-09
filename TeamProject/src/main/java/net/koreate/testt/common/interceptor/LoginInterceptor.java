package net.koreate.testt.common.interceptor;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import net.koreate.testt.common.session.MySessionEventListener;
import net.koreate.testt.user.dao.UserDAO;
import net.koreate.testt.user.service.UserService;
import net.koreate.testt.user.vo.BanIPVO;
import net.koreate.testt.user.vo.LoginDTO;
import net.koreate.testt.user.vo.UserVO;


public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Inject
	UserService us;
	
	@Inject
	UserDAO dao;

	@Inject
	MySessionEventListener listener;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		 
		String email = request.getParameter("email");
		
		String ip = getIP(request);
		
		BanIPVO banVO = dao.getBanIPVO(ip,email);
		
		
		//아이피가 밴된 상황
		if(banVO != null && banVO.getCnt() >= 5) {
			//접속불가 30분동안
			long saveTime = getTime(banVO.getBandate());
			
			if(saveTime > 0) {
				SimpleDateFormat sdf = new SimpleDateFormat("mm:ss");
				String now = sdf.format(new Date(saveTime));
				
				RequestDispatcher rd = request.getRequestDispatcher("/user/logIn");
				request.setAttribute("message", "일정 시간동안 로그인 할 수 없습니다. 남은시간 : "+ now);
				//forward == post 호출방식
				rd.forward(request, response);
				
				//Controller 실행 여부
				return false;
				
			}else {
				dao.removeBanIP(ip);
			}
		}
		
		return true;
	}
	
	private long getTime(Date bandate) {
		int limit = 1000*60*30;
		return limit-(System.currentTimeMillis() - bandate.getTime());
	};

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		ModelMap modelObj = modelAndView.getModelMap();
		
		String email = request.getParameter("email");
		
		LoginDTO dto = (LoginDTO) modelObj.getAttribute("loginDTO");

		UserVO user = us.loginPost(dto);
		
		HttpSession session = request.getSession();

		String ip = getIP(request);
		
		BanIPVO vo = dao.getBanIPVO(ip,email);
		
		if(request.getParameter("email") != "" && request.getParameter("password") != "") {
			if (user != null) {
				
				boolean result = listener.exireDuplicatedSession(dto.getEmail(), session.getId());
				
				if(result){
					System.out.println("중복제거");
				}else {
					System.out.println("첫로그인");
				}
				
				session.setAttribute("userInfo", user);

				if (dto.isUserCookie()) {
					Cookie cookie = new Cookie("signInCookie", user.getEmail());
					cookie.setPath("/");
					cookie.setMaxAge(60 * 60 * 24);
					response.addCookie(cookie);
				}
				
				// 로그인 후 밴아이피가 존재한다면
				if (vo != null) {
					dao.removeBanIP(ip);
				}
				
			} else {
				int count = 5;
				String message = "";
				
				if(vo == null) {
					dao.signInFail(ip,email);
					count = count -1;
					modelAndView.setViewName("/user/logIn");
				}else {
					dao.updateBanIPCnt(ip,email);
					count = count - (vo.getCnt()+1);
					modelAndView.setViewName("/user/logIn");
				}
				
				
				if(count > 0) {
					message = "비밀번호가 틀렸습니다. 남은 횟수"+count;
				}else {
					message = "30분간 회원가입을 시도할 수 없습니다.";
				}
				
				modelAndView.addObject("message",message);
				modelAndView.setViewName("/user/logIn");
			}
		}else {
			modelAndView.setViewName("/user/logIn");
		}
	}

	public String getIP(HttpServletRequest request) {

		String ip = request.getHeader("X-forwarded-For");

		if (ip == null) {
			ip = request.getHeader("Proxy-Client-IP");
			System.out.println("Proxy-Client-IP : " + ip);
		}

		if (ip == null) {
			ip = request.getHeader("WL-Proxy-IP");
			System.out.println("Proxy-Client-IP : " + ip);
		}

		if (ip == null) {
			ip = request.getHeader("HTTP-X_FORWARDED-FOR");
			System.out.println("HTTP-X_FORWARDED-FOR : " + ip);
		}

		if (ip == null) {
			ip = request.getRemoteAddr();
			System.out.println("remoteAddr :" + ip);
		}
		return ip;
	}
}
