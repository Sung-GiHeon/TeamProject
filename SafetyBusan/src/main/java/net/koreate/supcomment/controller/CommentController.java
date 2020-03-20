package net.koreate.supcomment.controller;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import net.koreate.supcomment.service.CommentService;
import net.koreate.supcomment.vo.Re_supportVO;

@RestController
@RequestMapping("/sup_comments")
public class CommentController {
	
	@Inject
	CommentService cs;
	
	@PostMapping("/add")
	public ResponseEntity<String> addComment(
			@RequestBody Re_supportVO vo) throws Exception{
		ResponseEntity<String> entity = null;
		System.out.println("userNum : " + vo.getUserNum());
		try {
			cs.addComment(vo);
			entity = new ResponseEntity<>("SUCCESS",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// /comments/bno/page - 
	@GetMapping("/{supportNum}/{page}")
	public ResponseEntity<Map<String , Object>> listPage(
			@PathVariable("supportNum") int supportNum,
			@PathVariable("page") int page
			){
		ResponseEntity<Map<String, Object>> entity = null;
		try {
			Map<String , Object> map = cs.listPage(supportNum, page);
			entity = new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@PatchMapping("/{re_supportNum}")
	public ResponseEntity<String> update(
			@PathVariable("re_supportNum") int re_supportNum,
			@RequestBody Re_supportVO vo
			){
		ResponseEntity<String> entity = null;
		vo.setRe_supportNum(re_supportNum);
		
		try {
			cs.modifyComment(vo);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@DeleteMapping("/{re_supportNum}")
	public ResponseEntity<String> update(
			@PathVariable("re_supportNum") int re_supportNum
			){
		ResponseEntity<String> entity = null;
		
		try {
			cs.removeComment(re_supportNum);
			entity = new ResponseEntity<>("SUCCESS",HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}


