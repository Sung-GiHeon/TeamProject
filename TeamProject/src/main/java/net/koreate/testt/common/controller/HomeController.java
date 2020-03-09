package net.koreate.testt.common.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;





/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	 public static StringBuilder sb;//
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		String clientId = "mZjUv92wcJAIp7O4s3_Z";
        String clientSecret = "4WCMAggMe0";
        int display = 4; 
        int newsDisplay = 2;
       
        try {
            String text = URLEncoder.encode("범죄", "utf-8");
            String apiURL = "https://openapi.naver.com/v1/search/blog.json?query=" + text + "&display=" + display + "&";
 
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            int responseCode = con.getResponseCode();
            BufferedReader br;

            if (responseCode == 200) { 
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
                
            } else { 
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            
            String line;
            String result="";
            
            while ((line = br.readLine()) != null) {
            	result=result.concat(line);
            }
            // System.out.println(result);
            JSONParser parser = new JSONParser(); 
            JSONObject obj = (JSONObject) parser.parse(result);
            
            JSONArray parse_response = (JSONArray) obj.get("items"); 
            // System.out.println(parse_response);
            
            br.close();
            con.disconnect();
            model.addAttribute("blogData", parse_response );
       
        } catch (Exception e) {
            System.out.println(e);
        }
        try {
            String text = URLEncoder.encode("범죄", "utf-8");
            String apiURL = "https://openapi.naver.com/v1/search/news.json?query=" + text + "&display=" + newsDisplay + "&";
 
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            
            int responseCode = con.getResponseCode();
            
            
            BufferedReader br;

            if (responseCode == 200) { 
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
                
            } else { 
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            
          
            
            String line;
            String result="";
            
            while ((line = br.readLine()) != null) {

            	result=result.concat(line);
            	
            }
            // System.out.println(result);
            
            JSONParser parser = new JSONParser(); 
            JSONObject obj = (JSONObject) parser.parse(result);
            
            JSONArray parse_response = (JSONArray) obj.get("items"); 
            // System.out.println(parse_response);
            
            br.close();
            con.disconnect();
           
            
            model.addAttribute("NewsData", parse_response );
       
            
        } catch (Exception e) {
            System.out.println(e);
        }
        
        
		
		return "home";
	}
	

	/* 블로그 테스트  */
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String testBlog(Locale locale, Model model) {
	        
		
			String clientId = "mZjUv92wcJAIp7O4s3_Z";
	        String clientSecret = "4WCMAggMe0";
	        int display = 2; 
	       
	        try {
	            String text = URLEncoder.encode("살인", "utf-8");
	            String apiURL = "https://openapi.naver.com/v1/search/news.json?query=" + text + "&display=" + display + "&";
	 
	            URL url = new URL(apiURL);
	            HttpURLConnection con = (HttpURLConnection) url.openConnection();
	            con.setRequestMethod("GET");
	            con.setRequestProperty("X-Naver-Client-Id", clientId);
	            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	            
	            int responseCode = con.getResponseCode();
	            
	            
	            BufferedReader br;

	            if (responseCode == 200) { 
	                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	                
	            } else { 
	                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	            }
	            
	          
	            
	            String line;
	            String result="";
	            
	            while ((line = br.readLine()) != null) {

	            	result=result.concat(line);
	            	
	            }
	            // System.out.println(result);
	            
	            JSONParser parser = new JSONParser(); 
	            JSONObject obj = (JSONObject) parser.parse(result);
	            
	            JSONArray parse_response = (JSONArray) obj.get("items"); 
	            System.out.println(parse_response);
	            
	            br.close();
	            con.disconnect();
	           
	            
	            model.addAttribute("blogData", parse_response );
	       
	            
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	        
	        try {
	            String text = URLEncoder.encode("살인", "utf-8");
	            String apiURL = "https://openapi.naver.com/v1/search/news.json?query=" + text + "&display=" + display + "&";
	 
	            URL url = new URL(apiURL);
	            HttpURLConnection con = (HttpURLConnection) url.openConnection();
	            con.setRequestMethod("GET");
	            con.setRequestProperty("X-Naver-Client-Id", clientId);
	            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	            
	            int responseCode = con.getResponseCode();
	            
	            
	            BufferedReader br;

	            if (responseCode == 200) { 
	                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	                
	            } else { 
	                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	            }
	            
	          
	            
	            String line;
	            String result="";
	            
	            while ((line = br.readLine()) != null) {

	            	result=result.concat(line);
	            	
	            }
	            // System.out.println(result);
	            
	            JSONParser parser = new JSONParser(); 
	            JSONObject obj = (JSONObject) parser.parse(result);
	            
	            JSONArray parse_response = (JSONArray) obj.get("items"); 
	            System.out.println(parse_response);
	            
	            br.close();
	            con.disconnect();
	           
	            
	            model.addAttribute("NewsData", parse_response );
	       
	            
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	        
	        
	        
	        
	        
		return "/madang/blog/test";
	}

/********************************************************************/







}
