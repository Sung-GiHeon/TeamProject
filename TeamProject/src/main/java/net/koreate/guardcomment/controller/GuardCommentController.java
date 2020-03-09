package net.koreate.guardcomment.controller;

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

import net.koreate.guardcomment.service.GuardCommentService;
import net.koreate.guardcomment.vo.Re_guardVO;

@RestController
@RequestMapping("/Guardcomments")
public class GuardCommentController {
	
	@Inject
	GuardCommentService cs;
	
	@PostMapping("/add")
	public ResponseEntity<String> addComment(
			@RequestBody Re_guardVO vo) throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			cs.addComment(vo);
			entity = new ResponseEntity<>("SUCCESS",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@GetMapping("/{guardNum}/{page}")
	public ResponseEntity<Map<String , Object>> listPage(
			@PathVariable("guardNum") int guardNum,
			@PathVariable("page") int page
			){
		ResponseEntity<Map<String, Object>> entity = null;
		
		try {
			Map<String , Object> map = cs.listPage(guardNum, page);
			entity = new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@PatchMapping("/{re_guardNum}")
	public ResponseEntity<String> update(
			@PathVariable("re_guardNum") int re_guardNum,
			@RequestBody Re_guardVO vo
			){
		ResponseEntity<String> entity = null;
		vo.setRe_guardNum(re_guardNum);
		
		try {
			cs.modifyComment(vo);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@DeleteMapping("/{re_guardNum}")
	public ResponseEntity<String> update(
			@PathVariable("re_guardNum") int re_guardNum
			){
		ResponseEntity<String> entity = null;
		
		try {
			cs.removeComment(re_guardNum);
			entity = new ResponseEntity<>("SUCCESS",HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
	}
	
	
	
	
	
}


