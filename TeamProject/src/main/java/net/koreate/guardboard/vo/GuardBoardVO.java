package net.koreate.guardboard.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class GuardBoardVO {
	private int guardNum;
	private String region;
	private String title;
	private String writer;
	private String content;
	private Date regdate;
	private int viewCnt;
	private Date updatedate;
	private String userNumcopy;
	private int userNum;
	private String uploadCheck;
	private List<String> file;	
}
