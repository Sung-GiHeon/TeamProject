package net.koreate.supboard.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.koreate.supboard.service.Support_Service;
import net.koreate.supboard.util.SearchCriteria;
import net.koreate.supboard.vo.SupportBoardVO;
import net.koreate.supcomment.service.CommentService;

@RequestMapping("/Support/*")
@Controller
public class Support_Controller {

	
	@Inject
	Support_Service service;
	
	@Inject
	CommentService cs;

	@GetMapping("board_list")
	public String cpboard(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		// 게시물 목록
		model.addAttribute("list", service.listCriteria(cri));
		// 페이징 정보
		model.addAttribute("pageMaker", service.getPageMaker(cri));
		return "Support/board_list";
	}

	@GetMapping("board_register")
	public String board_register() {
		return "Support/board_register";
	}

	@PostMapping("board_register")
	public String registerPost(SupportBoardVO vo, RedirectAttributes rttr) throws Exception {
		int userNum = Integer.parseInt(vo.getUserNumcopy());
		vo.setUserNum(userNum);
		vo.setEnddate(vo.getEnddate() + " 23:59:59");
		service.regist(vo);

		return "redirect:board_list";
	}


	@GetMapping("board_readPage")
	public String readPage(@ModelAttribute("cri") SearchCriteria cri, @RequestParam("supportNum") int supportNum,
			RedirectAttributes rttr) throws Exception {
		// 조회수 증가
		service.updateViewCnt(supportNum);
		// redirect value
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("supportNum", supportNum);
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/Support/readDetail";
	}

	@GetMapping("readDetail")
	public String readDetail(@ModelAttribute("cri") SearchCriteria cri,SupportBoardVO vo,
				int supportNum, Model model) throws Exception {
		// 게시물 정보
		model.addAttribute("board", service.read(supportNum));
		return "Support/board_readPage";
	}

	@GetMapping("board_modify")
	public String modifyPage(int supportNum, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {
		
		// 수정 할 게시물 정보
		model.addAttribute("board", service.read(supportNum));
		return "/Support/board_modify";
	}

	@PostMapping("board_modify")
	public String modifyPage(SupportBoardVO vo, SearchCriteria cri, RedirectAttributes rttr) throws Exception {
		int userNum = Integer.parseInt(vo.getUserNumcopy());
		vo.setUserNum(userNum);
		
		rttr.addAttribute("supportNum",vo.getSupportNum());
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		// String으로 받은 date -> 원래 vo 값에 저장
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date to = transFormat.parse(vo.getStartdate());
		vo.setRegdate(to);
		vo.setEnddate(vo.getEnddate().substring(0,10));
		if (vo.getEnddate().indexOf("23:59:59") < 0) {
			vo.setEnddate(vo.getEnddate() + " 23:59:59");
		}
		// 수정 성공 유무 flash data 추가
		service.modify(vo);
		return "redirect:/Support/board_readPage";
	}

	@PostMapping("board_remove")
	public String removePage(int supportNum, SearchCriteria cri, RedirectAttributes rttr) throws Exception {

		service.remove(supportNum);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());

		// 삭제 성공 유무 flash data 추가
		return "redirect:/Support/board_list";
	}
	
	@PostMapping("/out")
	public ResponseEntity<String> Timeout(
			@RequestBody SupportBoardVO vo) throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			service.Timerout(vo);
			entity = new ResponseEntity<>("SUCCESS",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@GetMapping("getcommentCnt/{supportNum}")
	   @ResponseBody
	   public int getcommentCnt(@PathVariable("supportNum") int supportNum) throws Exception{
	      return cs.getcommentCnt(supportNum);
	   
	   }
	
	@GetMapping("getAttach/{supportNum}")
	@ResponseBody
	public List<String> getAttach(@PathVariable("supportNum") int supportNum) throws Exception {
		System.out.println("getAttach : " + supportNum);
		
		return service.getAttach(supportNum);
	}
	
}
