<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>登录</title>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<link rel="stylesheet" href="<%=basePath%>/css/bootstrap.css">

    <style>
        body {
            background-image: url("<%=basePath%>/img/bg2.png");
            background-repeat: repeat;
            background-size: cover;
            color: white;
        }
        .loginBox {
            width: 450px;
            height: 400px;
            position: absolute;
            top: 50%;
            left: 50%;
            margin-left: -200px;
            margin-top: -150px;

            background: rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(10px); /* 毛玻璃模糊效果 */
            -webkit-backdrop-filter: blur(10px);
            border-radius: 15px;
        }
        #pwdBox {
            margin-top: 25px;
        }
        .loginBtn{
            height: 40px;
            width: 200px;
            text-align: center;
            margin: auto;
        }
        .loginLabel{
            text-align: center;
            font-size: 2em;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="loginBox">
            <form class="form-horizontal" action="<%=basePath%>/register/doRegister" method="post">
                <div class="loginLabel">
                    <label style="margin-top: 30px">用户注册</label>
                </div>
                <div class="form-group" style="margin-top: 20px;">
                    <label for="username" class="col-sm-2 control-label">账号</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="userName" id="username" placeholder="username" required>
                    </div>
                </div>
                <div class="form-group" id="emailBox" style="margin-top: 20px">
                    <label for="email" class="col-sm-2 control-label">邮箱</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="email" id="email" placeholder="email" required>
                    </div>
                </div>
                <div class="form-group" id="pwdBox">
                    <label for="password" class="col-sm-2 control-label">密码</label>
                    <div class="col-sm-8">
                        <input type="password" class="form-control" name="password" id="password" placeholder="password" required>
                    </div>
                </div>

                <div class="loginBtn" style="margin-top: 20px">
                    <button type="submit" class=" btn btn-info loginBtn">注册</button>
                </div>
                <div class="loginBtn" style="margin-top: 20px">
                    <button type="button" class=" btn btn-info loginBtn" onclick="window.location.href='<%=basePath%>/'">返回</button>
                </div>
            </form>
        </div>
    </div>
</body>

</html>
