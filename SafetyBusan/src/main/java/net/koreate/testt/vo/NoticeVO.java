package net.koreate.testt.vo;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	
	private int noticeNum;
	private String title;
	private String content;
	private int userNum;
	private Date regdate;
	private Date updatedate;
	private int viewCnt;
}
