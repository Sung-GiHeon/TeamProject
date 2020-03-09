package net.koreate.accomment.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Re_accidentVO {
	private int commentNum;
	private int accidentNum;
	private Date updatedate;
	private String userNum;
	private String content;
	private Date regdate;
	private String commentWriter;
}
