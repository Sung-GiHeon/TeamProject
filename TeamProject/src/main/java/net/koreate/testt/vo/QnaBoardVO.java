package net.koreate.testt.vo;

import java.util.Date;

import lombok.Data;

@Data
public class QnaBoardVO {
	
	private int qnaNum;
	private String writer;
	private String title;
	private String content;
	private Date regdate;
	private int viewCnt;
	private Date updatedate;
	private String uploadCheck;
	private int userNum;
}
