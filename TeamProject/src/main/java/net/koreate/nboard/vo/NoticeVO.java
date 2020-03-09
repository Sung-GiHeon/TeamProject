package net.koreate.nboard.vo;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
	
	private int noticeNum;
	private String content;
	private String title;
	private String userNum;
	private Date regdate;
	private Date updatedate;
	private int viewCnt;
}
