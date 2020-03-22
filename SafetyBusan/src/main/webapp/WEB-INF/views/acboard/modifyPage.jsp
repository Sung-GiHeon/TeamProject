<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.fileDrop{
		width:100%;
		height:150px;
		border:1px solid gray;
		background-color:lightgray;
		margin:auto;
	}
	
	.uploadList{
		width:100%;
	}
	
	.uploadList li{
		float:left;
		padding:20px;
		list-style:none;
	}
	
</style>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/main.css" />
<noscript><link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/noscript.css" /></noscript>
</head>
<body class="is-preload"> 
<div id="page-wrapper">
<jsp:include page="../Sub_header.jsp"/>
<article id="main">
<header>
	<div style="margin:0 3em 0 0">
	<h2>Accident Board</h2>
	<p>Solve your questions here & We will answer sincerely.</p>
	<h1><a href="${pageContext.request.contextPath}">HOME</a></h1>
	</div>
</header>
<section class="wrapper style5">	
	<div class="inner" style="height:100px;" align="center">
	<h3>게시글 수정</h3>
	</div>
<div class="table-wrapper" style="max-height:1500px; width:50%; margin:0 auto;" align=center>	
	<form id="registerForm" action="modifyPage" method="post">
		<input type="hidden" name="userNum" value="${userInfo.userNum}"/>		
		<table style="border:solid 1px rgba(144, 144, 144, 0.25);">	
			<tr>
				<td style="width:15%;" align="center"><h5>제목</h5></td>
				<td style="width:20%">
				 <select name="region" style="width:100%">
	                  <option>중구</option>
	                  <option>동래구</option>
	                  <option>영도구</option>
	                  <option>동구</option>
	                  <option>진구</option>
	                  <option>서구</option>
	                  <option>남구</option>
	                  <option>해운대구</option>
	                  <option>사상구</option>
	                  <option>금정구</option>
	                  <option>사하구</option>
	                  <option>연제구</option>
	                  <option>강서구</option>
	                  <option>북구</option>
	                  <option>기장군</option>
	               </select>
	            </td>
	            <td>
				<input type="text" name="title" style="width:100%;" value="${aboard.title}" required/></td>
			</tr>
			<tr>
				<td align="center"><h5>작성자</h5></td>
				<td style="width:20%" align="center"><input type="text" name="writer" style="background-color:white; width:100%;"value="${userInfo.name}" readonly/></td>
				<td style="text-align:right;">
				<input type="checkbox" id="demo-copy" name="userHidden" value="y" >
	            <label for="demo-copy">익명체크</label>
				</td>
			</tr>
			<tr>
				<td style="width:15%;" align="center"><h5>내용</h5></td>
				<td colspan=2>
					<textarea cols=10 rows="10" name="content" style="width:100%; resize:none;">${aboard.content}</textarea>
				</td>
			</tr>
			<tr>
				<td align="center"><h5>파일 업로드</h5></td>
				<td colspan=2>
				<input type="file" class="fileUpload" />
				</td>
			</tr>
			<tr>
				<td colspan=3 style="text-align:center;">
					<input type="button" id="modifyBtn" value="등록"/>
					<input type="button" id="cancelBtn" value="취소"/>
				</td>
			</tr>
		</table>
	</form>
</div>
</section>
</article>
<jsp:include page="../footer.jsp"></jsp:include>
</div>
	<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>
   <script src="${pageContext.request.contextPath}/resources/assets/js/jquery.scrollex.min.js"></script>
   <script src="${pageContext.request.contextPath}/resources/assets/js/jquery.scrolly.min.js"></script>
   <script src="${pageContext.request.contextPath}/resources/assets/js/browser.min.js"></script>
   <script src="${pageContext.request.contextPath}/resources/assets/js/breakpoints.min.js"></script>
   <script src="${pageContext.request.contextPath}/resources/assets/js/util.js"></script>
   <script src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>  
   <script src="http://code.jquery.com/jquery-latest.min.js"></script>	
	<script>
		$("#cancelBtn").click(function(){
			window.history.back();
		});
	
		
		var accidentNum = ${aboard.accidentNum};
		
		var contextPath = '${pageContext.request.contextPath}';
		
		$.getJSON("accidentNum/"+accidentNum,function(data){
			// 첨부파일 목록 - data
			console.log(data);
			$(data).each(function(){
				var fileInfo = getFileInfo(this);
				console.log(fileInfo);
				var html = "<li data-src='"+fileInfo.fullName+"' >";
					html += "<span>";
					html += "<img src='"+fileInfo.imgSrc+"' alt='attachment' />";	
					html += "</span>";
					html += "<div>";
					html += "<a href='"+fileInfo.getLink+"' target='_blank'>";
					html += fileInfo.fileName;
					html += "</a>";
					html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";	
					html += "<a href='"+fileInfo.fullName+"' class='delBtn'>[삭제]</a>";
					html += "</div>";
					html += "</li>";
				$(".uploadList").append(html);
			});
		});
		
		// 현재 위치 경로 
		console.log("contextPath : " + contextPath);
		$(".fileUpload").on("change",function(event) {
			// upload
			var files = this.files;
			console.log(files);

	       // upload
	       var maxSize = 10485760;
	       
	       var formData = new FormData();
	       
	       for(var i=0; i<files.length; i++){
	          if(files[i].size > maxSize){
	             alert("업로드 할 수 없는 파일이 포함되어 있습니다. size : " + files[i].size);
	             return;
	          }
	          formData.append("file",files[i]);
	       }
	       
	       $.ajax({
	          type : "POST",
	          data : formData,
	          dataType : "json",
	          url : contextPath+"/uploadFile",
	          processData : false,
	          contentType : false,
	          success : function(data){
	             console.log(data);
	             console.log(data.length);
	             for(var i=0; i<data.length; i++){
	                
	                var fileInfo = getFileInfo(data[i]);
	                var html = "<li>";
					// alt => 이미지 없을때 문구
					html += "<img src='"+fileInfo.imgSrc+"' alt='attachment' />";
					html += "<div>";
					html += "<a href='"+fileInfo.getLink+"'>";
					html += fileInfo.fileName;
					html += "</a>";
					html += "</div>";
					html += "<div>";
					html += "<a href='"+fileInfo.fullName+"' class='delBtn'>X</a>";
					html += "</div>";
					html += "</li>";
					$(".uploadList").append(html);
				}
	          },
	          error : function(res){
	             alert(res.responseText);
	          }
	       });
	    });
	    
	    $(".uploadList").on("click","delBtn",function(event){
	       event.preventDefault();
	       var target = $(this);
	       
	       $.ajax({
	          type : "post",
	          url :contextPath+"/deleteFile",
	          data : {
	             fileName : target.attr("href")
	          },
	          success : function(data){
	             console.log(data);
	             target.closest("li").remove();
	          }
	       });
	    });
		
		$("#modifyBtn").click(function(){
			var str  = "";
			
			var fileList = $(".uploadList .delBtn");
			
			$(fileList).each(function(index){
				str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href")+"' />";
			});
			$("#modifyForm").append(str);
			
			$.post(contextPath+"/deleteAllfiles",{files : arr},function(data){
				alert(data);
			})
			
			$("#modifyForm").submit();
		});
	</script>
</body>
</html>
