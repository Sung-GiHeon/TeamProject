package net.koreate.supcomment.service;

import java.util.Map;

import net.koreate.supcomment.vo.Re_supportVO;

public interface CommentService {

	void addComment(Re_supportVO vo) throws Exception;
	
	Map<String,Object> listPage(int supportNum, int page) throws Exception;

	void modifyComment(Re_supportVO vo) throws Exception;

	void removeComment(int re_supportNum ) throws Exception;

	int getcommentCnt(int supportNum) throws Exception;
	
}
