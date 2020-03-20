package net.koreate.supboard.service;

import java.util.List;

import net.koreate.supboard.util.PageMaker;
import net.koreate.supboard.util.SearchCriteria;
import net.koreate.supboard.vo.SupportBoardVO;

public interface Support_Service {
	
	// 글 작성
		void regist(SupportBoardVO vo) throws Exception;

		List<SupportBoardVO> listCriteria(SearchCriteria cri) throws Exception;
		
		PageMaker getPageMaker(SearchCriteria cri) throws Exception;

		void updateViewCnt(int supportNum) throws Exception;

		SupportBoardVO read(int supportNum) throws Exception;

		void modify(SupportBoardVO board) throws Exception;

		void remove(int supportNum) throws Exception;

		List<String> getAttach(int supportNum) throws Exception;

		void Timerout(SupportBoardVO vo) throws Exception;


}
