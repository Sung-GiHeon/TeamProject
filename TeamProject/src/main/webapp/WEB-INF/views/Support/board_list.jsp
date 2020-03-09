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
<jsp:include page="../header2.jsp"/>
<article id="main" style="max-height:1500px;">	
<header>
	<div style="margin:0 0 0 0;">
	<h2>Support Board</h2>
	<p>Let's prevent crime together</p>
	<h1><a href="${pageContext.request.contextPath}">HOME</a></h1>
	</div>
</header>
<section class="wrapper style5">
<div class="inner" style="height:100px;">   
   <div class="col-3-small" style="text-align:center;">
   <h2>방범 활동 모집</h2>
	<h5>Total-Count ${pageMaker.totalCount}</h5>
   </div>
</div>
<div class="inner" style="height:100%;">
<section>
<div class="inner" style="height:100px;" align="center">
	<table style="line-height:100px;height:100px;">
      <tr style="background-color:white;border:0px;">
         <td>
         <select name="searchType" id="demo-category" class="search" style="width:100%;text-align:center;margin:0 auto; padding:0 2em 0 0; ">
            <option value="n" ${cri.searchType == null ? 'selected' : ''}>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;검색어 선택</option>
			<option value="r" ${cri.searchType == 'r' ? 'selected' : ''}>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;지역</option>
			<option value="t" ${cri.searchType == 't' ? 'selected' : ''}>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목</option>
			<option value="c" ${cri.searchType == 'c' ? 'selected' : ''}>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;내용</option>
			<option value="w" ${cri.searchType == 'w' ? 'selected' : ''}>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성자</option>
			<option value="tr" ${cri.searchType == 'tr' ? 'selected' : ''}>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;지역 & 제목 </option>
			<option value="tc" ${cri.searchType == 'tc' ? 'selected' : ''}>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목 & 내용</option>
			<option value="cw" ${cri.searchType == 'cw' ? 'selected' : ''}>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;내용 & 작성자</option>
			<option value="tcw" ${cri.searchType == 'tcw' ? 'selected' : ''}>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목 & 내용 & 작성자</option>
         </select>
         </td>
         <td>
         <input type="text" name="keyword" id="keyword" style="width:500px;"/>
         </td>
         <td>
         <input type="button" id="searchBtn" class="primary"value="검색"/>
         </td>
         <c:if test="${!empty userInfo}">
        	 <td>
		         <input type="button" id="newBtn" class="primary" value="글작성"/> 
	         </td>
         </c:if>
      </tr>
   </table>
</div>
<br/>
<div class="table" style="max-height:1500px;">
	<table class="alt" >
		<thead>
			<tr style="background-color:#4E4852;" >
				<th style="color:white;text-align:center;padding-top:10px; width:8%;">번호</th>		
				<th style="color:white;text-align:center;padding-top:10px;">제목</th>
				<th style="color:white;text-align:center;padding-top:10px;">마감일</th>
				<th style="color:white;text-align:center;padding-top:10px;">작성자</th>
				<th style="color:white;text-align:center;padding-top:10px;">작성일</th>
				<th style="color:white;text-align:center;padding-top:10px;">활동정보</th>
				<th style="color:white;text-align:center;padding-top:10px; width:8%;">조회수</th>
			</tr>
		</thead>
		<tbody align="center">	
		<!-- 게시글 목록 ${list} -->
		<c:choose>
			<c:when test="${!empty list}">
				<!-- 목록 출력 -->
				<c:forEach var="board" items="${list}">
					<tr>
						<td>${board.supportNum}</td>
						<td>
						<!-- 제목,댓글 개수,이미지첨부 확인 -->
							<a style="border-bottom:0px;" href="board_readPage${pageMaker.search(cri.page)}&supportNum=${board.supportNum}
							&commentCnt=${board.commentCnt}" >[${board.region}]${board.title}[${board.commentCnt}]
							<c:choose>
							<c:when test="${board.uploadCheck eq 'y'}">
							<img src="${pageContext.request.contextPath}/resources/img/file.png" style="width:20px;height:20px;" >
							</c:when>
							</c:choose></a>
						</td>
						<td><h1 style="color:black;" class="content${board.supportNum}"></h1>
						<script>
						// 마감일 표시 로직
						function counter() {
							var dday = new Date("${board.enddate}").getTime(); // 디데이
							var nowtest = new Date().getTime();
								var now = new Date(); // 현재 날짜 가져오기
								var distance = dday - now;
								var d = Math.floor(distance / (1000 * 60 * 60 * 24));
								var h = Math.floor((distance % (1000 * 60 * 60 * 24))
										/ (1000 * 60 * 60));
								var m = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
								var s = Math.floor((distance % (1000 * 60)) / 1000);
								var D_day = d+1;
								if (s < 10) {
									s = '0' + s;
								}
								if (h == 0 && m == 00 && s == 00) {
									D_day = D_day - 1;
								}
								if(D_day<=0){
								$('.content' + "${board.supportNum}").html('마감');
								}else{
								$('.content' + "${board.supportNum}").html('D - ' + D_day);
								}
						}
						counter();
						</script>
						</td>
						<td>${board.writer}</td>
						<td>
							<f:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" />
						</td>
						<c:choose>
							<c:when test="${board.recm eq 'y'}">
								<td>
									모집중
								</td>
							</c:when>
							<c:otherwise>
								<td>
									마감
								</td>
							</c:otherwise>
						</c:choose>
						<td><span class="badge bg-red">${board.viewCnt}</span></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan=7>등록된 게시물이 없습니다.</td>
				</tr>
			</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	
	</div>
	</section>
		<!-- 페이징 블럭 -->
		<div class="inner" style="height:100px;" align="center">
			<c:if test="${pageMaker.prev}">
				<a href= "board_list${pageMaker.search(pageMaker.startPage-1)}" class="button small">&laquo;</a>
			</c:if>
			<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<a href="board_list${pageMaker.search(i)}" class="button small">${i}</a>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<a href="board_list${pageMaker.search(pageMaker.endPage+1)}" class="button small">&raquo;</a>
			</c:if>
		</div>
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
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	var contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>
<script>
		$("#searchBtn").click(function(){
			var searchValue = $("select option:selected").val();
			var keywordValue = $("#keyword").val();
			location.href="board_list?searchType="+searchValue+"&keyword="+keywordValue;
		});
		
		$("#newBtn").click(function(){
			location.href="board_register";
		});
		
</script>
</body>
</html>





