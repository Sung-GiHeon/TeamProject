package net.koreate.qnaboard.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.koreate.mvc.common.util.PageMaker;
import net.koreate.mvc.common.util.SearchCriteria;
import net.koreate.qnaboard.dao.QnaBoardDAO;
import net.koreate.qnaboard.vo.Re_qnaVO;

@Service
public class QnaBoardServiceImpl implements QnaBoardService{

	@Inject
	QnaBoardDAO dao;
	
	@Override
	public void regist(Re_qnaVO board) throws Exception {
		dao.register(board);
		dao.updateOrigin();
		
	}

	@Override
	public List<Re_qnaVO> listReplyCriteria(SearchCriteria cri) throws Exception {
		System.out.println("listReplyCriteria");
		return dao.listReplyCriteria(cri);
	}

	@Override
	public PageMaker getPageMaker(SearchCriteria cri) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.listReplyCount(cri));
		return pageMaker;
	}

	@Override
	public void updateCnt(int re_qnaNum) throws Exception {
		dao.updateCnt(re_qnaNum);
		
	}

	@Override
	public Re_qnaVO readReply(int re_qnaNum) throws Exception {
		return dao.readReply(re_qnaNum);
	}
	
	@Transactional
	@Override
	public void replyRegister(Re_qnaVO vo) throws Exception {
		
		dao.updateReply(vo);
		
		vo.setDept(vo.getDept()+1);
		vo.setSeq(vo.getSeq()+1);
		
		System.out.println("getDept : "+vo.getDept());
		
		dao.replyRegister(vo);
		
	}

	@Override
	public void modify(Re_qnaVO vo) throws Exception {
		dao.modify(vo);
	}

	@Override
	public void remove(int re_qnaNum) throws Exception {
		dao.remove(re_qnaNum);
		
	}


}
