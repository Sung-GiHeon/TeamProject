package net.koreate.nboard.controller;


import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.koreate.mvc.common.util.Criteria;
import net.koreate.mvc.common.util.SearchCriteria;
import net.koreate.nboard.service.NoticeBoardService;
import net.koreate.nboard.vo.NoticeVO;

@Controller
@RequestMapping("/notice/*")
public class NoticeBoardController {

	@Inject
	NoticeBoardService service;
	
	@GetMapping("reg")
	public String registerGet() throws Exception{
		return"/notice/reg";
	}
	
	@PostMapping("reg")
	public String registerPost(NoticeVO nboard, RedirectAttributes rttr) throws Exception{
		System.out.println("regPost 요청");
		System.out.println(nboard);
		String result = service.regist(nboard);
		rttr.addFlashAttribute("result",result);
		return "redirect:/notice/list";
	}
	
	@GetMapping("list")
	public String listPage(@ModelAttribute("cri") Criteria cri, Model model ,ModelAndView mav)throws Exception{
		model.addAttribute("list",service.listCriteria(cri));
		model.addAttribute("pageMaker",service.getPageMaker(cri));
		
		return "notice/list";
	}
	
	@GetMapping("readPage")
	public String readPage(
			SearchCriteria cri,
			int noticeNum,
			RedirectAttributes rttr
			) throws Exception{
		// 조회수 증가
		service.updateCnt(noticeNum);
		rttr.addAttribute("noticeNum",noticeNum);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		return "redirect:/notice/read";
	}
	
	@GetMapping("read")
	public String read(
			@ModelAttribute("cri") SearchCriteria cri,
			Model model,
			int noticeNum) throws Exception{
		System.out.println("read : " + cri);
		model.addAttribute("nboard",service.readReply(noticeNum));
		return "notice/read";
	}
	
	
	@GetMapping("modify")
	public String modifyGet(
			int noticeNum, 
			@ModelAttribute("cri") Criteria cri,
			Model model) throws Exception{
		model.addAttribute("NoticeVO", service.read(noticeNum));
		return "notice/modify";
	}
		
	@PostMapping("modify")
	public String modifyPost(
			RedirectAttributes rttr,
			Criteria cri,
			NoticeVO nboard) throws Exception{
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addFlashAttribute("result",service.modify(nboard));
		return "redirect:/notice/list";
	}
	
	@PostMapping("remove")
	public String remove(
			@RequestParam(name="noticeNum") int noticeNum,
			Criteria cri,
			RedirectAttributes rttr
			) throws Exception{
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addFlashAttribute("result",service.remove(noticeNum));		
		
		return "redirect:/notice/list";
	}
}
