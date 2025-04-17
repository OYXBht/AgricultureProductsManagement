<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户信息</title>
<%@ include file="/pages/component/css_template.jsp"%>
<%@ include file="/pages/component/js_template.jsp"%>
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
				<a class="navbar-brand">IMAU农产品在线销售平台</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<!-- 导航条菜单 -->
				<%@ include file="/pages/component/header_nav_template.jsp"%>
			</div>
		</div>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<jsp:include page="/pages/component/side_nav_template.jsp">
					<jsp:param value="active" name="3" />
				</jsp:include>
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div>
					<div class="panel panel-default">
						<ul class="list-group">
							<li class="list-group-item">
								<span class="label label-primary">UID</span>
								${loginUser.getUserId()}
							</li>
							<li class="list-group-item">
								<span class="label label-primary">账&#12288号</span>
								${loginUser.getUserName()}
							</li>
							<li class="list-group-item">
								<span class="label label-primary">邮&#12288箱</span>
								${loginUser.getEmail()}
							</li>
							<li class="list-group-item">
								<span class="label label-primary">密&#12288码</span>
								${loginUser.getPassword()}
							</li>
							<li class="list-group-item">
								<span class="label label-primary">权&#12288限</span>
								<c:choose>
									<c:when test="${loginUser.getUserType() == 1}">管理员</c:when>
									<c:otherwise>非管理员</c:otherwise>
								</c:choose>
							</li>
						</ul>
					</div>

					<button class="btn btn-primary" style="float: right;" type="button"
							data-userid="${loginUser.getUserId()}" data-toggle="modal" data-target="#updateUser">修改
					</button>
				</div>
			</div>
		</div>
	</div>

	<%--updataUser--%>
	<div class="modal fade" id="updateUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<form action="info/update" method="post">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">更改信息</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="updateUserId" class="control-label">UID:</label>
							<input type="text" readonly class="form-control" name="userId" id="updateUserId">
						</div>
						<div class="form-group">
							<label for="updateUsername" class="control-label">账号:</label>
							<input type="text" class="form-control" name="userName" id="updateUsername" required>
						</div>
						<div class="form-group">
							<label for="updateEmail" class="control-label">邮箱:</label>
							<input type="text" class="form-control" name="email" id="updateEmail" required>
						</div>
						<div class="form-group">
							<label for="updateEmail" class="control-label">密码:</label>
							<input type="text" class="form-control" name="password" id="updatePassword" required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="submit" class="btn btn-primary">保存</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
		$('#updateUser').on('show.bs.modal', function(event) {
			let button = $(event.relatedTarget)
			let userId = button.data('userid')
			let modal = $(this)
			$.ajax({
				url: '/info/getInfo',
				type: "get",
				data: {
					userId: userId
				},
				success : function(result) {
					modal.find('#updateUserId').val(result.userId)
					modal.find('#updateUsername').val(result.userName)
					modal.find('#updateEmail').val(result.email)
					modal.find('#updatePassword').val(result.password)
				}
			})
		})
	</script>
</body>
</html>
