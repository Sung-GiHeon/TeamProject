package net.koreate.acboard.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class AccidentBoardVO {
	
	private int accidentNum;
	private String userNum;
	private String writer;
	private String title;
	private String content;
	private String region;
	private int viewCnt;
	private Date regdate;
	private Date updatedate;
	private String userHidden;
	private String uploadCheck;
	List<String> files;
	int commentCnt;
	
}
