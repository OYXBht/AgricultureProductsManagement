<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<ul class="nav navbar-nav navbar-right">
	<li><a href="<c:url value="/info"/>">${loginUser.getUserName()}</a></li>
	<li><a href="<c:url value="/logout"/>">退出登录</a></li>
</ul>
