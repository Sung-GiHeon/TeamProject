package net.koreate.qnaboard.service;

import java.util.List;

import net.koreate.mvc.common.util.PageMaker;
import net.koreate.mvc.common.util.SearchCriteria;
import net.koreate.qnaboard.vo.Re_qnaVO;

public interface QnaBoardService {

	void regist(Re_qnaVO board) throws Exception;

	List<Re_qnaVO> listReplyCriteria(SearchCriteria cri) throws Exception;

	PageMaker getPageMaker(SearchCriteria cri) throws Exception;

	void updateCnt(int re_qnaNum) throws Exception;

	Re_qnaVO readReply(int re_qnaNum) throws Exception;

	void replyRegister(Re_qnaVO vo) throws Exception;

	void modify(Re_qnaVO vo) throws Exception;

	void remove(int re_qnaNum) throws Exception;


}
