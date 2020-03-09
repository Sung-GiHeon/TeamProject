package net.koreate.guardboard.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.koreate.guardboard.dao.GuardBoard_DAO;
import net.koreate.guardboard.vo.GuardBoardVO;
import net.koreate.guardcomment.dao.GuardCommentDAO;
import net.koreate.supboard.util.PageMaker;
import net.koreate.supboard.util.SearchCriteria;

@Service
public class GuardBoard_ServiceImpl implements GuardBoard_Service {
	
	@Inject
	GuardBoard_DAO dao;

	@Inject
	GuardCommentDAO commentDAO;
	
	
	@Override
	@Transactional
	public void regist(GuardBoardVO vo) throws Exception {
		List<String> files = vo.getFile();
		if (files == null) {
			dao.register(vo);
			return;
		}else {
			dao.Upload_register(vo);
			for (String fullName : files) {
				dao.addAttach(fullName);
			}
		}
	}
	
	
	
	@Override
	public List<GuardBoardVO> listReplyCriteria(SearchCriteria cri) throws Exception {
		List<GuardBoardVO> list = dao.listReplyCriteria(cri);
		return list;
	}
	
	
	@Override
	public PageMaker getPageMaker(SearchCriteria cri) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.listCount(cri));
		return pageMaker;
	}

	@Override
	public List<GuardBoardVO> listCriteria(SearchCriteria cri) throws Exception {
		return dao.listCriteria(cri);
	}
	
	@Override
	public void updateViewCnt(int guardNum) throws Exception {
		dao.updateCnt(guardNum);

	}

	@Override
	public GuardBoardVO read(int guardNum) throws Exception {
		return dao.read(guardNum);
	}

	public String getResult(int result) {
		String msg = "FAIL";
		if (result > 0) {
			msg = "SUCCESS";
		}
		return msg;
	}

	@Override
	public void modify(GuardBoardVO board) throws Exception {
			
		System.out.println("guardNum :" + board.getGuardNum());
		
		dao.deleteAttach(board.getGuardNum());
		List<String> fileList = board.getFile();
		if (fileList == null || fileList.isEmpty()) {
			dao.modify(board);
			return;
		}else {
			dao.Upload_modify(board);
			for (String fullName : fileList) {
				dao.replaceAttach(board.getGuardNum(), fullName);
			}
		}
	}

	@Override
	public void remove(int guardNum) throws Exception {
		dao.deleteAttach(guardNum);
		commentDAO.deleteComment(guardNum);
		dao.remove(guardNum);
	}

	@Override
	public List<String> getAttach(int guardNum) throws Exception {
		return dao.getAttach(guardNum);
	}

	
	
}
