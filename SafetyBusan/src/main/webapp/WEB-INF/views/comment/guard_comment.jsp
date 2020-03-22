<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
   #comments li{
      list-style : none;
   }
   #modDiv{
      display:none;
   }
   #commend_size{
      width:720px;
   }
   #commend_size td:first-child{
      width:620px;
   }
   #commend_size td:nth-child(n+2){
      width:100px;
   }
 .modal {
           display: none; /* Hidden by default */
           position: fixed; /* Stay in place */
           z-index: 1; /* Sit on top */
           left: 0;
           top: 0;
           width: 100%; /* Full width */
           height: 100%; /* Full height */
           overflow: auto; /* Enable scroll if needed */
           background-color: rgb(0,0,0); /* Fallback color */
           background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
       }
   
.modal-content {
           background-color: #fefefe;
           margin: 15% auto; /* 15% from the top and centered */
           padding: 20px;
           border: 1px solid #888;
           width: 50%; /* Could be more or less, depending on screen size */                          
       }
       
#pagination>li{
   list-style: none;
   display: inline;
}

#pagination>li>a{
   color:black;
   margin: 10px;
   text-decoration:none;
}

#pagination a.active{
   font-weight:700;
   border: 1px solid blue;
   padding: 4px 8px; 
}
</style>

<br/>

<div style="width:720px;margin:0 auto;">
   <div ><p id="cnt" style="margin:0px;color:black;"></p></div>
   <br/>
   <div style="width:720px;margin:0px;background-color:#F2F2F2;">
      <c:if test="${!empty userInfo}">
      <table id="commend_size" style="border: 1px solid #F2F2F2;margin:0px;" >
         <input type="hidden" name="commentWriter" value="${userInfo.name}" />
         <tr style="border:0 0 1px 0 solid #D8D8D8;background-color:#F2F2F2;">
            <td style="background-color:#F2F2F2;">
               <textarea id="commentText" style="width:100%;height:50px;resize: none;" name="content"></textarea>
            </td>
            <td style="background-color:#F2F2F2;">
               <input style="color:black;padding:0 10px;height:50px; background-color:rgba(144, 144, 144, 0.25);  " type="button" id="commentAddBtn" value="덧글입력" />
            </td>
         </tr>
      </table>
      </c:if>
      
      <ul id="comments" style="padding:0;width:100%;margin:0 auto;">
            
      </ul>
   </div>
     <!-- 페이징처리  -->
   <div class="inner" style="height:100px;margin-top:20px;" align="center">
      <ul id="pagination" >
      
      </ul>
   </div>
</div>




