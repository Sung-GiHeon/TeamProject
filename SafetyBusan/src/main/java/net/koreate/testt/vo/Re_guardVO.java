package net.koreate.testt.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Re_guardVO {
	
	private int re_guardNum;
	private String commentWriter;
	private String content;
	private int userNum;
	private int guardNum;
	private Date regdate;
	
}
