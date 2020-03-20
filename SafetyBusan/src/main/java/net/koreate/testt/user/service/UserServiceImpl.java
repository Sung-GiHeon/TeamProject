package net.koreate.testt.user.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import net.koreate.testt.user.dao.UserDAO;
import net.koreate.testt.user.vo.LoginDTO;
import net.koreate.testt.user.vo.UserVO;

@Service
public class UserServiceImpl implements UserService{

	@Inject
	UserDAO dao;
	
	@Override
	public void signUp(UserVO vo) throws Exception {
		dao.signUp(vo);
	}

	@Override
	public boolean checkEmail(String email) throws Exception {
		if(dao.checkEmail(email) == null) {
			return false;
		}
		return true;
	}

	@Override
	public UserVO loginPost(LoginDTO dto) throws Exception {
		return dao.loginPost(dto);
	}

	@Override
	public UserVO getUserById(String value) {
		return dao.getUserById(value);
	}
}
