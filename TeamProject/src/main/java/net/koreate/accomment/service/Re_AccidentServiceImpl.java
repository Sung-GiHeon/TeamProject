package net.koreate.accomment.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import net.koreate.accomment.dao.Re_AccidentDAO;
import net.koreate.accomment.vo.Re_accidentVO;
import net.koreate.mvc.common.util.Criteria;
import net.koreate.mvc.common.util.PageMaker;

@Service
public class Re_AccidentServiceImpl implements Re_AccidentService{
	
	@Inject
	Re_AccidentDAO dao;
	
	@Override
	public void addComment(Re_accidentVO vo) throws Exception {
		dao.addComment(vo);
	}

	@Override
	public Map<String, Object> listPage(int accidentNum, int page) throws Exception {
		
		Criteria cri = new Criteria();
		cri.setPage(page);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.totalCount(accidentNum));
		
		List<Re_accidentVO>list = dao.listPage(accidentNum, cri);
		
		Map<String,Object> map = new HashMap<>();
		map.put("list",list);
		map.put("pageMaker",pageMaker);

		return map;
	}

	@Override
	public void modifyComment(Re_accidentVO vo) throws Exception {
		dao.modifyComment(vo);
		
	}

	@Override
	public void removeComment(int commentNum) throws Exception {
		dao.removeComment(commentNum);
		
	}
}
