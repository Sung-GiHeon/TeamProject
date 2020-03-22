<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/main.css" />
<noscript><link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/noscript.css" /></noscript>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
.uploadList {
	width: 100%;
}

.uploadList li {
	float: left;
	padding: 20px;
	list-style: none;
}
table td:first-child{
	width: 70px;
	text-align:left;

}
table td:nth-child(n+2){
	width: 100px;

}
</style>
</head>


<body class="is-preload">

<div id="page-wrapper">
<!--  -->
<jsp:include page="../Sub_header.jsp"/>
<article id="main" style="max-height:1750px;">	

<!-- Home 버튼  -->
<header>
	<h2>Support ReadPage</h2>
	<p>Let's prevent crime together</p>
	<h1><a href="${pageContext.request.contextPath}">HOME</a></h1>
</header>

<section class="wrapper style5" style="padding-bottom:0px;">		
	<!-- request : ${board} -->
<div class= "inner"  align="center">
<div class="inner" style="height:100px;" align="center">
	<h3>READ PAGE</h3>
</div>
<div  style="width:70%;height:600px;" align="center">
	<table style="width:100%;height:100%;border:solid 1px rgba(144, 144, 144, 0.25);">
		<tr style="border-bottom:1px solid rgba(0, 0, 0, 0.15);border-top:1px solid rgba(0, 0, 0, 0.15);width:70%;background-color:rgba(0, 0, 0, 0.0375);">
			<td style="width:80%;">
			<c:out value="[${board.region}]" escapeXml="true"/> <c:out value="${board.title}" escapeXml="true"/>
			</td>
			<td style="font-size:13px;text-align:right;">
	         <c:out value="${board.writer}" escapeXml="true"/> |
	         <f:formatDate value="${board.regdate}" pattern="yyyy.MM.dd" />
	     	</td>
		</tr>
		<tr>
	        <td colspan=2 style="border-bottom:1px solid rgba(0, 0, 0, 0.15);padding:0px;width:100%;height:100%;">
				<textarea style="width:100%;height:100%; background-color:white;resize:none;" disabled>${board.content}</textarea>
			</td>
	   </tr>
	 </table>
</div>
<div class="table-wrapper" style="width:70%;max-height:350px;" align="center">
	<table style="height:50px;">
		<tr style="height:60px;">
			<td >마감일</td>
			<td style="padding-right:50px;height:50px;">
			<h1 style="display:inline-block;color:black;" class="content"></h1>
				<table style="margin:0px;display:inline-block;width:100px;height:50px;float:right;">
					<tr >
						<c:if test="${userInfo.userNum eq board.userNum}">
							<td style="width:100px;margin:0;padding:0;"><input style="padding:0 22px;" type="button" id="timerout" value="모집마감" /></td>
							<td style="width:0;height:0;margin:0;padding:0;"><input type="hidden"  id="enddate" name="enddate" value="2001-01-01"/></td>
							<td style="width:0;height:0;margin:0;padding:0;"><input type="hidden" id="sup_num" name="supportNum" value="${board.supportNum}"/>
						</c:if>
					</tr>
				</table>
					<script>
					//D-day 로직
					function counter() {
						var dday = new Date("${board.enddate}").getTime(); // 디데이
						var nowtest = new Date().getTime();
						var now = new Date(); // 현재 날짜 가져오기
						var distance = dday - now;
						// Math.floor 계산하고 소수점을 전부 버린다.
						var d = Math.floor(distance
								/ (1000 * 60 * 60 * 24));
						var h = Math
								.floor((distance % (1000 * 60 * 60 * 24))
										/ (1000 * 60 * 60));
						var m = Math
								.floor((distance % (1000 * 60 * 60))
										/ (1000 * 60));
						var s = Math
								.floor((distance % (1000 * 60)) / 1000);
						if (s < 10) {
							s = '0' + s;
						}
						if (h == 0 && m == 00 && s == 00) {
							d = d - 1;
						}
						if(d<=0 && h<=0 && m<=0 ){
						$('.content').html('마감');
						clearInterval(timer);
						}else{
						$('.content').html('D - ' + (d + 1));
						}
					}
					counter();
					</script>
					</td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<ul style="max-width:600px;background-color:rgba(0, 0, 0, 0.0375);" class="uploadedList">
								
						</ul>
					</td>
				</tr>
	</table>
