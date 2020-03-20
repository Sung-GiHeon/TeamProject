package net.koreate.guardboard.service;

import java.util.List;

import net.koreate.guardboard.vo.GuardBoardVO;
import net.koreate.supboard.util.PageMaker;
import net.koreate.supboard.util.SearchCriteria;

public interface GuardBoard_Service {

	List<GuardBoardVO> listReplyCriteria(SearchCriteria cri) throws Exception;

	List<GuardBoardVO> listCriteria(SearchCriteria cri) throws Exception;
	
	PageMaker getPageMaker(SearchCriteria cri) throws Exception;

	void regist(GuardBoardVO vo) throws Exception;

	void modify(GuardBoardVO board) throws Exception;

	GuardBoardVO read(int guardNum) throws Exception;

	void updateViewCnt(int guardNum) throws Exception;

	void remove(int guardNum) throws Exception;

	List<String> getAttach(int guardNum) throws Exception;


}
