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
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	
<noscript><link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/noscript.css" /></noscript>
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
<jsp:include page="../Sub_header.jsp"/>
<article id="main" style="max-height:2000px;">	
<header>
	<h2>Guard ReadPage</h2>
	<p>Check out the crime prevention activity news</p>
	<h1><a href="${pageContext.request.contextPath}">HOME</a></h1>
</header>
<section class="wrapper style5">		
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
					<textarea style="width:100%;height:100%; background-color:white;resize:none;" disabled >${board.content}</textarea>
			</td>
		</tr>
	 </table>
</div>
<div class="table-wrapper" style="width:70%;max-height:400px;" align="center">
	<table style="height:50px;">
		<tr style="height:50px;">
			<td >작성일</td>
			<td>
				<p style="margin:0px;">
				<f:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" />
				</p>			
			</td>
		</tr>
				<tr>
					<td >첨부파일</td>
					<td ></td>
				</tr>
				<tr>
					<td ></td>
					<td >
						<ul style="max-width:600px;background-color:rgba(0, 0, 0, 0.0375);" class="uploadedList">
								
						</ul>
					</td>
				</tr>
	</table>
</div>
<div  style="height:100px;line-height:100px;">
	<c:if test="${!empty userInfo}">
		<c:if test="${userInfo.userNum eq board.userNum}">
			<input type="button" class="btn btn-warning" value="수정" />
			<input type="button" class="btn btn-danger" value="삭제" />
		</c:if>	
	</c:if>	
	<input type="button" class="btn btn-primary" value="목록" />
	<form id="readForm" style="margin:0px;">
		<input type="hidden" name="guardNum" value="${board.guardNum}" />
		<input type="hidden" name="page" value="${cri.page}" /> 
		<input type="hidden" name="perPageNum" value="${cri.perPageNum}" /> 
		<input type="hidden" name="searchType" value="${cri.searchType}" /> 
		<input type="hidden" name="keyword" value="${cri.keyword}" />
	</form>
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>var contextPath = '${pageContext.request.contextPath}';</script>
	<script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
</div>
</section>
</article>	

<div class="inner" align="left" style="background-color:white;color:black;">
<%@ include file="../comment/guard_comment.jsp" %>
<jsp:include page="../footer.jsp"></jsp:include>
</div>
</div>	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/assets/js/jquery.min.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/assets/js/jquery.scrollex.min.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/assets/js/jquery.scrolly.min.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/assets/js/browser.min.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/assets/js/breakpoints.min.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/assets/js/util.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>
	<script>
	$(function(){
		var formObj = $("#readForm");
		
		$(".btn-warning").click(function(){
			/* 수정 */
			formObj.attr("action","Guard_modify");
			formObj.attr("method","get");
			formObj.submit();
		});
		
		$(".btn-danger").click(function(){
			/* 삭제 */
			formObj.attr("action","Guard_remove").submit();
			formObj.attr("method","post");
			formObj.submit();
		});
		
		$(".btn-primary").click(function(){
			/* 리스트 */
			formObj.attr("action","Guard_list");
			formObj.attr("method","get");
			formObj.submit();
		});
		
	});

	var guardNum = ${board.guardNum};
	
	$.getJSON("getAttach/" + guardNum,function(data){
		// 첨부파일 목록 - data
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

