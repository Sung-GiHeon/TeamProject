<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %> 
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
	#hr_position li:first-child{
		border-top:1px solid #BDBDBD;
	}
	
	#hr_position li:nth-child(1+1){
		border-bottom:1px solid #BDBDBD;
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
<article id="main">	
<header>
	<div style="margin:0 auto;">
	<h2>Guard List</h2>
	<p>Check out the crime prevention activity news</p>
	<h1><a href="${pageContext.request.contextPath}">HOME</a></h1>
	</div>
</header>
<section class="wrapper style5">
<div class="inner" style="height:100px;margin:0 auto;">   
   <div class="col-3-small" style="text-align:center;">
   <h2>활동 소식</h2>
	<h5>Total-Count ${pageMaker.totalCount}</h5>
   </div>
</div>
<div style="height:20px;"></div>
<div class="inner" style="height:100%;">
<c:if test="${!empty userInfo}">
   <input style="float:right;margin-right:50px;" type="button" id="newBtn" class="primary" value="글작성"/> 
</c:if>
<section >
<br/>
<div class="table" id="wrap_height" style="width:752px;text-align:center;margin:0 auto;">
	<div style="height:50px;"></div>
	<ul class="alt" id="hr_position" style="text-align:center;">
		<!-- 게시글 목록 ${list} -->
		<c:choose>
			<c:when test="${!empty list}">
				<!-- 목록 출력 -->
				<c:forEach var="board" items="${list}">
					<li style="width:752px;height:157px;padding:20px 0;margin:0px;">
						<p style="display:inline-block;float:left;padding:0px;margin:10px 0 0 0;">
							<a style="border:0px;margin-right:10px;" class="ssumnail" data-guardNum="${board.guardNum}" href="readPage${pageMaker.search(pageMaker.cri.page)}&guardNum=${board.guardNum}" >

							</a>
						</p>
							<div style="text-align:left;width:570px;height:114px;">
								<h2 style="font-size:15px;margin:0px;"><a style="border:0px;text-decoration:none;" href="readPage${pageMaker.search(pageMaker.cri.page)}&guardNum=${board.guardNum}">
								[${board.region}]${board.title}</a></h2>
								<span id="font_hidden" style="font-size:1em;word-break:break-word;margin:0;padding:10px 0 0 0;">
								<a style="margin:10px 0 0 0;line-height:5px;font-size:13px;border:0px;text-decoration:none; overflow: hidden;text-overflow: ellipsis;
								display: -webkit-box;-webkit-line-clamp: 3;-webkit-box-orient: vertical; word-wrap:break-word; line-height: 1.2em;height: 3.6em;"
 							    data-text="${board.content}" href="readPage${pageMaker.search(pageMaker.cri.page)}&guardNum=${board.guardNum}">${board.content}</a></span>
								<p style="width:100%;font-size:12px;margin:0;padding-top:17px;">
									<f:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" />
								</p>
							</div>
					</li>
					<script>
					
					
					</script>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan=5>등록된 게시물이 없습니다.</td>
				</tr>
			</c:otherwise>
			</c:choose>
	</ul>	
	</div>
	</section>
		<!-- 페이징 블럭 -->
		<div class="inner" style="height:100px;" align="center">
			<c:if test="${pageMaker.prev}">
				<a href="Guard_list${pageMaker.search(pageMaker.startPage-1)}" class="button small">&laquo;</a>
			</c:if>
			<c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<a href="Guard_list${pageMaker.search(i)}" class="button small">${i}</a>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<a href="Guard_list${pageMaker.search(pageMaker.endPage+1)}" class="button small">&raquo;</a>
			</c:if>
		</div>
		<div class="inner" style="height:100px;" align="center">
			<table style="width:752px;line-height:100px;">
		      <tr style="background-color:white;border:0;">
		         <td>
		         <select name="searchType" id="demo-category" class="search" style="font-size:12px;width:100%;height:44px;text-align:center;margin:0 auto; padding:0 2em 0 0; ">
		            <option value="n" ${cri.searchType == null ? 'selected' : ''}>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;전체</option>
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
		         <input type="text" name="keyword" id="keyword" style="width:400px;height:44px;"/>
		         </td>
		         <td>
		         <input type="button" id="searchBtn" class="primary"value="검색"/>
		         </td>
		      </tr>
		   </table>
		</div>
		</div>
	</section>
	
	
	
</article>	
<jsp:include page="../footer.jsp"></jsp:include>
</div>

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
	$(function(){
		$(".ssumnail").each(function(){
			
			var guardNum = $(this).attr("data-guardNum");
			var obj = $(this);
			
			$.getJSON("getAttach/" + guardNum,function(data){
					
					// 첨부파일 목록 - data
					if(data[0]!=null){
					var fileInfo = getFileInfo(data[0]);
					var default_img = "${pageContext.request.contextPath}/resources/img/file.png";
					var html =  "<div style='display:inline-block;width:150px;height:100px; data-src='"+fileInfo.fullName+"' >";
						html += "<span style='display:inline-block;'>";
						html += "<img style='width:120px;height:90px;' src='"+fileInfo.imgSrc+"' alt='이미지파일이 없습니다.' />";
						html += "</span>";
						html += "</div>";
					$(obj).append(html);
					}else{
						var html1 =  "<div style='display:inline-block;width:150px;height:100px;  >";
						html1 += "<span style='display:inline-block;'>";
						html1 += "<img style='width:120px;height:90px;' src='/resources/img/file.png'  />";
						html1 += "</span>";
						html1 += "</div>";
						$(obj).append(html1);
					}
					
					
			});
			
		});
	});
		
	$("#searchBtn").click(function(){
		var searchValue = $("select option:selected").val();
		var keywordValue = $("#keyword").val();
		location.href="Guard_list?searchType="+searchValue+"&keyword="+keywordValue;
	});
	
	$("#newBtn").click(function(){
		location.href="Guard_register";
	});
	
</script>
</body>
</html>





