package net.koreate.testt.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Re_supportVO {
	
	private int re_supportNum;
	private String content;
	private String commentWriter;
	private int userNum;
	private Date regdate;
	private int supportNum;
}
