package net.koreate.testt.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Re_accidentVO {
	private int commentNum;
	private int accidentNum;
	private int userNum;
	private String commentWriter;
	private String content;
	private Date regdate;
}
