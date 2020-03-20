package net.koreate.testt.vo;

import java.util.Date;

import lombok.Data;

@Data
public class SupportBoardVO {
	
	private int supportNum;
	private String region;
	private String title;
	private String content;
	private Date regdate;
	private String writer;
	private Date enddate;
	private int viewCnt;
	private Date updatedate;
	private int loc_x;
	private int loc_y;
	private String recm;
	private int userNum;
	private String uploadCheck;
	
}
