<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방범 게시판</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
 <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
 <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
 <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
 <link href="${pageContext.request.contextPath}/resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
 <link href="${pageContext.request.contextPath}/resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	
<style>
	.col-2-small{
		width:100%;
	}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/main.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
</head>
<body class="is-preload">
<div id="page-wrapper">
<jsp:include page="../Sub_header.jsp"/>
<article id="main">	
<header>
	<div style="margin:0;">
	<h2>Guard Modify</h2>
	<p>Check out the crime prevention activity news</p>
	<h1><a href="${pageContext.request.contextPath}">HOME</a></h1>
	</div>
</header>
<section class="wrapper style5">
<div class="inner" style="height:100%;" align="center">
	<!-- register 영역 -->	
	<h3 >MODIFY BOARD</h3>
	</div>
	<div class="table-wrapper" id="table_height" align="center" style="width:50%;max-height:2000px;margin:0 auto;">
	<form id="registerForm" action="Guard_modify" method="post">
		<input type="hidden" name="guardNum" value="${board.guardNum}" />
		<input type="hidden" name="userNumcopy" value="${userInfo.userNum}" />
		<input type="hidden" name="writer" value="${userInfo.name}" />
		<f:formatDate var="startfmt"  value="${board.regdate}" pattern="yyyy-MM-dd HH:mm:ss" /> 
		<input type="hidden" name="startdate" value="${startfmt}" />
		
		<%-- <input type="hidden" name="uno" value="${userInfo.uno}"/> --%>
		<table>	
			<tr>
				<td>지역</td>
				<td>
					<!-- 지역 select  -->
					<select id="selectOn" class="form-control" name="region">
						<option id="region1" value="중구">중구</option>
						<option id="region2" value="서구">서구</option>
						<option id="region3" value="동구">동구</option>
						<option id="region4" value="영도구">영도구</option>
						<option id="region5" value="부산진구">부산진구</option>
						<option id="region6" value="동래구">동래구</option>
						<option id="region7" value="남구">남구</option>
						<option id="region8" value="북구">북구</option>
						<option id="region9" value="해운대구">해운대구</option>
						<option id="region10" value="사하구">사하구</option>
						<option id="region11" value="금정구">금정구</option>
						<option id="region12" value="강서구">강서구</option>
						<option id="region13" value="연제구">연제구</option>
						<option id="region14" value="수영구">수영구</option>
						<option id="region15" value="사상구">사상구</option>
						<option id="region16" value="기장구">기장군</option>
					</select> 
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input style="width:100%;" type="text" name="title" placeholder="제목" value="${board.title}" required /></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input style="width:100%;" type="text" name="writer"  placeholder="작성자" value="${userInfo.name}" disabled/></td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea style="resize: none;width:100%;" cols=10 rows="10" name="content" placeholder="내용">${board.content}</textarea>
				</td>
			</tr>
			
			<tr>
				<td>FILE Upload</td>
				<td><input style="color:black;" type="file" class="fileUpload" /></td>
			</tr>
			<tr>
				<td>업로드 된 파일</td>
				<td>
					<ul class="uploadList" style="max-width:600px;background-color:rgba(0, 0, 0, 0.0375);">
								
					</ul>
				</td>
			</tr>
			
			<tr align="center" style="height:150px;">
				<td colspan=2 style="line-height:150px;">
					<input type="button" id="saveBtn" value="등록"/>
					<input type="button" id="cancleBtn" onclick="history.go(-1);" value="취소">
				</td>
			</tr>
		</table>
	</form>
	</div>
	</section>
</article>	
	
<jsp:include page="../footer.jsp"></jsp:include>
		
</div>
<script	src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/assets/js/jquery.scrollex.min.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/assets/js/jquery.scrolly.min.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/assets/js/browser.min.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/assets/js/breakpoints.min.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/assets/js/util.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>
<script>
	var contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
