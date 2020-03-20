package net.koreate.supcomment.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import net.koreate.supboard.util.Criteria;
import net.koreate.supboard.util.PageMaker;
import net.koreate.supcomment.dao.CommentDAO;
import net.koreate.supcomment.vo.Re_supportVO;

@Service
public class CommentServiceImpl implements CommentService{

	@Inject
	CommentDAO dao;
	
	@Override
	public void addComment(Re_supportVO vo) throws Exception {
		dao.addComment(vo);
	}

	@Override
	public Map<String, Object> listPage(int supportNum, int page) throws Exception {
		Criteria cri = new Criteria();
		cri.setPage(page);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.totalCount(supportNum));
		
		List<Re_supportVO> list = dao.listPage(supportNum, cri);
		
		Map<String , Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pageMaker", pageMaker);
		
		return map;
	}

	@Override
	public void modifyComment(Re_supportVO vo) throws Exception {
		dao.modifyComment(vo);
	}
	
	@Override
	public void removeComment(int re_supportNum) throws Exception{
		dao.removeComment(re_supportNum);
	}

	@Override
	public int getcommentCnt(int supportNum) throws Exception {
		return dao.totalCount(supportNum);
	}

	
	
	
}
