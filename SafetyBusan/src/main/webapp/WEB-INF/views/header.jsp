<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/assets/css/main.css" />
	<noscript>
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/resources/assets/css/noscript.css" />
	</noscript>	
<header id="header" class="alt">
	<h1>
		<a href="#banner">Saftey Busan</a>
	</h1>
	<nav id="nav">
		<ul>
			<li class="special"><a href="#menu" class="menuToggle"><span>Menu</span></a>
				<div id="menu">
					<ul>
						<li><a href="#banner">Home</a></li>
						<li><a href="#aboutus">About</a></li>
						<li><a href="#statictics">Statistics</a></li>
						<li><a href="#three">Board & Community</a></li>
						<li><a href="user/signUp">Sign Up</a></li>
						<c:if test="${!empty userInfo}">
							<li>${userInfo.name}님 환영합니다.</li>
							<li><a href="user/logout">Log Out</a></li>
						</c:if>
						<c:if test="${empty userInfo}">
							<li><a href="user/logIn">Log In</a></li>
						</c:if>
					</ul>
				</div>
			</li>
		</ul>
	</nav>
</header>