<script>
	var guardNum = ${board.guardNum};
	
	$(function iu(){
		var option = $("option");
		
		for(var i = 1 ; i<=option.length; i++){
			if($("#selectOn > option[id=region"+i+"]").attr("value")=="${board.region}"){
				$("#selectOn > option[id=region"+i+"]").attr("selected","true");
			}
		};
	});
	
	
	$.getJSON("getAttach/"+guardNum,function(data){
		// 첨부파일 목록 - data
		var height = $("#table_height").height();
		for(var i= 0; i<data.length;i++){
			var fileInfo = getFileInfo(data[i]);
			var html = "<li style='display:inline-block;' data-src='"+fileInfo.fullName+"' >";
				html += "<img src='"+fileInfo.imgSrc+"' alt='attachment' /><br/>";	
				html += "<div style='display:inline-block;width:100px;height:30px;margin:0;padding:0;'>";
				html += "<a href='"+fileInfo.getLink+"' target='_blank'>";
				html += fileInfo.fileName;
				html += "</a>";
				html += "</div>";
				html += "<br/>";	
				html += "<div style='display:inline-block;height:23px;margin:0;padding:0;'>";
				html += "<a style='color:black;' href='"+fileInfo.fullName+"' class='delBtn'>[삭제]</a>";
				html += "</div>";
				html += "</li>";
				var $div ="<div style='height:150px; background-color:white;' > </div>";
				$(".uploadList").append(html);
				if(i/2==0 ){
					height+=150;
				}
				$("#table_height").css("height",height);
		}
	});
	
	
	$(".fileUpload").on("change",function(event) {
		// upload
		var files = this.files;
		console.log(files);

		var maxSize = 10485760;

		var formData = new FormData();
		
		for (var i = 0; i < files.length; i++) {
			if (files[i].size > maxSize) {
				alert("업로드 할 수 없는 파일이 포함되어 있습니다. size : "+ files[i].size);
				return;
			}
			formData.append("file", files[i]);
			
		}

	$.ajax({
			type : "POST",
			data : formData,
			dataType : "json",
			url : contextPath + "/uploadFile",
			processData : false,
			contentType : false,
			success : function(data) {
				console.log(data);
				console.log(data.length);
				var height = $("#table_height").height();
				console.log(height);
				
				for (var i = 0; i < data.length; i++) {
					var fileInfo = getFileInfo(data[i]);
					var html = "<li style='display:inline-block;'>";
					// alt => 이미지 없을때 문구
					html += "<img src='"+fileInfo.imgSrc+"' alt='attachment' /><br/>";
					html += "<div style='display:inline-block;width:100px;height:50px;margin:0;padding:0;'>";
					html += "<a href='"+fileInfo.getLink+"' target='_blank' >";
					html += fileInfo.fileName;
					html += "</a>";
					html += "</div>";
					html += "<br/>";
					html += "<div style='display:inline-block;height:23px;margin:0;padding:0;'>";
					html += "<a style='color:black;' href='"+fileInfo.fullName+"' class='delBtn'>[삭제]</a>";
					html += "</div>";
					html += "</li>";
					var $div ="<div style='height:150px; background-color:white;' > </div>";
					/* $("footer").before($div); */
					$(".uploadList").append(html);
					/* 4개 되었을때 높이 늘리기 */
					if(i/3==0 ){
					height+=70;
					}
					$("#table_height").css("height",height);
				}
			},
			error : function(res) {
				alert(res.responseText);
			}
		});
	});
	
	var arr = [];
	
	$(".uploadList").on("click",".delBtn",function(event){
		event.preventDefault();
		
		var fileLink = $(this).attr("href");
		arr.push(fileLink);
		$(this).closest("li").remove();
	});
	
	$("#saveBtn").click(function(){
		var str  = "";
		// 빈칸 예외처리
		var input_num = $("#registerForm input[type=text]");
		for(var i = 0; i<input_num.length; i++){
			if(input_num[i].value==''){
				alert("빈칸을 채워주세요");
				input_num[i].focus();
				return;
			}
		}
		
		var fileList = $(".uploadList .delBtn");
		
		$(fileList).each(function(index){
			str += "<input type='hidden' name='file["+index+"]' value='"+$(this).attr("href")+"' />";
		});
		$("#registerForm").append(str);
		
		
		$.post(contextPath+"/deleteAllfiles",{file : arr },function(data){
			alert(data);
		});
		
		$("#registerForm").submit();
	});
	</script>
	
</body>
</html>





