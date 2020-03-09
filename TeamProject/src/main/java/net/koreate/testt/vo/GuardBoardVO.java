package net.koreate.testt.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GuardBoardVO {
	
	private int guardNum;
	private String title;
	private String writer;
	private String content;
	private String region;
	private int userNum;
	private String uploadCheck;
	private Date regdate;
	private Date updatedate;
	private int viewCnt;
	
}
