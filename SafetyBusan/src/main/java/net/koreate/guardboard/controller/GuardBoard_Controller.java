package net.koreate.guardboard.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.koreate.guardboard.service.GuardBoard_Service;
import net.koreate.guardboard.vo.GuardBoardVO;
import net.koreate.guardcomment.service.GuardCommentService;
import net.koreate.supboard.util.SearchCriteria;

@RequestMapping("/GuardBoard/*")
@Controller
public class GuardBoard_Controller {


	@Inject
	GuardBoard_Service service;

	@Inject
	GuardCommentService gcs;
	
	@GetMapping("Guard_list")
	public String cpboard(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		// 게시물 목록
		model.addAttribute("list", service.listCriteria(cri));
		// 페이징 정보
		model.addAttribute("pageMaker", service.getPageMaker(cri));
		return "GuardBoard/Guard_list";
	}

	@GetMapping("Guard_register")
	public String board_register() {
		return "GuardBoard/Guard_register";
	}

	@PostMapping("Guard_register")
	public String registerPost(GuardBoardVO vo, RedirectAttributes rttr) throws Exception {
		int userNum = Integer.parseInt(vo.getUserNumcopy());
		vo.setUserNum(userNum);
		service.regist(vo);

		return "redirect:Guard_list";
	}
	
	@GetMapping("readPage")
	public String readPage(@ModelAttribute("cri") SearchCriteria cri, @RequestParam("guardNum") int guardNum,
			RedirectAttributes rttr) throws Exception {
		// 조회수 증가
		service.updateViewCnt(guardNum);
		// redirect value
		rttr.addAttribute("guardNum", guardNum);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("guardNum", guardNum);
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/GuardBoard/readDetail";
	}
	
	
	@GetMapping("readDetail")
	public String readDetail(@ModelAttribute("cri") SearchCriteria cri, int guardNum, Model model) throws Exception {

		// 게시물 정보
		model.addAttribute("board", service.read(guardNum));
		return "GuardBoard/Guard_readPage";
	}

	@GetMapping("Guard_modify")
	public String Guard(int guardNum, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		// 수정 할 게시물 정보
		model.addAttribute("board", service.read(guardNum));
		return "/GuardBoard/Guard_modify";
	}

	@PostMapping("Guard_modify")
	public String modifyPage(GuardBoardVO vo, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		int userNum = Integer.parseInt(vo.getUserNumcopy());
		vo.setUserNum(userNum);
		rttr.addAttribute("guardNum",vo.getGuardNum());
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());

		// 수정 성공 유무 flash data 추가
		service.modify(vo);
		return "redirect:/GuardBoard/Guard_readPage";
	}
	
	@PostMapping("Guard_remove")
	public String removePage(int guardNum, SearchCriteria cri, RedirectAttributes rttr) throws Exception {

		service.remove(guardNum);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/GuardBoard/Guard_list";
	}
	@GetMapping("getcommentCnt/{guardNum}")
	   @ResponseBody
	   public int getcommentCnt(@PathVariable("guardNum") int guardNum) throws Exception{
	      return gcs.getcommentCnt(guardNum);
	   
	   }
	
	@GetMapping("getAttach/{guardNum}")
	@ResponseBody
	public List<String> getAttach(@PathVariable("guardNum") int guardNum) throws Exception {
		System.out.println("getAttach : " + guardNum);
		
		return service.getAttach(guardNum);
	}
	
}
