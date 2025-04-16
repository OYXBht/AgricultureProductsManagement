<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>用户管理</title>
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
				<!-- 侧边栏 -->
				<jsp:include page="/pages/component/side_nav_template.jsp">
					<jsp:param value="active" name="8" />
				</jsp:include>
			</div>

			<div class="col-sm-12 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="row">
					<div class="col-sm-12">
						<div class="input-group">
							<div class="row">
								<form action="/user/search" method="post">
									<div class="col-sm-4">
										<input type="text" class="form-control" name="userId" placeholder="请输入UID">
									</div>
									<div class="col-sm-4">
										<input type="text" class="form-control" name="userName" placeholder="请输入账号">
									</div>
									<div class="col-sm-4">
										<div class="row">
											<div class="col-sm-4">
												<span class="input-group-btn">
													<button class="btn btn-primary" type="submit">搜索</button>
												</span>
											</div>
											<div class="col-sm-4">
												<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addUser">添加账号</button>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>

				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
						<tr>
							<th>#</th>
							<th>UID</th>
							<th>账号</th>
							<th>邮箱</th>
							<th>密码</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach var="user" items="${userList}" varStatus="status">
							<tr>
								<th>${status.index + 1}</th>
								<th>${user.getUserId()}</th>
								<th>${user.getUserName()}</th>
								<th>${user.getEmail()}</th>
								<th>**********</th>
								<th>
									<c:choose>
										<c:when test="${user.getUserState() == 1}"><span class="label label-success">启用</span></c:when>
										<c:otherwise><span class="label label-danger">停用</span></c:otherwise>
									</c:choose>
								</th>
								<th>
									<button class="btn btn-primary"
											data-userid="${user.getUserId()}" data-toggle="modal" data-target="#updateUser">修改</button>
									<button class="btn btn-danger"
											data-userid="${user.getUserId()}" data-toggle="modal" data-target="#deleteUser">删除</button>
								</th>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<%--add user--%>
	<div class="modal fade" id="addUser" tabindex="-1" role="dialog"
		 aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<form action="/user/add" method="post">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="addModelLabel">添加账号</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="addUserName" class="control-label">账号:</label>
							<input type="text" class="form-control" name="userName" id="addUserName">
						</div>
						<div class="form-group">
							<label for="addEmail" class="control-label">邮箱:</label>
							<input type="text" class="form-control" name="email" id="addEmail">
						</div>
						<div class="form-group">
							<label for="addPassword" class="control-label">密码:</label>
							<input type="text" class="form-control" name="password" id="addPassword">
						</div>
						<div class="form-group">
							<label for="addUserState" class="control-label">初始状态:</label>
							<select class="form-control" name="userState" id="addUserState">
								<option value="1">启用</option>
								<option value="0">停用</option>
							</select>
						</div>
						<div class="form-group">
							<label for="addUserType" class="control-label">权限:</label>
							<select class="form-control" name="userType" id="addUserType">
								<option value="0">非管理员</option>
								<option value="1">管理员</option>
							</select>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="submit" class="btn btn-primary">提交</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<%--update user--%>
	<div class="modal fade" id="updateUser" tabindex="-1" role="dialog"
		 aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<form action="/user/update" method="post">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="updateModelLabel">修改账号信息</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="updateUserId" class="control-label">UID:</label>
							<input type="text" class="form-control" readonly name="userId" id="updateUserId">
						</div>
						<div class="form-group">
							<label for="updateUserName" class="control-label">账号:</label>
							<input type="text" class="form-control" name="userName" id="updateUserName">
						</div>
						<div class="form-group">
							<label for="updateEmail" class="control-label">邮箱:</label>
							<input type="text" class="form-control" name="email" id="updateEmail">
						</div>
						<div class="form-group">
							<label for="updatePassword" class="control-label">密码:</label>
							<input type="text" class="form-control" name="password" id="updatePassword">
						</div>
						<div class="form-group">
							<label for="updateUserState" class="control-label">初始状态:</label>
							<select class="form-control" name="userState" id="updateUserState">
								<option value="1">启用</option>
								<option value="0">停用</option>
							</select>
						</div>
						<div class="form-group">
							<label for="updateUserType" class="control-label">权限:</label>
							<select class="form-control" name="userType" id="updateUserType">
								<option value="0">非管理员</option>
								<option value="1">管理员</option>
							</select>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="submit" class="btn btn-primary">提交</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<%--delete user--%>
	<div class="modal fade" id="deleteUser" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<form action="/user/delete" method="post">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="deleteModelLabel">删除账号信息</h4>
					</div>
					<div class="modal-body">
						确认要删除该用户的所有信息吗？
						<div class="form-group hidden">
							<input type="text" class="form-control" readonly name="userId" id="deleteUserId">
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger">删除</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					</div>
				</form>
			</div>
		</div>
	</div>


	<script src="../js/jquery-3.5.1.js"></script>
	<script src="../js/bootstrap.js"></script>

	<script>
		$('#deleteUser').on('show.bs.modal', function(event) {
			let button = $(event.relatedTarget)
			let userId = button.data('userid')
			let modal = $(this)
			modal.find('#deleteUserId').val(userId)
		})

		$('#updateUser').on('show.bs.modal', function(event) {
			let button = $(event.relatedTarget)
			let userId = button.data('userid')
			let modal = $(this)
			$.ajax({
				url: '/user/getUser',
				type: "get",
				data: {
					userId: userId
				},
				success : function(result) {
					modal.find('#updateUserId').val(result.userId)
					modal.find('#updateUserName').val(result.userName)
					modal.find('#updateEmail').val(result.email)
					modal.find('#updatePassword').val(result.password)
					$('#updateUserState').val(result.userState.toString())
					$('#updateUserType').val(result.userType.toString())
				}
			})
		})
	</script>
</body>
</html>
