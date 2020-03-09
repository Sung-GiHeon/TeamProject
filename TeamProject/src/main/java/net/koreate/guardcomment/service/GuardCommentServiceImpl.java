package net.koreate.guardcomment.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import net.koreate.guardcomment.dao.GuardCommentDAO;
import net.koreate.guardcomment.vo.Re_guardVO;
import net.koreate.supboard.util.Criteria;
import net.koreate.supboard.util.PageMaker;

@Service
public class GuardCommentServiceImpl implements GuardCommentService{

	@Inject
	GuardCommentDAO dao;
	
	@Override
	public void addComment(Re_guardVO vo) throws Exception {
		dao.addComment(vo);
	}

	@Override
	public Map<String, Object> listPage(int guardNum, int page) throws Exception {
		Criteria cri = new Criteria();
		cri.setPage(page);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.totalCount(guardNum));
		
		List<Re_guardVO> list = dao.listPage(guardNum, cri);
		
		Map<String , Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pageMaker", pageMaker);
		
		return map;
	}

	@Override
	public void modifyComment(Re_guardVO vo) throws Exception {
		dao.modifyComment(vo);
	}
	
	@Override
	public void removeComment(int re_guardNum) throws Exception{
		dao.removeComment(re_guardNum);
	}

	@Override
	public int getcommentCnt(int guardNum) throws Exception {
		return dao.totalCount(guardNum);
	}

	
	
	
}
