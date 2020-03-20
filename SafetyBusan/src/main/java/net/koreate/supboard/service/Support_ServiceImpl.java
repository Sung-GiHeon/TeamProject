package net.koreate.supboard.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.koreate.supboard.dao.Support_DAO;
import net.koreate.supboard.util.PageMaker;
import net.koreate.supboard.util.SearchCriteria;
import net.koreate.supboard.vo.SupportBoardVO;
import net.koreate.supcomment.dao.CommentDAO;

@Service
public class Support_ServiceImpl implements Support_Service {

	@Inject
	Support_DAO dao;

	
	@Inject 
	CommentDAO commentDao;
	 
	
	@Override
	@Transactional
	public void regist(SupportBoardVO vo) throws Exception {
		List<String> files = vo.getFile();
		String from = vo.getEnddate();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = transFormat.parse(from);
		long enddate = date.getTime();
		long now = new Date().getTime();
		if((enddate-now)<=0) {
			vo.setRecm("n");
		}else {
			vo.setRecm("y");
		}

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
	public List<SupportBoardVO> listCriteria(SearchCriteria cri) throws Exception {
		List<SupportBoardVO> list = dao.listCriteria(cri);
		
		for(SupportBoardVO board : list) {
			board.setCommentCnt(commentDao.totalCount(board.getSupportNum()));
		}
		
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
	public void updateViewCnt(int supportNum) throws Exception {
		dao.updateCnt(supportNum);

	}

	@Override
	public SupportBoardVO read(int supportNum) throws Exception {
		return dao.read(supportNum);
	}

	public String getResult(int result) {
		String msg = "FAIL";
		if (result > 0) {
			msg = "SUCCESS";
		}
		return msg;
	}

	@Override
	public void modify(SupportBoardVO board) throws Exception {
		
		int userNum = Integer.parseInt(board.getUserNumcopy());
		board.setUserNum(userNum);
		String from = board.getEnddate();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date date = transFormat.parse(from);
		long enddate = date.getTime();
		long now = new Date().getTime();
		if((enddate-now)<=0) {
			board.setRecm("n");
		}else {
			board.setRecm("y");
		}
		// re_tbl_board 정보 수정
		// 기존 첨부 파일 정보 삭제
		dao.modify(board);
		dao.deleteAttach(board.getSupportNum());

		List<String> fileList = board.getFile();
		if (fileList == null || fileList.isEmpty()) {
			dao.UploadNCheck(board);
			return;
		}else {
			dao.UploadYCheck(board);
			for (String fullName : fileList) {
				dao.replaceAttach(board.getSupportNum(), fullName);
			}
		}
	}

	@Override
	public void remove(int supportNum) throws Exception {
		dao.deleteAttach(supportNum);
		commentDao.deleteComment(supportNum);
		dao.remove(supportNum);
	}

	@Override
	public List<String> getAttach(int supportNum) throws Exception {
		return dao.getAttach(supportNum);
	}

	@Override
	public void Timerout(SupportBoardVO vo) throws Exception {
		dao.Timerout(vo);
		dao.recmNCheck(vo);
	}

}
