<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<h2>Q & A</h2>
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
				<td style="width:80%"><input type="text" name="title" style="width:100%;" value="${board.title}" required/></td>
			</tr>
			<tr>
				<td align="center"><h5>작성자</h5></td>
				<td style="width:80%" align="center"><input type="text" name="writer" style="background-color:white; width:100%;"value="${userInfo.name}" readonly/></td>
			</tr>
			<tr>
				<td style="width:15%;" align="center"><h5>내용</h5></td>
				<td>
					<textarea cols=10 rows="10" name="content" style="width:100%; resize:none;">${board.content}</textarea>
				</td>
			</tr>
			<tr>
				<td colspan=2 style="text-align:center;">
					<input type="submit" id="modifyBtn" value="등록"/>
					<input type="button" id="cancelBtn" value="취소"/>
				</td>
			</tr>
		</table>
		<div>
			<input type="hidden" name="re_qnaNum" value="${board.re_qnaNum}"/>
			<input type="hidden" name="page" value="${cri.page}"/>
			<input type="hidden" name="perPageNum" value="${cri.perPageNum}"/>
			<input type="hidden" name="searchType" value="${cri.searchType}"/>
			<input type="hidden" name="keyword" value="${cri.keyword}"/>
		</div>
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





