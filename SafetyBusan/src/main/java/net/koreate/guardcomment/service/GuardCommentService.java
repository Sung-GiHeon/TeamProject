package net.koreate.guardcomment.service;

import java.util.Map;

import net.koreate.guardcomment.vo.Re_guardVO;

public interface GuardCommentService {

	void addComment(Re_guardVO vo) throws Exception;
	
	Map<String,Object> listPage(int guardNum, int page) throws Exception;

	void modifyComment(Re_guardVO vo) throws Exception;

	void removeComment(int re_guardNum) throws Exception;

	int getcommentCnt(int guardNum) throws Exception;
	
}
