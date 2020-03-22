<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/main.css" />
	<noscript><link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/noscript.css" /></noscript>
</head>
<body class="is-preload">
<div id="page-wrapper">
<jsp:include page="../Sub_header.jsp"/>
<article id="main">
<header>
	<div>
	<h2>Notice</h2>
	<p>welcome to my hompage</p>
	<h1><a href="${pageContext.request.contextPath}">HOME</a></h1>
	</div>
</header>
<section class="wrapper style5">	
	<div class="inner" style="height:100px;" align="center">
	<h3>게시글 등록</h3>
	</div>
	<form method="post">
		<div class="table-wrapper" style="max-height:1500px; width:50%; margin:0 auto;" align=center>	
		<input type="hidden" name="userNum" value="${userInfo.userNum}"/>
		<table style="border:solid 1px rgba(144, 144, 144, 0.25);">	
			<tr>
				<td style="width:15%;" align="center"><h5>제목</h5></td>
				<td style="width:80%"><input type="text" name="title" style="width:100%;"  value="${NoticeVO.title}" required/></td>
			</tr>
			<tr>
				<td style="width:15%;" align="center"><h5>내용</h5></td>
				<td>
					<textarea cols=10 rows="10" name="content" style="width:100%; resize:none;">${NoticeVO.content}</textarea>
				</td>
			</tr>
			<tr>
				<td colspan=2 style="text-align:center;">
					<input type="submit" value="등록" class="btn btn-warning"/>
					<input type="button" id="cancelBtn" value="취소"/>
				</td>
			</tr>
		</table>
</div>
</form>
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
</body>
</html>
