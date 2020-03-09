package net.koreate.qnaboard.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import net.koreate.mvc.common.util.SearchCriteria;
import net.koreate.qnaboard.service.QnaBoardService;
import net.koreate.qnaboard.vo.Re_qnaVO;

@Controller
@RequestMapping("/qnaboard/*")
public class QnaBoardController {

	@Inject
	QnaBoardService service;
	
	@GetMapping("register")
	public String registerGet() {
		return "qnaboard/register";
	}
	
	@PostMapping("register")
	public String registerPost(Re_qnaVO board) throws Exception{
		System.out.println("register : "+ board);
		service.regist(board);
		return "redirect:/qnaboard/listReply";
	}
	
	@GetMapping("listReply")
	public String listReply(
			@ModelAttribute("cri")SearchCriteria cri,
			Model model) throws Exception{
		System.out.println(cri);
		// 게시물 목록 
		model.addAttribute("list",service.listReplyCriteria(cri));
		// 페이징 정보
		model.addAttribute("pageMaker",service.getPageMaker(cri));
		return "qnaboard/listReply";
	}
	
	@GetMapping("readPage")
	public String readPage(
			SearchCriteria cri,
			int re_qnaNum,
			RedirectAttributes rttr
			) throws Exception{
		// 조회수 증가
		service.updateCnt(re_qnaNum);
		rttr.addAttribute("re_qnaNum",re_qnaNum);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		return "redirect:/qnaboard/read";
	}
	
	@GetMapping("read")
	public String read(
			@ModelAttribute("cri") SearchCriteria cri,
			Model model,
			int re_qnaNum) throws Exception{
		System.out.println("read : " + cri);
		model.addAttribute("board",service.readReply(re_qnaNum));
		return "qnaboard/readPage";
	}
	
	
	@GetMapping("replyRegister")
	public String replyRegisterGet(
									int re_qnaNum,
									@ModelAttribute("cri") SearchCriteria cri,
									Model model
									) throws Exception{
		model.addAttribute("board",service.readReply(re_qnaNum));
		System.out.println("vo : "+ service.readReply(re_qnaNum));
		return "qnaboard/replyRegister";
	}
	
	
	@PostMapping("replyRegister")
	public String replyRegisterPost(
			RedirectAttributes rttr,
			Re_qnaVO vo,
			SearchCriteria cri
			)throws Exception{
		// 답변글 등록
		System.out.println("post vo : "+vo);
		service.replyRegister(vo);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		return "redirect:/qnaboard/listReply";
	}
	
	@GetMapping("modifyPage")
	public String modifyPage(
			int re_qnaNum,
			@ModelAttribute("cri") SearchCriteria cri,
			Model model
			) throws Exception{
		
		model.addAttribute("board",service.readReply(re_qnaNum));
		
		return "qnaboard/modifyPage";
	}
	
	@PostMapping("modifyPage")
	public String modifyPage(
			Re_qnaVO vo,
			@ModelAttribute("cri") SearchCriteria cri,
			RedirectAttributes rttr
			) throws Exception{
		
		service.modify(vo);
		
		rttr.addAttribute("re_qnaNum",vo.getRe_qnaNum());
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		return "redirect:/qnaboard/read";
	}
	

	@PostMapping("remove")
	public String remove(
			@ModelAttribute("cri") SearchCriteria cri,
			int re_qnaNum,
			RedirectAttributes rttr
			)throws Exception{
		
		// 삭제 처리
		service.remove(re_qnaNum);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		return "redirect:/qnaboard/listReply";
	}
}
