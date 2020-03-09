package net.koreate.accomment.controller;

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

import net.koreate.accomment.service.Re_AccidentService;
import net.koreate.accomment.vo.Re_accidentVO;




@RestController
@RequestMapping("/comments")
public class Re_AccidentController {
	
	@Inject
	Re_AccidentService cs;
	
	@PostMapping("/add")
	public ResponseEntity<String> addComment(@RequestBody Re_accidentVO vo)throws Exception{
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
	
	// /comments/bno/page - 
	@GetMapping("/{accidentNum}/{page}")
	public ResponseEntity<Map<String , Object>> listPage(
			@PathVariable("accidentNum") int accidentNum,
			@PathVariable("page") int page
			){
		ResponseEntity<Map<String , Object>> entity = null;
		try {
			Map<String , Object> map = cs.listPage(accidentNum, page);
			entity = new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@PatchMapping("/{commentNum}")
	public ResponseEntity<String> update(
			@PathVariable("commentNum") int commentNum,
			@RequestBody Re_accidentVO vo){
		ResponseEntity<String> entity = null;
		
		vo.setCommentNum(commentNum);
		
		try {
			cs.modifyComment(vo);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@DeleteMapping("/{commentNum}")
	public ResponseEntity<String> delete(
			@PathVariable("commentNum") int commentNum){
		ResponseEntity<String> entity = null;
		try {
			cs.removeComment(commentNum);
			entity = new ResponseEntity<>("DELETED" ,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage() ,HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
