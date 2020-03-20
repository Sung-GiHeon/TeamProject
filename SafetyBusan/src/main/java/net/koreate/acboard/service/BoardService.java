package net.koreate.acboard.service;

import java.util.List;

import net.koreate.acboard.vo.AccidentBoardVO;
import net.koreate.mvc.common.util.PageMaker;
import net.koreate.mvc.common.util.SearchCriteria;

public interface BoardService {
	
	// 게시글 작성
	void regist(AccidentBoardVO aboard)throws Exception;
	
	// 게시물 목록
	List<AccidentBoardVO> listReplyCriteria(SearchCriteria cri)throws Exception;
	
	// pageMaker
	PageMaker getPageMaker(SearchCriteria cri)throws Exception;

	// 게시물 조회수 증가
	void updateCnt(int accidentNum) throws Exception;
	
	// 게시물 상세 정보
	AccidentBoardVO readReply(int accidentNum) throws Exception;


	// 게시글 수정
	void modify(AccidentBoardVO vo) throws Exception;

	// 게시글 삭제 처리
	void delete(int accidentNum) throws Exception;


	// 첨부파일 목록
	List<String> getAttach(int accidentNum) throws Exception;



	
}


