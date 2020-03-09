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
<body class="is-preload">
<div id="page-wrapper">
<jsp:include page="../header2.jsp"/>
<article id="main">
<header>
   <h2>Q & A</h2>
   <p>Solve your questions here & We will answer sincerely.</p>
   <h1><a href="${pageContext.request.contextPath}">HOME</a></h1>
</header>
<section class="wrapper style5" style="height:900px;">
<div class= "inner" align="center">
   <%--  request : ${board} --%>
   <div class="inner" style="height:100px;" align="center">
   <h3>게시글 상세보기</h3>
</div>
</div>
<div style="width:800px;height:500px;margin:0 auto;">
<table style="height:100%;border:solid 1px rgba(144, 144, 144, 0.25);">
   <tr>
      <td style="width:70%;">
       <c:out value="${board.title}" escapeXml="true"/>
      </td>
      <td style="font-size:13px;text-align:right;">
         <c:out value="${board.writer}" escapeXml="true"/> |
         <fmt:formatDate value="${board.regdate}" pattern="yyyy.MM.dd" />
      </td>
   </tr>
   <tr>
      <td colspan=2 style="height:100%"><c:out value="${board.content}" escapeXml="true"/></td>
   </tr>
   
   
</table>
<div class="inner" style="width:800px; height:100px;margin-top:10px;" align="center">   
   <div>
      <c:if test="${!empty userInfo}">
         <c:if test="${userInfo.userNum eq board.userNum}">
            <input type="button" id="modifyBtn" value="수정"/>
            <input type="button" id="deleteBtn" value="삭제"/>
         </c:if>
      </c:if>
      <input type="button" id="replyBtn" value="답변"/>
      <input type="button" id="listBtn" value="목록으로"/>
   </div>

   <form id="readForm">
      <input type="hidden" name="re_qnaNum" value="${board.re_qnaNum}"/>
      <input type="hidden" name="page" value="${cri.page}"/>
      <input type="hidden" name="perPageNum" value="${cri.perPageNum}"/>
      <input type="hidden" name="searchType" value="${cri.searchType}"/>
      <input type="hidden" name="keyword" value="${cri.keyword}"/>
   </form>
   
   <script src="http://code.jquery.com/jquery-latest.min.js"></script>
   <script>var contextPath = '${pageContext.request.contextPath}';</script>
      <br/>
   <br/>
</div>   
</div>
</section>
</article>

<div class="inner" align="left" style="background-color:white;color:black;">
<jsp:include page="../footer.jsp"></jsp:include>
</div>
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
      var obj = $("#readForm");
      
      $("#listBtn").click(function(){
         obj.attr("action","listReply");
         obj.submit();
      });
      
      $("#replyBtn").click(function(){
         obj.attr("action","replyRegister");
         obj.submit();
      });
      
      $("#modifyBtn").click(function(){
         obj.attr("action","modifyPage");
         obj.submit();
      });

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
            
            obj.attr("action","remove");
            obj.attr("method","post");
            obj.submit();   
         }else{
            alert("삭제 요청이 취소되었습니다.");
         }
      });
   </script>
</body>
</html>