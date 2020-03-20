package net.koreate.testt.user.vo;

import java.util.Date;

import lombok.Data;

@Data
public class UserVO {
	
	
	private int userNum;
	private String name;
	private String email;
	private String password;
	private String post;
	private String phoneNum;
	private Date regdate;
	private String addr;
	private String addrDetail;
	private String withDraw;
	
}
