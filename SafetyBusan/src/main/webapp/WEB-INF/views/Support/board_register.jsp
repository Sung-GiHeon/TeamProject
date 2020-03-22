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
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	
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
<script>
$(function() {
	$('input[id=date_start]').attr("readonly","true");
	$('input[id=date_end]').attr("readonly","true");
	$('#date_start').datepicker(
			{
				buttonImageOnly : true, // 버튼 이미지만 표시할지 여부
				buttonText : "날짜선택", // 버튼의 대체 텍스트
				nextText : '다음 달',
				prevText : '이전 달',
				dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일','토요일' ],
				dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
				monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월','7월', '8월', '9월', '10월', '11월', '12월' ],
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월','8월', '9월', '10월', '11월', '12월' ],
				minDate : 0 ,
				dateFormat : "yy-mm-dd", // 날짜의 형식
				changeMonth : true, // 월을 이동하기 위한 선택상자 표시여부
				//minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
				onClose : function(selectedDate) {
					// 시작일(fromDate) datepicker가 닫힐때
					// 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
					$("#date_end").datepicker("option", "minDate",
							selectedDate);
				}
			});

	//종료일
	$('#date_end').datepicker(
			{
				buttonImageOnly : true,
				buttonText : "날짜선택",
				nextText : '다음 달',
				prevText : '이전 달',
				dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일','토요일' ],
				dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
				monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월','7월', '8월', '9월', '10월', '11월', '12월' ],
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월','8월', '9월', '10월', '11월', '12월' ],
				dateFormat : "yy-mm-dd",
				changeMonth : true,
				minDate : 0 ,
				//minDate: 0, // 오늘 이전 날짜 선택 불가
				onClose : function(selectedDate) {
					// 종료일(toDate) datepicker가 닫힐때
					// 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
					$("#date_start").datepicker("option", "maxDate",
							selectedDate);
				}
			});
});
</script>
</head>



<body class="is-preload">
<div id="page-wrapper">
<jsp:include page="../Sub_header.jsp"/>
<article id="main">	
<header>
	<div style="margin:0;">
	<h2>Support Register</h2>
	<p>Let's prevent crime together</p>
	<h1><a href="${pageContext.request.contextPath}">HOME</a></h1>
	</div>
</header>
<section class="wrapper style5">
<div class="inner" style="height:100%;">
	<!-- register 영역 -->	
	<div id="regi" class="inner" style="height:40%; margin:2em 0 2em 0"align="center">
	
	<!-- 작성 목록 -->
	<h3 >REGISTER BOARD</h3>
	<form id="registerForm" action="board_register" method="post" >
		<input type="hidden" name="userNumcopy" value="${userInfo.userNum}" />
		<input type="hidden" name="writer" value="${userInfo.name}" />
		<%-- <input type="hidden" name="uno" value="${userInfo.uno}"/> --%>
		<div class="table-Wrapper" id="table_height" align="center" style="width:800px;max-height:2000px;margin:0;">
		<table>	
			<tr>
				<td>지역</td>
				<td>
				<!-- 지역 select  -->
				<select class="form-control" name="region">
					<option>중구</option>
					<option>서구</option>
					<option>동구</option>
					<option>영도구</option>
					<option>부산진구</option>
					<option>동래구</option>
					<option>남구</option>
					<option>북구</option>
					<option>해운대구</option>
					<option>사하구</option>
					<option>금정구</option>
					<option>강서구</option>
					<option>연제구</option>
					<option>수영구</option>
					<option>사상구</option>
					<option>기장군</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td ><input style="width:100%;" type="text" name="title" placeholder="제목" required /></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input style="width:100%;" type="text"   value="${userInfo.name}" placeholder="작성자"  disabled/></td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea style="width:100%; resize: none;" cols=10 rows="10" name="content" placeholder="내용"></textarea>
				</td>
			</tr>
			
			<tr>
				<td>시작일</td>
				<td>
					<c:set var="now" value="<%= new java.util.Date() %>" />
					<f:formatDate value="${now}" var="nowdate" type="date" pattern="yyyy-MM-dd" />
					<input style="width:100%;" type="text" id="date_start" name="regdate" value="${nowdate}" disabled /> 
				
				</td>
			</tr>
			<tr>
				<td>종료일</td>
				<td>
					<input style="width:100%;" type="text" id="date_end" name="enddate" required />
				</td>
			</tr>
			
			<tr>
				<td>FILE Upload</td>
				<td><input style="color:black;" type="file" class="fileUpload" /></td>
			</tr>
			<tr>
				<td>업로드 된 파일</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<ul class="uploadList" style="max-width:600px;background-color:rgba(0, 0, 0, 0.0375);">
								
					</ul>
				</td>
			</tr>
			
			<tr align="center" style="height:150px;">
				<td colspan=2 style="line-height:150px;">
					<input type="button" id="saveBtn" value="등록"/>
					<input type="button" id="cancleBtn" onclick="history.go(-1);" value="취소">
				</td>
			</tr>
			
		</table>
		
		</div>
		
	</form>
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
		
		// 파일 업로드
		$(".fileUpload").on("change",function(event) {
			// upload
			var files = this.files;
			var maxSize = 10485760;
			var formData = new FormData();

			for (var i = 0; i < files.length; i++) {
				if (files[i].size > maxSize) {
					alert("업로드 할 수 없는 파일이 포함되어 있습니다. size : "+ files[i].size);
					return;
				}
				formData.append("file", files[i]);
			}
		
		// 업로드시 미리보기 생성
		$.ajax({
				type : "POST",
				data : formData,
				dataType : "json",
				url : contextPath + "/uploadFile",
				processData : false,
				contentType : false,
				success : function(data) {
					for (var i = 0; i < data.length; i++) {
						var fileInfo = getFileInfo(data[i]);
						var html = "<li style='display:inline-block;'>";
						// alt => 이미지 없을때 문구
						html += "<img style='width:100px;height:60px;' src='"+fileInfo.imgSrc+"' alt='attachment' /><br/>";
						html += "<div style='display:inline-block;height:50px;margin:0;padding:0;'>";
						html += "<a href='"+fileInfo.getLink+"' target='_blank' >";
						html += fileInfo.fileName;
						html += "</a>";
						html += "</div>";
						html += "<br/>";
						html += "<div style='display:inline-block;height:23px;margin:0;padding:0;'>";
						html += "<a style='color:black;' href='"+fileInfo.fullName+"' class='delBtn'>[삭제]</a>";
						html += "</div>";
						html += "</li>";
						$(".uploadList").append(html);
					}
				},
				error : function(res) {
					alert(res.responseText);
				}
			});
		});

		var arr = [];
		
		// 업로드 된 파일 삭제 버튼
		$(".uploadList").on("click",".delBtn",function(event){
			event.preventDefault();
			var fileLink = $(this).attr("href");
			arr.push(fileLink);
			$(this).closest("li").remove();
		});

		// 작성 완료 버튼
		$("#saveBtn").click(function() {
				var str  = "";
				// 빈칸 예외처리
				var input_num = $("#registerForm input[type=text]");
				for(var i = 0; i<input_num.length; i++){
					if(input_num[i].value==''){
						alert("빈칸을 채워주세요");
						input_num[i].focus();
						return;
					}
				}
				var fileList = $(".uploadList .delBtn");
				
				$(fileList).each(function(index){
					str += "<input type='hidden' name='file["+index+"]' value='"+$(this).attr("href")+"' />";
				});
				$("#registerForm").append(str);
				$("#registerForm").submit();
		});
		
	</script>
</body>
</html>





