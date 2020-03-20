package net.koreate.nboard.service;

import java.util.List;



import net.koreate.mvc.common.util.Criteria;
import net.koreate.mvc.common.util.PageMaker;
import net.koreate.nboard.vo.NoticeVO;

public interface NoticeBoardService {

	public String regist(NoticeVO nboard) throws Exception;

	public NoticeVO read(int noticeNum)throws Exception;
	
	public String modify(NoticeVO nboard) throws Exception;
	
	public String remove(int noticeNum) throws Exception;
	
	
	public List<NoticeVO> listCriteria(Criteria cri) throws Exception;

	public PageMaker getPageMaker(Criteria cri) throws Exception;

	public void updateCnt(int noticeNum) throws Exception;

	NoticeVO readReply(int noticeNum);

	

	

	

	

}
