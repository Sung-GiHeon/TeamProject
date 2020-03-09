package net.koreate.testt.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Re_qnaVO {
	
	private int re_qnaNum;
	private String title;
	private String content;
	private String writer;
	private int origin;
	private int dept;
	private int seq;
	private Date regdate;
	private Date updatedate;
	private int viewCnt;
	private String showBoard;
	private int userNum;
	
}
