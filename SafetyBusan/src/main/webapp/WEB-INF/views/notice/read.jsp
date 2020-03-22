<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>

	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/main.css" />
	<noscript><link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/noscript.css" /></noscript>

</head>
<body class="is-preload">
	<div id="page-wrapper">
<jsp:include page="../Sub_header.jsp"/>
<article  id="main">
<header>
	<div>
	<h2>Notice</h2>
	<p>welcome to my hompage</p>
	<h1><a href="${pageContext.request.contextPath}">HOME</a></h1>
	</div>
</header>

<section class="wrapper style5">
<div class= "inner"  align="center">
   <!-- request : ${board} -->
   <div class="inner" style="height:100px;" align="center">
   <h3>게시글 상세보기</h3>
</div>
</div>
<div style="width:800px;height:500px;margin:0 auto;">
<table style="height:100%;border:solid 1px rgba(144, 144, 144, 0.25);">
   <tr>
      <td style="width:80%;">
      <c:out value="${nboard.title}" escapeXml="true"/>
      </td>
      <td style="font-size:13px;text-align:right;">
        <c:out value="관리자" escapeXml="true"/> |
        <f:formatDate value="${nboard.regdate}" pattern="yyyy.MM.dd"/>
      </td>
   </tr>
   <tr>
      <td colspan=2 style="height:100%"><c:out value="${nboard.content}" escapeXml="true"/></td>
   </tr>
</table>
</div>
<form role="form">
	<div class="inner" style="height:100px;margin-top:2em;" align="center">   
		<div>
	      	<!-- 버튼 이것만 고치면됨 -->
			<c:if test="${userInfo.userNum == 1}">
			<input type="button" id="modifyBtn" value="수 정"/>
			<input type="button" id="deleteBtn" value="삭 제"/>
			</c:if>
			<input type="button" id="listBtn" value="목록으로"/>
		</div>   
	</div>   
	<input type="hidden" name="page" value="${cri.page}"/>
	<input type="hidden" name="perPageNum" value="${cri.perPageNum}"/>
	<input type="hidden" name="noticeNum" value="${nboard.noticeNum}"/>
</form>
   <script src="http://code.jquery.com/jquery-latest.min.js"></script>
   <script>var contextPath = '${pageContext.request.contextPath}';</script>
   <script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
</section>
</article>
</div>
<jsp:include page="../footer.jsp"></jsp:include>
	<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.scrollex.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.scrolly.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/browser.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/breakpoints.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/util.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>

$(function(){
	var formObj = $("form[role='form']");
	
	$("#modifyBtn").on("click",function(){
		formObj.attr("action","modify");
		formObj.attr("method","get");
		formObj.submit();
	});
	
	$("#deleteBtn").on("click",function(){
		formObj.attr("action","remove");
		formObj.attr("method","post");
		formObj.submit();
	});
	
	$("#listBtn").click(function(){
		formObj.attr("action","list");
		formObj.attr("method","get");
		formObj.submit();
	});
});
</script>
</body>
</html>










