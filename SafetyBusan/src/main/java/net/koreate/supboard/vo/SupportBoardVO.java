package net.koreate.supboard.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class SupportBoardVO {
	
	private int supportNum;
	private String region;
	private String title;
	private String content;
	private String startdate;
	private Date regdate;
	private String writer;
	private String enddate;
	private int viewCnt;
	private Date updatedate;
	private String recm;
	private String userNumcopy;
	private int userNum;
	private String uploadCheck;

	// 파일 받아오는 vo
	private List<String> file;	
	// 코멘트 갯수 vo
	int commentCnt;	
}
