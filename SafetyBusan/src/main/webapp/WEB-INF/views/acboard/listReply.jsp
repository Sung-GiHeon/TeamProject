<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listReply</title>
<style>
   .fileDrop{
      width:50%;
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
   <div>
   <h2>Accident Board</h2>
   <p>Solve your questions here & We will answer sincerely.</p>
   <h1><a href="${pageContext.request.contextPath}">HOME</a></h1>
   </div>
</header>         
<section class="wrapper style5">
<div class="inner" style="height:100%;">
<section>

<div class="table-wrapper" style="height:800px; ">
      <div class="inner" style="height: 100px; " align="center">
      <h2>사건사고 게시판</h2>
      <h5>Total-Count ${pageMaker.totalCount}</h5>
   </div>
<div class="inner" style="height:100px; margin-top:30px;">   
   <div class="col-2-small">
      <table >
      <tr>
         <td>
         <select name="searchType" id="demo-category" class="search" style="width:150px; ">
            <option value="n">조&nbsp;건</option>
            <option value="t">제&nbsp;목</option>
            <option value="c">내&nbsp;용</option>
            <option value="w">작&nbsp;성&nbsp;자</option>
         </select>
         </td>
         <td>
         	<input type="text" name="keyword" id="keyword" style="width:500px;"/>
         </td>
         <td>
         <input type="button" id="searchBtn" class="primary"value="검색"/>
         </td>
         <c:if test="${!empty userInfo}">   
         <td><input type="button" id="newBtn" class="primary"
            value="글작성" /></td>
         </c:if>
      </tr>
   </table>
   </div>
</div>   
   <table class="table table-bordered" style="text-align:center;">
   <thead style=" background-color:#2e3842; text-align:center;" >
      <tr>
         <th style="color:white;text-align:center; padding:0.5em 0 0 0 ;">번호</th>      
         <th style="color:white; text-align:center;padding:0.5em 0 0 0 ;">제목</th>
            <th style="color:white;text-align:center;">작성자</th>
         <th style="color:white;text-align:center;">업로드날짜</th>
         <th style="color:white;text-align:center;">조회수</th>
      </tr>
   </thead>   
      <!-- 게시글 목록 ${list} -->
      <c:choose>
         <c:when test="${!empty list}">
            <!-- 목록 출력 -->
            <c:forEach var="board" items="${list}">
               <c:choose>
                  <c:when test="${!empty list }">
                     <tr>
                        <td>${board.accidentNum}</td>
                        <td>
                           <a style="text-decoration:none;" href="readPage${pageMaker.search(pageMaker.cri.page)}&accidentNum=${board.accidentNum}">
                              <c:out value="${board.title}" escapeXml="true"/>
                              <c:if test="${board.commentCnt > 0}">
                              [${board.commentCnt}]
                              </c:if>
                              <c:if test="${board.uploadCheck eq 'y'}">
                                 <img src="${pageContext.request.contextPath}/resources/img/file.png" style="width:20px;height:20px;" >
                              </c:if>
                           </a>
                        </td>
                        <td>
                       		<c:choose>
	                        	<c:when test="${board.userHidden eq 'y'}">
	                        		익명 게시글
	                        	</c:when>
	                        	<c:otherwise>
	                        		${board.writer}
	                        	</c:otherwise>
                        	</c:choose>
                        </td>
                        <td>
                           <f:formatDate value="${board.updatedate}" pattern="yyyy-MM-dd hh:mm"/>
                        </td>
                        <td><span class="badge bg-red" >${board.viewCnt}</span></td>
                     </tr>
                  </c:when>
               </c:choose>            
            </c:forEach>
         </c:when>
         <c:otherwise>
            <tr>
               <td colspan=5>등록된 게시물이 없습니다.</td>
            </tr>
         </c:otherwise>
      </c:choose>
   </table>
   </div>
</section>
   <!-- 페이징 블럭 -->
<div class="inner" style="height:100px;" align="center">
   <c:if test="${pageMaker.prev}">
      <a href="listReply${pageMaker.search(pageMaker.startPage-1)}" class="button small">&laquo;</a>
   </c:if>
   <c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}" >
      <a href="listReply${pageMaker.search(i)}" class="button small">${i}</a>
   </c:forEach>
   <c:if test="${pageMaker.next}">
      <a href="listReply${pageMaker.search(pageMaker.endPage+1)}" class="button small">&raquo;</a>
   </c:if>
</div>
<!-- 글작성 -->
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
      $("#searchBtn").click(function(){
         var searchValue = $("select option:selected").val();
         var keywordValue = $("#keyword").val();
         console.log("searchValue : " + searchValue + " | " + "keywordValue : " + keywordValue);
         location.href="listReply?searchType="+searchValue+"&keyword="+keywordValue;
      });
      
      $("#newBtn").click(function(){
         location.href="register";
      });
    
   
   </script>
   <script src="http://code.jquery.com/jquery-latest.min.js"></script>
   <script> var contextPath = '${pageContext.request.contextPath}'; </script>
   <script src="${pageContext.request.contextPath}/resources/js/upload.js"></script>

</body>
</html>




