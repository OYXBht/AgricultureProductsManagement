<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<ul class="nav nav-sidebar">
    <c:choose>
    <c:when test="${loginUser.getUserType() == 1}">
        <li class="<%=request.getParameter("1")%>"><a href="<c:url value="/main"/>">首页</a></li>
        <li class="<%=request.getParameter("2")%>"><a href="<c:url value="/products"/>">农产品管理</a></li>
        <li class="<%=request.getParameter("3")%>"><a href="<c:url value="/categories"/>">种类管理</a></li>
        <li class="<%=request.getParameter("4")%>"><a href="<c:url value="/inventories"/>">库存管理</a></li>
        <li class="<%=request.getParameter("5")%>"><a href="<c:url value="/orders"/>">订单管理</a></li>
        <li class="<%=request.getParameter("6")%>"><a href="<c:url value="/user"/>">用户管理</a></li>
        <li class="<%=request.getParameter("7")%>"><a href="<c:url value="/info"/>">个人信息</a></li>
    </c:when>
    
    <c:otherwise>
        <li class="<%=request.getParameter("1")%>"><a href="<c:url value="/main"/>">首页</a></li>
        <li class="<%=request.getParameter("2")%>"><a href="<c:url value="/products"/>">农产品列表</a></li>
        <li class="<%=request.getParameter("3")%>"><a href="<c:url value="/info"/>">个人信息</a></li>
    </c:otherwise>
    </c:choose>
</ul>
