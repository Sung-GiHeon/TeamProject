package net.koreate.testt.common.session;

import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.stereotype.Component;

import net.koreate.testt.user.vo.UserVO;


@Component
public class MySessionEventListener implements HttpSessionListener,HttpSessionAttributeListener{
	
	public static Hashtable<String, Object> sessionRepository;
	
	public MySessionEventListener() {
		System.out.println("MySessionEventListener created");
		if(sessionRepository == null) {
			sessionRepository = new Hashtable<>();
		}
	}
	
	public boolean exireDuplicatedSession(String uid,String sessionId) {
		boolean result =false;
		
		System.out.println("Active Session count:"+sessionRepository.size());
		
		Enumeration<Object> enumeration = sessionRepository.elements();
		System.out.println("session id : "+ sessionId + "uid : "+uid);
		while(enumeration.hasMoreElements()) {
			HttpSession session = (HttpSession)enumeration.nextElement();
			
			UserVO user = (UserVO)session.getAttribute("userInfo");
			
			// 사용자 정보 존재
			if(user != null) {
				if(user.getEmail().equals(uid)) {
					//다른 세션정보의 연결을 끊어 주어야하기 때문에 서로 달라야한다.
					if(!session.getId().equals(sessionId)) {
						System.out.println("login - user : "+ user.getEmail()+"sessionId : "+sessionId);
						session.invalidate();
						return true;
					}
				}
			}
		}
		
		return result;
	}
	
	@Override
	public void attributeAdded(HttpSessionBindingEvent event) {
		System.out.println("attributeAdded 호출");
		//session마다 key와 value값이 다를수도 잇으니깐
		if("userInfo".equals(event.getName())) {
			
			HttpSession session = event.getSession();
			synchronized(sessionRepository) {
				System.out.println("session regist");
				sessionRepository.put(session.getId(),session);
			}
		}
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		HttpSession session = se.getSession();
		synchronized(sessionRepository) {
			System.out.println("session destory : "+session.getId());
			sessionRepository.remove(session.getId());
		}
		
	}
}