<script>
   var guardNum = "${board.guardNum}";
   var userNum = "${userInfo.userNum}";
   var commentPage = 1;
   getListPage(commentPage);

   // 댓글 수정 클릭시 동적 이벤트 발생
   $("#comments").on("click",".commentLi #commentModBtn",function(){
      // this는 동적 할당 버튼을 가르킴 그 부모는 commentLi
      var commentWrap = $(this).parent();
      var re_guardNum = commentWrap.attr("data-re_guardNum");
      var writer = "${userInfo.name}";
      var text = commentWrap.attr("data-text");
      
      // text에 들어가는 태그요소 변경 -> 사용자 화면에서 \n로 바꿈
      text = text.replace(/<br\>/ig, "\n");
      text = text.replace(/<br\/>/ig, "\n");
      text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
      
      // 해당 선택자에 속한 태그를 textarea로 변경
      $(".con"+re_guardNum).contents().unwrap().wrap( "<textarea class='con"+re_guardNum+"' style='max-height:700px;resize:none;width:100%;'></textarea>" );
      $(".btnNum"+re_guardNum).text("저장");
      $(".btnNum"+re_guardNum).attr("id","save");
      $(".btnNumDel"+re_guardNum).text("취소");
      $(".btnNumDel"+re_guardNum).attr("id","cancel");
      $(".con"+re_guardNum).val(text);
         var obj = $(".con"+re_guardNum);
         $(obj).each(function(index){
            if(index != 0){
               $(this).remove();
            }
         });
      $(".con"+re_guardNum).focus();
   }); 
   
   // 수정 취소 기능
   $("#comments").on("click",".commentLi #cancel",function(){
      getListPage(commentPage);
     });
   
   // 댓글 수정
   $("#comments").on("click",".commentLi #save",function(){
      var re_guardNum = $("#save").attr("data-re_guardNum");
      var text = $(".con"+re_guardNum).val().replace(/\n/gi,"<br/>");
      $.ajax({
         type : "patch",
         url : contextPath+"/Guardcomments/"+re_guardNum,
         headers : {
            "Content-Type" : "application/json",
            "X-HTTP-Method-Override" : "PATCH"
         },
         data : JSON.stringify({
            content : text
         }),
         dataType : "text",
         success : function(data){
            alert(data);
            getListPage(commentPage);
         }
      }); 
   });
   
   
   
   
   // 댓글 삭제
   $("#comments").on("click",".commentLi #commentDelBtn",function(){
      var commentWrap = $(this).parent();
      var re_guardNum = commentWrap.attr("data-re_guardNum");
      $.ajax({
         type : "delete",
         url : contextPath+"/Guardcomments/"+re_guardNum,
         headers : {
            "X-HTTP-Override" : "DELETE"
         },
         dataType : "text",
         success : function(data){
            alert(data);
            getListPage(commentPage);
         }
      });
   });
   
    
   // 댓글 삽입
   $("#commentAddBtn").click(function(){
      var commentWriter = "${userInfo.name}";
      var content = $("#commentText").val().replace(/\n/gi,"<br/>");
      if(content=='' || content==null){
         alert("빈칸을 채워주세요");
         $("#commentText").focus();
         return;
      }
      
      $.ajax({
         type : "post",
         url : contextPath+"/Guardcomments/add",
         headers : {
            "Content-Type" : "application/json",
            "X-HTTP-Method-Override" : "POST"
         },
         data : JSON.stringify({
            guardNum : guardNum,
            content : content,
            commentWriter : commentWriter,
            userNum : userNum
         }),
         dataType : "text",
         success : function(data){
            alert(data);
            getListPage(1);
            $("#commentText").val("");
            $("#commentText").focus();
         },
         error : function(res){
            alert(res.responseText);
         }
      });
   });
   
   
   // 댓글 목록
   function getListPage(page){
      $.getJSON(contextPath+"/Guardcomments/"+guardNum+"/"+page,function(data){
         var pageMaker = data.pageMaker;
         var str = "";
         $(data.list).each(function(){

            str += "<li style='padding:10px;border-bottom:1px solid #D8D8D8;' data-re_guardNum='"+this.re_guardNum+"' data-text='"+this.content+"' class='commentLi'>";
            str += "<p style='margin:0px;display:inline-block;color:#000000;'>"+this.commentWriter+"</p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "<p style='font-size:14px;margin:0px;display:inline-block;color:#848484;'>"+getDate(this.regdate)+"</p>";
            // 예외처리
            if("${userInfo.userNum}"== this.userNum){
            str += "<span class='btnNumDel"+this.re_guardNum+"' style='margin:0;cursor:pointer;float:right;border:0px;font-size:14px;color:#848484;' id='commentDelBtn' >삭제</span>"
            str += "<a style='float:right;border:0px;font-size:14px;color:#BDBDBD;'>|</a>"
            str += "<span class='btnNum"+this.re_guardNum+"' style='margin:0;cursor:pointer;float:right;border:0px;font-size:14px;color:#848484;' data-re_guardNum='"+this.re_guardNum+"' id='commentModBtn' >수정</span>"
            }
            str += "<br/><p class='con"+this.re_guardNum+"' style='margin:0px;display:inline-block;color:#585858;'>" + this.content + "</p>"
            str += "</li>";
         });
         $("#comments").html(str);
         printPage(pageMaker);
         commentCnt();
      });   
   }
   
   
   // 댓글 페이징처리
   function printPage(pageMaker){
       var str = "";
         if (pageMaker.cri.page > 1) {
             str += "<a class='btn btn-primary' style='border:0;margin-right : 10px;' href='javascript:getListPage(1)'>&lt;&lt;</a>";
             if (pageMaker.prev) {
                str += "<a class='btn btn-primary' style='border:0;margin:0 10px;' href= 'javascript:getListPage("+(pageMaker.startPage-1)+")'>&lt;</a>";
             }
          }
          for (var i = pageMaker.startPage; i <= pageMaker.endPage; i++) {
             var strClass = pageMaker.cri.page == i ? ' class=active' : '';
             str += "<a style='border:0;margin:5px;' class='btn btn-primary' href='javascript:getListPage(" + i + ")' "+strClass+">" + i + "</a>";
          }

          if (pageMaker.cri.page < pageMaker.maxPage) {
             if (pageMaker.next) {
                str += "<a class='btn btn-primary' style='border:0;margin:0 10px;' href='javascript:getListPage("+(pageMaker.endPage+1)+")'>&gt;</a>"
             }
             str += "<a class='btn btn-primary' style='border:0;margin-left : 10px;'  href='javascript:getListPage("+pageMaker.maxPage+")'>&gt;&gt;</a>";
          }
         $('#pagination').html(str);
   }
   
	// 댓글 count
   function commentCnt(){
      $.getJSON("getcommentCnt/" + guardNum,function(data){
         // 첨부파일 목록 - data
         console.log(data);
         var count = data;
         var html = "<div ><p id='cnt' style='margin:0px;color:black;'>댓글목록["+data+"]</p></div>";
         $("#cnt").html(html);
      });
   }
   
   // 작성일 함수
   function getDate(timeValue){
      var dateObj = new Date(timeValue);
      var year = dateObj.getFullYear();
      var month = dateObj.getMonth()+1;
      var date = dateObj.getDate();
      var hour = dateObj.getHours();
      var minute = dateObj.getMinutes();
      var seconds = dateObj.getSeconds();
      
      if(hour<10){
         hour="0"+hour;
      }else if(minute<10){
         minute="0"+minute;
      }else if(seconds<10){
         seconds="0"+seconds;
      }else if(hour<10 && minute<10){
         hour="0"+hour;
         minute="0"+minute;
      }else if(seconds<10 && minute<10){
         seconds="0"+seconds;
         minute="0"+minute;
      }else if(hour<10 && seconds<10 && minute<10){
         hour="0"+hour;
         seconds="0"+seconds;
         minute="0"+minute;
      }
         return year + "/" + month + "/" + date + " " + hour + ":" + minute + ":" + seconds;
   }
</script>
