package net.koreate.nboard.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import net.koreate.mvc.common.util.Criteria;
import net.koreate.mvc.common.util.PageMaker;
import net.koreate.nboard.dao.NoticeBoardDAO;
import net.koreate.nboard.vo.NoticeVO;


@Service
public class NoticeBoardServiceImpl implements NoticeBoardService{

	@Inject
	NoticeBoardDAO dao;
	
	
	@Override
	public String regist(NoticeVO nboard) throws Exception {
		return getMessage(dao.create(nboard));
	}

	@Override
	public NoticeVO read(int noticeNum) throws Exception {
		return dao.read(noticeNum);
	}

	@Override
	public String modify(NoticeVO nboard) throws Exception {
		return getMessage(dao.update(nboard));
	}

	@Override
	public String remove(int noticeNum) throws Exception {
		return getMessage(dao.delete(noticeNum));
	}

	@Override
	public List<NoticeVO> listCriteria(Criteria cri) throws Exception {
		return dao.listCriteria(cri);
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.listCount());
		return pageMaker;
	}
	
	public String getMessage(int result) {
		String message = (result != 0)? "SUCCESS" : "FAILED" ; 
		return message;
	}

	@Override
	public void updateCnt(int noticeNum) throws Exception {
		dao.updateCnt(noticeNum);
		
	}

	@Override
	public NoticeVO readReply(int noticeNum) {
		return dao.readReply(noticeNum);
		
	}
}