</div>	
<div  style="height:100px;line-height:100px;">
	<!-- 해당 작성자일시 수정,삭제 가능 예외 -->
	<c:if test="${!empty userInfo}">
		<c:if test="${userInfo.userNum eq board.userNum}">
			<input type="button" id="modifyBtn" value="수정"/>
			<input type="button" id="deleteBtn" value="삭제"/>
		</c:if>
	</c:if>
		<input type="button" id="listBtn" value="목록"/>
	</div>	
</div>

<div class="inner" style="height:100px;" align="center">
	<!-- 페이지 이동시 페이지 해당 값 전달 -->
	<form id="readForm" style="margin:0px;">
		<input type="hidden" name="supportNum" value="${board.supportNum}"/>
		<input type="hidden" name="page" value="${cri.page}"/>
		<input type="hidden" name="perPageNum" value="${cri.perPageNum}"/>
		<input type="hidden" name="searchType" value="${cri.searchType}"/>
		<input type="hidden" name="keyword" value="${cri.keyword}"/>
	</form>
	
<!-- jquery 라이브러리 script -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>var contextPath = '${pageContext.request.contextPath}';</script>
<!-- 첨부파일 존재시 호출하는 함수 script -->
<script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
</div>
</section>
</article>	


<div class="inner" align="left" style="background-color:white;color:black;">
<%@ include file="../comment/sup_comment.jsp" %>
<jsp:include page="../footer.jsp"></jsp:include>
</div>
</div>	

<!-- side menubar script -->
<script	src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/assets/js/jquery.scrollex.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/assets/js/jquery.scrolly.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/assets/js/browser.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/assets/js/breakpoints.min.js"></script>
<script	src="${pageContext.request.contextPath}/resources/assets/js/util.js"></script>
<script	src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>

<script>
		var obj = $("#readForm");
		// 목록 페이지 이동
		$("#listBtn").click(function(){
			obj.attr("action","board_list");
			obj.submit();
		});
		
		// 수정페이지 이동
		$("#modifyBtn").click(function(){
			obj.attr("action","board_modify");
			obj.submit();
		});
		
		// 게시글 삭제 (첨부파일 포함)
		$("#deleteBtn").click(function(){
			
			var isDelete = confirm("첨부된 파일이 모두 삭제 됩니다. 삭제하시겠습니까?");
			if(isDelete){
				
				var arr = [];
				$(".uploadedList li").each(function(index){
					arr.push($(this).attr("data-src"));
				});
				
				if(arr.length > 0){
					$.post(contextPath+"/deleteAllFiles", {files : arr} , function(result){
						alert(result);
					});
				}
				
				obj.attr("action","board_remove");
				obj.attr("method","post");
				obj.submit();	
			}else{
				alert("삭제 요청이 취소되었습니다.");
			}
		});
		
		// 사용자 임의 마감버튼
		$("#timerout").click(function(){
			var supportNum = $('#sup_num').val();
			var enddate = $('#enddate').val();
			
			$.ajax({
				type : "post",
				url : contextPath+"/Support/out",
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				data : JSON.stringify({
					supportNum : supportNum,
					enddate : enddate
				}),
				dataType : "text",
				success : function(data){
					location.reload();
					alert(data);
				},
				error : function(res){
					alert(res.responseText);
				}
				
			});
		});
		
		var supportNum = ${board.supportNum};
		
		// 첨부파일 존재시 미리보기 구현
		$.getJSON("getAttach/" + supportNum,function(data){
			// 첨부파일 목록 - data
			console.log(data);
			$(data).each(function(){
				var fileInfo = getFileInfo(this);
				var html = "<li style='display:inline-block;height:130px; margin:0;' data-src='"+fileInfo.fullName+"' >";
					html += "<span>";
					html += "<img style='width:100px;' src='"+fileInfo.imgSrc+"' alt='attachment' />";
					html += "</span>";
					html += "<div style='display:inline-block;height:50px;'>";
					html += "<a style='border:0px;' href='"+fileInfo.getLink+"' target='_blank'>";
					html += fileInfo.fileName;
					html += "</a>";
					html += "</div>";
					html += "</li>";
				var $div = "<div style='height:110px; background-color:white;'></div>";
				$(".uploadedList").append(html);
			});
			
		});
	
</script>
</body>
</html>

