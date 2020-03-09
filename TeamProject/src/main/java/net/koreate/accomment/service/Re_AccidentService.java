package net.koreate.accomment.service;

import java.util.Map;

import net.koreate.accomment.vo.Re_accidentVO;


public interface Re_AccidentService {
	
	void addComment(Re_accidentVO vo) throws Exception;
	
	Map<String,Object> listPage(int accidentNum, int page) throws Exception;

	void modifyComment(Re_accidentVO vo) throws Exception;

	void removeComment(int commentNum)throws Exception;
}
