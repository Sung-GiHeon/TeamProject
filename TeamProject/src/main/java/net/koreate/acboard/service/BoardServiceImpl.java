package net.koreate.acboard.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.koreate.acboard.dao.BoardDAO;
import net.koreate.acboard.vo.AccidentBoardVO;
import net.koreate.accomment.dao.Re_AccidentDAO;
import net.koreate.mvc.common.util.PageMaker;
import net.koreate.mvc.common.util.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Inject
	BoardDAO dao;

	
	@Inject
	Re_AccidentDAO commentDAO;
	
	
	@Override
	@Transactional
	public void regist(AccidentBoardVO aboard) throws Exception {
		dao.register(aboard);
		
		List<String> files = aboard.getFiles();
		if(files == null) {
			return;
		}
		
		for(String fullName : files) {
			dao.addAttach(fullName);
		}
		
	}

	//acboard 게시글 들고오기
	@Override
	public List<AccidentBoardVO> listReplyCriteria(SearchCriteria cri) throws Exception {
		System.out.println("listReplyCriteria");
		List<AccidentBoardVO> list = dao.listReplyCriteria(cri);
		for(AccidentBoardVO board : list) {
			board.setCommentCnt(dao.totalCount(board.getAccidentNum()));
		}
		return list;
	}
	
	@Override
	public void updateCnt(int accidentNum) throws Exception {
		dao.updateCnt(accidentNum);
	}

	@Override
	public AccidentBoardVO readReply(int accidentNum) throws Exception {
		return dao.readReply(accidentNum);
	}
	
	
	@Transactional
	@Override
	public void modify(AccidentBoardVO vo) throws Exception {
		// re_tbl_board 정보 수정
		System.out.println(vo);
		dao.modify(vo);
		// 기존 첨부 파일 정보 삭제
		dao.deleteAttach(vo.getAccidentNum());
	
		List<String> fileList = vo.getFiles();
		if(fileList == null || fileList.isEmpty()) {
			return;
		}
		
		for(String fullName : fileList) {
			dao.replaceAttach(vo.getAccidentNum(),fullName);
		}
		
	}
	
	@Transactional
	@Override
	public void delete(int accidentNum) throws Exception {
		
		commentDAO.deleteComment(accidentNum);
		// 첨부파일 목록 삭제
		dao.deleteAttach(accidentNum);
		// 게시글 삭제
		dao.delete(accidentNum);
	}


	@Override
	public PageMaker getPageMaker(SearchCriteria cri) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(dao.listReplyCount(cri));
		return pageMaker;
	}


	@Override
	public List<String> getAttach(int accidentNum) throws Exception {
		return dao.getAttach(accidentNum);
	}
}
