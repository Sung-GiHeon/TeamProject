package net.koreate.testt.common.controller;


import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import net.koreate.testt.common.util.FileUtils;

@RestController
public class FileController {
	
	@Inject
	ServletContext context;
	
	@PostMapping("/uploadFile")
	public ResponseEntity<Object> uploadFile(@RequestParam("file") MultipartFile[] file){
		ResponseEntity<Object> entity = null;
		
		System.out.println(file);
		for(MultipartFile files : file) {
			System.out.println(files.getOriginalFilename());
		}
		try {
			FileUtils utils = FileUtils.getInstance(context);
			List<String> fileList = utils.uploadFile(file);
			entity = new ResponseEntity<>(fileList,HttpStatus.CREATED);
		} catch (IOException e) {
			e.printStackTrace();
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", "text/plain;charset=utf-8");
			entity = new ResponseEntity<>(e.getMessage(),header,HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		FileUtils utils = FileUtils.getInstance(context);
		return new ResponseEntity<byte[]>(
				utils.displayFile(fileName),
				utils.getHeader(fileName),
				HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName) throws IOException{
		FileUtils utils = FileUtils.getInstance(context);
		String result = utils.deleteFile(fileName);
		return new ResponseEntity<>(result,HttpStatus.OK);
	}
	
	@PostMapping("/deleteAllFiles")
	public ResponseEntity<String> deleteAllFiles(
			@RequestParam("files") String files
												) throws IOException{
		ResponseEntity<String> entity = null;
		
			System.out.println("deleteAllFiles : " + files);
		
		String result = FileUtils.getInstance(context).deleteFile(files);
		entity = new ResponseEntity<>(result,HttpStatus.OK);
		return entity;
	}
	
}
