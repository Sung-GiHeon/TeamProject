package net.koreate.testt.user.vo;

import lombok.Data;

@Data
public class LoginDTO {
	
	private String email;
	private String password;
	private boolean userCookie;
	
}
