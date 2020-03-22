<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<article id="main">
<header>
	<div>
	<h2>Notice</h2>
	<p>welcome to my hompage</p>
	<h1><a href="${pageContext.request.contextPath}">HOME</a></h1>
	</div>
</header>
<section class="wrapper style5" >
<div class="inner" style="height:100%;">
<section>

	<div class="table-wrapper" style="min-height:500px;">
		<div class="inner" style="height: 100px;margin:0 auto;" align="center">
					<h2>공 지 사 항</h2>
					<h5>Total-Count ${pageMaker.totalCount}</h5>
				</div>
<div class="inner" style="height:100px; margin-top:30px;" align="center">
	<div class="col-2-small"align="center">
		<table>
			<tr>
				<td style="width:20%">
					<select class="form-control" id="select" style="width:100%;"> 
						<c:forEach begin="5" end="30" step="5" var="i" >
							<option  value="${i}" ${pageMaker.cri.perPageNum == i ? 'selected' : ''}>${i}개씩</option>	
						</c:forEach>
					</select>
				</td>
				<c:if test="${userInfo.userNum == 1}">
				<td style="text-align:right;">	
					<button class="primary" id="createBtn">게시물 작성</button>
				</td>
				</c:if>
			</tr>
		</table>
	</div>
</div>
		<table class="alt">
			<thead style=" background-color:#2e3842; text-align:center;" >
				<tr>
					<th style="color:white;text-align:center; padding:0.5em 0 0 0 ;">번호</th>
										<th style="color:white;text-align:center; padding:0.5em 0 0 0 ;">제목</th>
										<th style="color:white;text-align:center; padding:0.5em 0 0 0 ; width: 10%;">작성자</th>
										<th style="color:white;text-align:center; padding:0.5em 0 0 0 ;">등록일시</th>
										<th style="color:white;text-align:center; padding:0.5em 0 0 0 ; width: 10%;">조회수</th>
				</tr>
			</thead>
			<tbody align="center">	
			<c:forEach items="${list}" var="nboard">
				<tr>
					<td>${nboard.noticeNum}</td>
					<td style="text-align:left;"><a href="read${pageMaker.makeQuery(pageMaker.cri.page)}&noticeNum=${nboard.noticeNum}">${nboard.title}</a></td>
					<td>관리자</td>
					<td><f:formatDate pattern="yyyy-MM-dd HH:mm" value="${nboard.regdate}"/></td>
					<td>${nboard.viewCnt}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</section>
		<!-- paging 처리 -->
		<div class="inner"  align="center">
			<ul id="pagination" class="actions small" style="margin:0 0 0 23.5em">
				<c:if test="${pageMaker.prev}">
					<li><a href="${pageMaker.startPage - 1}" class="button small">&laquo;</a>
					<li><a href="1" class="button small">1</a>
					<li><span>...</span></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<li ${pageMaker.cri.page == idx ? ' class=active' : ''}>
						<a href="${idx}" class="button small">${idx}</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next}">
					<li><span>...</span></li>
					<li><a href="${pageMaker.maxPage}" class="button small">${pageMaker.maxPage}</a>
					<li><a href="${pageMaker.endPage + 1}" class="button small">&raquo;</a>
					
				</c:if>
			</ul>
					<form id="jobForm">
					<input type="hidden" name="page" value="${pageMaker.cri.page}"/>
					<input type="hidden" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
					</form>
		</div>
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
		var result = '${result}';
		if(result != null && result != '') alert(result);
		
		$("#pagination li a").on("click",function(event){
			event.preventDefault();
			// page
			var targetPage = $(this).attr("href");
			
			var jobForm = $("#jobForm");
			
			jobForm.find("[name='page']").val(targetPage);
			jobForm.attr("action","list").attr("method","GET");
			jobForm.submit();
		});
		
		$("#createBtn").on("click",function(){
			location.href="reg";
		})
		
		$("#select").on("change",function(){
			var jobForm = $("#jobForm");
			jobForm.find("[name='page']").val(1);
			jobForm.find("[name='perPageNum']").val($(this).val());
			jobForm.attr("action","list").attr("method","GET");
			jobForm.submit();
		});
	</script>
</body>
</html>
