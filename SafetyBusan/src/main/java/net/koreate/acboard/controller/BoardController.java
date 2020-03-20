package net.koreate.acboard.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.koreate.acboard.service.BoardService;
import net.koreate.acboard.vo.AccidentBoardVO;
import net.koreate.mvc.common.util.SearchCriteria;

@Controller
@RequestMapping("/acboard/*")
public class BoardController {
	
	@Inject
	BoardService service;
	
	@GetMapping("register")
	public String registerGet() {
		return "acboard/register";
	}
	
	@PostMapping("register")
	public String registerPost(AccidentBoardVO aboard) throws Exception{
		System.out.println("register : " + aboard);
		System.out.println(aboard.getUploadCheck());
		service.regist(aboard);
		return "redirect:/acboard/listReply";
	}
	
	@GetMapping("listReply")
	public String listReply(
			@ModelAttribute("cri")SearchCriteria cri,
			Model model) throws Exception{
		// 게시물 목록 
		model.addAttribute("list",service.listReplyCriteria(cri));
		// 페이징 정보
		model.addAttribute("pageMaker",service.getPageMaker(cri));
		return "acboard/listReply";
	}
	
	@GetMapping("readPage")
	public String readPage(
			SearchCriteria cri,
			int accidentNum,
			RedirectAttributes rttr
			) throws Exception{
		// 조회수 증가
		service.updateCnt(accidentNum);
		rttr.addAttribute("accidentNum",accidentNum);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		return "redirect:/acboard/read";
	}
	
	@GetMapping("read")
	public String read(
			@ModelAttribute("cri") SearchCriteria cri,
			Model model,
			int accidentNum) throws Exception{
		System.out.println("read : " + cri);
		model.addAttribute("aboard",service.readReply(accidentNum));
		return "acboard/readPage";
	}
	
	
	@GetMapping("replyRegister")
	public String replyRegisterGet(
						int accidentNum,
						@ModelAttribute("cri") SearchCriteria cri,
						Model model
									) throws Exception{
		model.addAttribute("aboard",service.readReply(accidentNum));
		return "acboard/replyRegister";
	}
	
	@PostMapping("replyRegister")
	public String replyRegisterPost(
			RedirectAttributes rttr,
			AccidentBoardVO vo,
			SearchCriteria cri
			)throws Exception{
		// 답변글 등록
		
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		return "redirect:/acboard/listReply";
	}
	
	@GetMapping("modifyPage")
	public String modifyPage(
			int accidentNum,
			@ModelAttribute("cri") SearchCriteria cri,
			Model model
			) throws Exception{
		
		model.addAttribute("aboard",service.readReply(accidentNum));
		
		return "acboard/modifyPage";
	}
	
	
	@PostMapping("modifyPage")
	public String modifyPage(
			AccidentBoardVO vo,
			@ModelAttribute("cri") SearchCriteria cri,
			RedirectAttributes rttr
			) throws Exception{
		
		service.modify(vo);
		
		rttr.addAttribute("accidentNum",vo.getAccidentNum());
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		return "redirect:/acboard/read";
	}
	
	@PostMapping("remove")
	public String remove(
			@ModelAttribute("cri") SearchCriteria cri,
			int accidentNum,
			RedirectAttributes rttr
			)throws Exception{
		
		// 삭제 처리
		service.delete(accidentNum);
		
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType",cri.getSearchType());
		rttr.addAttribute("keyword",cri.getKeyword());
		return "redirect:/acboard/listReply";
	}

	@GetMapping("getAttach/{accidentNum}")
	@ResponseBody
	public List<String> getAttach(
			@PathVariable("accidentNum") int accidentNum
			) throws Exception{
		System.out.println("getAttach : "+ accidentNum);
		return service.getAttach(accidentNum);
	}
}
