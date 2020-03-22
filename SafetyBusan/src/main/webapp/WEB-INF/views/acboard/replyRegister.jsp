<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/main.css" />
<noscript><link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/noscript.css" /></noscript>
</head>
<body  class="is-preload">
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
<div class= "inner"  align="center">   
<div class="inner" style="height:100px;" align="center">
   <h3>REPLY REGISTER BOARD</h3>
</div>
</div>
<div class="table-wrapper" style="  height:1000px; margin:0 15em 0 0em;" align="center">
   <form id="registerForm" action="replyRegister" method="post">
      <table style="width:60%;margin:0 0 0 10em;">   
         <tr>
            <td>제목</td>
            <td><input type="text" name="title" required/></td>
         </tr>
         <tr>
            <td>작성자</td>
            <td><input type="text" name="writer" value="${userInfo.name}" readonly/></td>
         </tr>
         <tr>
            <td>내용</td>
            <td>
               <textarea cols=10 rows="10" name="content"></textarea>
            </td>
         </tr>
         <tr>
            <td colspan=2>
               <input type="submit" value="등록"/>
            </td>
         </tr>
      </table>
   
      <div>
         <input type="hidden" name="userNum" value="${userInfo.userNum}"/>
         <input type="hidden" name="origin" value="${board.origin}"/>
         <input type="hidden" name="depth" value="${board.depth}"/>
         <input type="hidden" name="seq" value="${board.seq}"/>
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
   <script src="assets/js/jquery.min.js"></script>
   <script src="assets/js/jquery.scrollex.min.js"></script>
   <script src="assets/js/jquery.scrolly.min.js"></script>
   <script src="assets/js/browser.min.js"></script>
   <script src="assets/js/breakpoints.min.js"></script>
   <script src="assets/js/util.js"></script>
   <script src="assets/js/main.js"></script>   
   <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</body>
</html>




