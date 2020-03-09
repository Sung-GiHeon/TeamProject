package net.koreate.testt.user.service;

import net.koreate.testt.user.vo.LoginDTO;
import net.koreate.testt.user.vo.UserVO;

public interface UserService {
	
	void signUp(UserVO vo)throws Exception;

	boolean checkEmail(String email)throws Exception;
	
	UserVO loginPost(LoginDTO dto)throws Exception;

	UserVO getUserById(String value);
	
}
