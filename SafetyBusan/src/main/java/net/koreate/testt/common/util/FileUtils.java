package net.koreate.testt.common.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class FileUtils {
	
	ServletContext context;
	
	String uploadPath;
	
	private static FileUtils utils;
	
	private FileUtils() {}
	
	private FileUtils(ServletContext context) {
		this.context =context;
		createUploadPath();
	}
	
	public static FileUtils getInstance(ServletContext context) {
		if(utils == null) {
			utils = new FileUtils(context);
		}
		return utils;
	}
	
	// 업로드 경로에 폴더 생성
	private void createUploadPath() {
		uploadPath = context.getRealPath(File.separator+"upload");
		System.out.println("uploadPath : " + uploadPath);
		File file = new File(uploadPath);
		if(!file.exists()) {
			System.out.println("경로 생성");
			file.mkdirs();
		}
	}
	
	public List<String> uploadFile(MultipartFile[] files) throws IOException{
		List<String> fileList = new ArrayList<>();
		
		for(MultipartFile file : files) {
			
			try {
				String fileName = uploadFile(file);
				fileList.add(fileName);
			} catch (Exception e) {
				e.printStackTrace();
				throw new IOException("업로드 할 수 없는 파일이 포함되어 있습니다.");
			}
		}
		
		return fileList;
	}
	
	public String uploadFile(MultipartFile file) throws IOException{
		String uploadFolder = getFolder();
		System.out.println("uploadFolder : " + uploadFolder);
		
		String originalName = file.getOriginalFilename();
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString().replace("-", "")+"_"+originalName;
		System.out.println("uploadFile savedName :" + savedName);
		
		File uploadFolderFile = new File(uploadPath,uploadFolder);
		if(!uploadFolderFile.exists()) {
			uploadFolderFile.mkdirs();
		}
		
		File upload = new File(uploadPath+File.separator+uploadFolder,savedName);
		
		System.out.println("upload file absolte path"+upload.getAbsolutePath());
		
		byte[] fileData = file.getBytes();	
		
		FileCopyUtils.copy(fileData, upload);
		
		return makeFileUploadName(uploadFolder,savedName);
	}
	
	private String makeFileUploadName(
			String uploadFolder, 
			String savedName) throws IOException{
		
		String ex = savedName.substring(savedName.lastIndexOf(".")+1);
		
		String thumnail = uploadPath+File.separator+uploadFolder+File.separator+savedName;
		
		System.out.println("thumNail :" + thumnail);
		
		if(MediaUtils.getMediaType(ex) != null) {
			System.out.println("IMAGE");
			
			try {
				File file = new File(uploadPath+File.separator+uploadFolder,savedName);
				
				BufferedImage fileImage = ImageIO.read(file);
				
				BufferedImage sourceImage 
							= Scalr.resize(
									fileImage, 
									Scalr.Method.AUTOMATIC,
									Scalr.Mode.FIT_TO_HEIGHT
									,100);
				thumnail = uploadPath+File.separator+uploadFolder+File.separator+"s_"+savedName;
				file = new File(thumnail);
				
				ImageIO.write(sourceImage,ex,file);
			} catch (Exception e) {
				e.printStackTrace();
				throw new IOException();
			}
		}
		return thumnail.substring(uploadPath.length()).replace(File.separatorChar, '/');	
	}
	
	public byte[] displayFile(String fileName) throws IOException{
		System.out.println("fileName : " + fileName);
		
		InputStream in = null;
		System.out.println("file : " + File.separatorChar);
		System.out.println("uploadPath : " + uploadPath);
		System.out.println("separatorChar : "+(fileName).replace('/', File.separatorChar));
		// ('/'되어있는 것을 -> '\'로 변경)
		String path = uploadPath + (fileName).replace('/', File.separatorChar);
		System.out.println("path : " + path);
		byte[] bytes = null;
		try {
			in = new FileInputStream(path);
			bytes = IOUtils.toByteArray(in);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			in.close();
		}
		return bytes;
	}
	
	public HttpHeaders getHeader(String fileName) throws Exception{
		HttpHeaders header = null;
		
		header = new HttpHeaders();
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		
		MediaType mType = MediaUtils.getMediaType(formatName);
		
		if(mType != null) {
			System.out.println("IMAGE");
			header.setContentType(mType);
		}else {
			// 다운로드
			fileName = fileName.substring(fileName.indexOf("_")+1);
			
			header.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			header.add(
					"content-disposition",
					"attachment;fileName=\""
					+new String(fileName.getBytes("utf-8"),"ISO-8859-1")+"\"");
		}
		return header;
	}
	
	
	// 
	public String getFolder() {
		//SimpleDateFormat = 날짜구분
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str = sdf.format(new Date());
		System.out.println(str);
		// File.separator 파일경로를 구분해줌 '/' ex)C:\Documents\Test
		return str.replace("-", File.separator);
	}

	public String deleteAllFiles(List<String> files) {
		for(String file : files) {
			String ex = file.substring(file.lastIndexOf(".")+1);
			if(MediaUtils.getMediaType(ex) != null) {
				// 원본도 삭제
				String name = file.replace("s_", "");
				new File(uploadPath+(name).replace('/', File.separatorChar)).delete();
			}
			new File(uploadPath+(file).replace('/', File.separatorChar)).delete();
		}
		return "DELETED";
	}

	
	public String deleteFile(String fileName) {
		String ex = fileName.substring(fileName.lastIndexOf(".")+1);
		if(MediaUtils.getMediaType(ex) != null) {
			// 원본도 삭제
			String name = fileName.replace("s_", "");
			new File(uploadPath+(name).replace('/', File.separatorChar)).delete();
		}
		new File(uploadPath+(fileName).replace('/', File.separatorChar)).delete();
		return "DELETED";
	}
	
	
	public void removeList(List<String> list, String path) throws Exception{
		System.out.println("List fileName : "+list);
		if(!list.isEmpty()) {
			System.out.println("list 확인");
			String realPath = path.replace('/',File.separatorChar);
			System.out.println("List realPath : "+realPath);
			
			List<String> removeList = new ArrayList<>();
			File file = new File(uploadPath,realPath);
			
			List<File> files = Arrays.asList(file.listFiles());
			
			for(File f : files) {
				System.out.println(f.getName());
				String removeFilePath = path+f.getName();
				String thumNail = path+"s_"+f.getName();
				// 해당 파일이 존재 안할시 removeList에 추가
				if(!list.contains(removeFilePath) && !list.contains(thumNail)) {
					removeList.add(removeFilePath);
				}
			}
			
			// 리스트 정보 뽑아온다.
			for(String s : removeList) {
				System.out.println("removeFile : " + s);
			}
			
			// 지워야할 목록이 존재시 삭제
			if(!removeList.isEmpty()) {
				System.out.println(deleteAllFiles(removeList));
			}
		}
	}
	
	

}
