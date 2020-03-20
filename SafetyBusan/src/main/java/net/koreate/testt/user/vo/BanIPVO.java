package net.koreate.testt.user.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BanIPVO {
	
	private String ip;
	private int cnt;
	private Date bandate;
	private String email;
}
