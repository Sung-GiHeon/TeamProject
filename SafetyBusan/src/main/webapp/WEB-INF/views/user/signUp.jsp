<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<style>
		.float{
			display:flex;
		}
		.flex{
			display:flex;
		}
		.float > div{
			margin:20px 10px;
		}
		.mailCheck{
			display:flex;
		}
		.mailCheck > #mailRequest{
			margin-left:5px;
		}
		.input100{
			top:50px;
		}
		.mailConfirmCheck{
			margin-top:2%;
			display:flex;
		}
		 
		.mailConfirmCheck > #okBtn{
			margin:0 1%;
		}
		
		.mailConfirmCheck > #Timer{
			width:65px;
			margin-left: 2%;
		}
		
		.left{
			float:left;
		}
		
		#Timer{
			display:none;
		}
		li{
			style:none;
		}
	</style>
	<title>Login V15</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/login/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/login/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/login/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/login/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/login/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/login/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/login/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/login/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/login/css/util.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/login/css/main.css">
<!--===============================================================================================-->
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form-title" style="background-image:url('police.jpg');">
					<span class="login100-form-title-1">
						회원 가입
					</span>
				</div>

				<form class="login100-form validate-form" action="signUpPost" method="post">
					<div class="wrap-input100 validate-input m-b-10" data-validate="이름을 입력하지 않으셨습니다.">
						<span class="label-input100">이름</span>
						<input tabindex="1" id="u_name" class="input100" type="text" name="name" placeholder="이름을 입력해주세요.">
						<span class="focus-input100"></span>
					</div>
					<div class="wrap-input100 validate-input m-b-10" data-validate="이메일을 입력하지 않으셨습니다.">
						<span class="label-input100">이메일 주소</span>
						<input tabindex="2" id="u_email" class="input100" type="text" name="email" placeholder="아이디를 입력해주세요.">
						<span class="focus-input100"></span>
					</div>
					<div class="mailCheck">
						<button id="mailBtn" type="button" class="login50-form-btn">
							이메일 중복확인
						</button>
						<button id="mailRequest" type="button" class="login50-form-btn">
							인증메일 발송
						</button>
					</div>
					
					<div class="mailConfirmCheck">
						<div class="wrap-input50">
							<input id="mailCode" class="input60" type="text" name="username" placeholder="email 인증번호">
							<span class="focus-input100"></span>
						</div>
						<div id="Timer">
						</div>
						<button type="button" id="okBtn" class="login30-form-btn">
							확인
						</button>
						<button id="mailRequest_RE" type="button" class="login30-form-btn">
							재전송
						</button>	
					</div>
					
					<div id="password" class="wrap-input100 validate-input m-b-5" data-validate = "비밀번호를 입력하지 않으셨습니다.">
						<span class="label-input100">비밀번호</span>
						<input tabindex="3" id="u_pw" class="input100" type="password" name="password" placeholder="비밀번호를 입력해주세요.">
						<span class="focus-input100"></span>
					</div>
					
					<div class="wrap-input100 validate-input m-b-5" data-validate = "비밀번호 확인을 입력하지 않으셨습니다.">
						<span class="label-input80">비밀번호 확인</span>
						<input tabindex="4" id="u_repw" class="input100" type="password" name="re_password" placeholder="확인 비밀번호를 입력하지 않으셨습니다.">
						<span class="focus-input100"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate = "핸드폰번호를 입력하지 않으셨습니다.">
						<span class="label-input100 phone">Tel.</span>
						<input tabindex="5" id="u_ph" class="input100" type="number" name="phoneNum" placeholder="핸드폰번호를 입력해주세요.">
						<span class="focus-input100"></span>
					</div>
					<div class="flex">
						<div class="wrap-input60 left">
							<span class="label-input100">주소</span>
							<input id="u_addr_post" class="input100" type="text" name="post" placeholder="주소를 입력하여주세요." >
							<span class="focus-input100" ></span>
						</div>
						<button type="button" id="addrBtn" class="login60-form-btn">주소찾기</button>
					</div>
					<div class="wrap-input100 validate-input left" data-validate = "주소를 입력하지 않으셨습니다.">
						<input id="u_addr"class="input100" type="text" name="addr" placeholder="주소를 입력하여주세요.">	
						<span class="focus-input100" ></span>
					</div>
					
					<div class="wrap-input100 validate-input left" data-validate = "주소를 입력하지 않으셨습니다.">
						<input tabindex="6" id="u_addr_detail" class="input100" type="text" name="addrDetail" placeholder="주소를 입력하여주세요.">
						<span class="focus-input100" ></span>
					</div>
					<div class="float">
						<div class="container-login100-form-btn">
							<button id="signUp" class="login100-form-btn">
								SignUp
							</button>
						</div>
						<div class="container-login100-form-btn">
							<button id="homeBtn" type="button" class="login100-form-btn">
								home
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		var SetTime = 10;
		
		function msg_time(){
			
			m = Math.floor(SetTime / 60)+"분"+(SetTime % 60)+"초";
			var msg ="<font>"+m+"</font>"
			
			$("#Timer").html(msg);
			
			SetTime--;
			/* /붙으면 root컨텍스트  */
			if(SetTime < 0){
				clearInterval(tid);
				$.getJSON("endCode",function(data){
					alert("재전송 해주시기 바랍니다.");
				});
			}
		}
	
		function clear_time(){
			
			clearInterval(tid);
			
			SetTime = 180;
			
			tid = setInterval('msg_time()',1000);
			
			m = Math.floor(SetTime / 60)+"분"+(SetTime % 60)+"초";
			var msg ="<font>"+m+"</font>"
			
			$("#Timer").html(msg);
			
			SetTime--;
			
			if(SetTime < 0){
				clearInterval(tid);
				$.getJSON("endCode",function(data){
					alert("재전송 해주시기 바랍니다.");
				});
			}
		}
	
		function stop_time(){
			
			SetTime = 180;
			
			clearInterval(tid);
			
			m = Math.floor(SetTime / 60)+"분"+(SetTime % 60)+"초";
			var msg ="<font>"+m+"</font>"
			
			$("#Timer").html(msg);
		}
	
	
		$(function(){
			
			var boolUid = false;
			var boolPassword = false;
			var boolPasswordCheck = false;
			var boolPhone = false;
			var boolName = false;
			var boolAddress = false;
			var boolEmailCheck = false;
			var regexEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
			var regexPass = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;			// 영문,숫자를 혼합하여 6~20자 이내
			var regexMobile = /^[0-9]{3}?[0-9]{4}?[0-9]{4}$/;
			var regexName = /^[\uac00-\ud7a3]{2,6}$/;
			var input = $('.validate-input .input100');
			
			//정규식 test,match의 차이점
			$("#u_name").on("input",function(){
				var tempVal = $(this).val();
				
				if(regexName.test(tempVal) === false){
					boolName = false;
					$("#u_name").parent().removeClass('alert-validate2');
					$("#u_name").parent().attr("data-validate",'한글로 2~6자 이내로 작성하시오.');
					$("#u_name").parent().addClass('alert-validate');
					
				}else{
					boolName = true;
					$("#u_name").parent().removeClass('alert-validate');
					$("#u_name").parent().attr("data-validate",'사용 가능합니다.');
					$("#u_name").parent().addClass('alert-validate2');
				}	
			});
			$("#u_email").on("input",function(){
				var tempVal = $(this).val();
				if(regexEmail.test(tempVal) === false){
					boolUid = false;
					boolEmailCheck = false;
					$("#u_email").parent().attr("data-validate",'올바른 이메일 형식이 아닙니다.');
					$("#u_email").parent().addClass('alert-validate');
					
				}else{
					boolUid = false;
					$("#u_email").parent().attr("data-validate",'중복 확인을 해주세요.');
					$("#u_email").parent().addClass('alert-validate');
				}	
			});
			
			$("#u_pw").on("input",function(){
				var tempVal = $(this).val();
				
				if(regexPass.test(tempVal) === false){
					boolPassword = false;
					$("#u_pw").parent().removeClass('alert-validate2');
					$("#u_pw").parent().attr("data-validate",'영문/숫자로 6~20자 작성하세요.');
					$("#u_pw").parent().addClass('alert-validate');
					
				}else{
					boolPassword = true;
					$("#u_pw").parent().removeClass('alert-validate');
					$("#u_pw").parent().attr("data-validate",'사용 가능합니다.');
					$("#u_pw").parent().addClass('alert-validate2');
				}	
			});
			
			$("#u_repw").on("input",function(){
				var tempVal = $(this).val();
				var originVal = $("#u_pw").val();
				
				if(tempVal != '' && tempVal == originVal && regexPass.test(originVal) === true ){
					boolPasswordCheck = true;
					$("#u_repw").parent().removeClass('alert-validate');
					$("#u_repw").parent().attr("data-validate",'사용 가능합니다.');
					$("#u_repw").parent().addClass('alert-validate2');
				}else{
					boolPasswordCheck = false;
					$("#u_repw").parent().removeClass('alert-validate2');
					$("#u_repw").parent().attr("data-validate",'비밀번호가 일치하지 않습니다.');
					$("#u_repw").parent().addClass('alert-validate');
				}
			});
			
			$("#u_ph").on("input",function(){
				var tempVal = $(this).val();
				
				if(regexMobile.test(tempVal) === false){
					boolPhone = false;
					$("#u_ph").parent().removeClass('alert-validate2');
					$("#u_ph").parent().attr("data-validate",'-표시없이 번호만 입력해주세요');
					$("#u_ph").parent().addClass('alert-validate');
					
				}else{
					boolPhone = true;
					$("#u_ph").parent().removeClass('alert-validate');
					$("#u_ph").parent().attr("data-validate",'사용 가능합니다.');
					$("#u_ph").parent().addClass('alert-validate2');
				}
			});
			
			//인증메일 확인
			$("#okBtn").on("click",function(){
				if($("#mailCode").val() == ""){
					alert("e-mail인증 번호를 입력하여 주세요.");
				}else{
					$.ajax({
						type:"GET",
						url:"/testt/user/mailConfirm",
						data:{
							mailCode : $("#mailCode").val(),
							random : "${random}"
						},
						success:function(data){
							if(data == "complete"){
								alert("이메일 인증 성공");
								boolEmailCheck = true;
								stop_time();
							}else{
								alert("인증 실패")
								boolEmailCheck = false;
							}
						}
					})
				}
			});		
			
			var first_email = false;
			
			//인증메일 발송
			$("#mailRequest").on("click",function (){
				
				if(boolUid == false){
					alert("이메일 중복확인을 확인해주세요.");	
				}else{
					if(first_email == false){
						tid = setInterval('msg_time()',1000);
						
						$("#Timer").show("slow");
						
						$.ajax({
							type:"GET",
							url:"/testt/user/mailRequest",
							data:{
								email : $("#u_email").val(),
								random : "${random}"
							},
							success : function(data){
								alert("인증메일이 발송되었습니다.");
								first_email = true;
							},
							error : function(data){
								alert("인증메일 발송이 실패하셨습니다.");
								first_email = false;
							}
						})
					}else{
						alert("재전송 버튼을 이용하세요.");
					}
				}
			});
			
			//이메일 재확인
			$("#mailRequest_RE").on("click",function (){
				
				boolEmailCheck = false;
				
				if(boolUid == false ){
					alert("이메일 중복확인을 확인해주세요.");	
				}else if(first_email != true){
					alert("이메일이 전송되지 않았습니다.")
				}else{	
					
					clear_time();
					
					$.ajax({
						type:"GET",
						url:"/testt/user/mailRequest",
						data:{
							email : $("#u_email").val(),
							random : "${random}"
						},
						success : function(data){
							alert("인증메일이 발송되었습니다.");
						},
						error : function(data){
							alert("인증메일 발송이 실패하셨습니다.");
						}
					})
				}
			});
			
			$("#homeBtn").click(function(){
				location.href="/testt/"
			});
			
			
			 var input = $('.validate-input .input100');
				
			    $('.validate-form .input100').each(function(){
			        $(this).focus(function(){
			           hideValidate(this);
			        });
			    });
			    
			    $('.validate-form').on('submit',function(){
			        var check = true;
			        
			        for(var i=0; i<input.length; i++) {
			            if(validate(input[i]) == false){
			                showValidate(input[i]);
			                check=false;
			            }
			        }
			        if(boolName == false){
		            	$("#u_name").focus();
		            	$("#u_name").parent().attr("data-validate",'2~6자 이내로 작성해 주세요.');
						$("#u_name").parent().addClass('alert-validate');
		            	check=false;
			        }else if(boolUid == false){
			        	$("#u_email").focus();
			        	$("#u_email").parent().attr("data-validate",'올바른 이메일 형식이 아닙니다.');
						$("#u_email").parent().addClass('alert-validate');
						check=false;
			        }else if(boolPassword == false){
			        	$("#u_pw").focus();
			        	$("#u_pw").parent().attr("data-validate",'영문/숫자로 6~20자 작성하세요.');
						$("#u_pw").parent().addClass('alert-validate');
						check=false;
			        }else if(boolPasswordCheck == false){
			        	$("#u_repw").focus();
			        	$("#u_repw").parent().attr("data-validate",'비밀번호가 일치하지 않습니다.');
						$("#u_repw").parent().addClass('alert-validate');
						check = false;
			        }else if(boolPhone == false){
			        	$("#u_ph").focus();
			        	$("#u_ph").parent().attr("data-validate",'-표시없이 번호만 입력해주세요');
						$("#u_ph").parent().addClass('alert-validate');
						check = false;
			        }else if(boolEmailCheck == false){
			        	$("#emailConfirm").focus();
			        	alert("이메일을 인증하여 주세요.")
			        	check = false;
			        }
			        
			        return check;
				});
				
			    function validate (input) {
			    	if($(input).val().trim() == ''){
			    		return false;
			        }
			    }

			    function showValidate(input) {
			        var thisAlert = $(input).parent();

			        $(thisAlert).addClass('alert-validate');
			    }

			    function hideValidate(input) {
			        var thisAlert = $(input).parent();

			        $(thisAlert).removeClass('alert-validate');
			    }
			    
			  //이메일 확인 비동기 처리
				$("#mailBtn").click(function(){
					var tempVal = $("#u_email").val();
					
					$.ajax({
						type : "post",
						url: "uidCheck",
						dataType : "json",
						data :{
							u_email : $("#u_email").val()
						},
						success: function(data){
							if(data){
								boolUid = false;
								$("#u_email").parent().removeClass('alert-validate2');
								$("#u_email").parent().attr("data-validate",'중복된 아이디입니다.');
								$("#u_email").parent().addClass('alert-validate');
							}else{
								boolUid = true;
								if($("#u_email").val() != null && regexEmail.test(tempVal) === true){
									$("#u_email").parent().removeClass('alert-validate');
									$("#u_email").parent().attr("data-validate",'사용 가능합니다.');
									$("#u_email").parent().addClass('alert-validate2');
									$("#mailConfirm").removeAttr("hidden");
								}
							}
						}
					});
				});
		});
			
		$("#addrBtn").on("click",function(event){
			sample6_execDaumPostcode();
		});
		
		// (다음) 주소명 
		function sample6_execDaumPostcode(){
			//alert("클릭");
			new daum.Postcode({
				oncomplete : function(data){
					//주소 검색 결과
					console.log(data);
					
					var fullAddr = "";	// 최종 주소
					var extraAddr = ""; 	// 조합형 주소
					
					if(data.userSelectedType == 'R'){ //도로명 주소
						fullAddr = data.roadAddress;
					}else{
						fullAddr = data.jibunAddress;					
					}
					
					if(data.userSelectedType == 'R'){
						//법정동명
						if(data.bname !== ''){
							extraAddr += data.bname;
						}
						//건물명 
						//===데이터타입과 value값을 같이 비교
						if(data.buildingName !== ''){
							extraAddr += (extraAddr !== '' ? ','+data.buildingName : data.buildingName);
						}
						fullAddr += (extraAddr !== '' ? '('+extraAddr+')' : '');
					}
					
					$("#u_addr_post").val(data.zonecode);
					
					$("#u_addr").val(fullAddr);
					
					$("#u_addr_detail").focus();
				}
			}).open();
		}
		
	</script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/resources/login/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/resources/login/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/resources/login/vendor/bootstrap/js/popper.js"></script>
	<script src="${pageContext.request.contextPath}/resources/login/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/resources/login/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/resources/login/vendor/daterangepicker/moment.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/login/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/resources/login/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/resources/login/js/main.js"></script>	
</body>
</html>