<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查分</title>

<%@ include file="/pages/component/css_template.jsp"%>
</head>

<body>
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">IMAU农产品在线销售平台</span> <span class="icon-bar"></span>
					<span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/StudentManage/mainUrl">IMAU农产品在线销售平台</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<!-- 导航条菜单 -->
				<%@ include file="/pages/component/side_nav_template.jsp"%>
			</div>
		</div>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">

				<!-- 侧边栏 -->
				<jsp:include page="/pages/component/side_nav_template.jsp">
					<jsp:param value="active" name="2" />
				</jsp:include>

			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h1 class="page-header">${student.getDescription()}</h1>

				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>#</th>
								<th>课程</th>
								<th>分数</th>
								<th>授课老师</th>
								<th>排名</th>
								<th>选课人数</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="score" items="${scores }" varStatus="status">
								<tr>
									<td>${status.index + 1 }</td>
									<td>${score.courseName }</td>
									<td>${score.courseNo }</td>
									<td>${score.teacherName }</td>
									<td>${score.rank }</td>
									<td>${score.studentNum }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
