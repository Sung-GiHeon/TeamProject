package net.koreate.testt.user.controller;

import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.koreate.testt.user.service.MailService;
import net.koreate.testt.user.service.UserService;
import net.koreate.testt.user.service.UserSha256;
import net.koreate.testt.user.vo.LoginDTO;
import net.koreate.testt.user.vo.UserVO;

@Controller
@RequestMapping("user")
public class UserController {
	
	@Inject
	UserService service;
	
	@Inject
	MailService mailService;
	
	//로그인
	@PostMapping("/logInPost")
	public ModelAndView logInPost(LoginDTO dto,ModelAndView mav) throws Exception{
		String encryPassword = UserSha256.encrypt(dto.getPassword());
		dto.setPassword(encryPassword);
		mav.addObject("loginDTO",dto);
		mav.setViewName("redirect:/");
		return mav;
	}
	
	//로그인 화면
	@RequestMapping("/logIn")
	public String logIn() throws Exception{
		return "/user/logIn";
	}
	
	//회원가입 화면
	@GetMapping("/signUp")
	public ModelAndView signUp() throws Exception{
		ModelAndView mv = new ModelAndView();
		int ran = new Random().nextInt(900000) + 100000;
		mv.setViewName("/user/signUp");
		mv.addObject("random", ran);
		return mv;
	}
	
	//회원가입
	@PostMapping("/signUpPost")
	public String signUpPost(UserVO vo ,RedirectAttributes rttr) throws Exception{
		String encryPassword = UserSha256.encrypt(vo.getPassword());
		vo.setPassword(encryPassword);
		service.signUp(vo);
		rttr.addFlashAttribute("message","회원가입 성공");
		return "redirect:/user/logIn";
	}
	
	//아이디 중복확인
	@PostMapping("/uidCheck")
	@ResponseBody
	public boolean emailCheck(String u_email) throws Exception{
		boolean isCheck = false;
		isCheck = service.checkEmail(u_email);
		return isCheck;
	}
	
	@GetMapping("/logout")
	public String signOut(HttpSession session,HttpServletRequest request,HttpServletResponse response,
			@CookieValue(name="signInCookie", required=false)Cookie signInCookie) throws Exception{
		
		if(session.getAttribute("userInfo") != null) {
			session.removeAttribute("userInfo");
			
			if(signInCookie != null) {
				System.out.println("signInCookie key:"+signInCookie.getName());
				System.out.println("signInCookie value:"+signInCookie.getValue());
				
				signInCookie.setPath("/");
				signInCookie.setMaxAge(0);
				response.addCookie(signInCookie);
			}
		}
		return "redirect:/";
	}
	
	@GetMapping("/endCode")
	@ResponseBody
	public boolean endCode(HttpServletRequest req) {
		int ran = new Random().nextInt(900000) + 100000;
		HttpSession session = req.getSession(true);
		String authCode = String.valueOf(ran);
		session.setAttribute("authCode", authCode);
		System.out.println("auth Code :"+authCode);
		return true;
	}
	
	@GetMapping("/mailRequest")
	@ResponseBody
	//데이터 정보가 json으로 들어오는데 object인 string형태로 받아줄 jackson-databind가 필요하다.
	public boolean createEmailCheck(String email, int random, HttpServletRequest req) {
		int ran = new Random().nextInt(900000) + 100000;
		HttpSession session = req.getSession(true);
		String authCode = String.valueOf(ran);
		session.setAttribute("authCode", authCode);
		session.setAttribute("random", random);
		String subject = "회원가입 인증 코드 발급 안내 입니다.";
		StringBuilder sb = new StringBuilder();
		sb.append("귀하의 인증 코드는 " + authCode + "입니다.");
		String sendEmailId = "dlgusdne@gmail.com";
		return mailService.send(subject, sb.toString(), sendEmailId, email, null);
		
	};
	
	@GetMapping("/mailConfirm")
	@ResponseBody
	public ResponseEntity<String> emailAuth(String mailCode,int random,HttpSession session) {
		
		String mailAuthCode = (String)session.getAttribute("authCode");
		int randomCode = (Integer)session.getAttribute("random");
		
		if(mailAuthCode.equals(mailCode) && randomCode == random) {
			return new ResponseEntity<String>("complete", HttpStatus.OK);
		}else return new ResponseEntity<String>("false", HttpStatus.OK);
	}
}
