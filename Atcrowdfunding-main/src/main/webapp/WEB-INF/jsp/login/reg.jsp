<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="${APP_PATH }/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH }/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH }/css/login.css">
    <style>

    </style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="${APP_PATH }/index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>

<div class="container">

    <form class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册</h2>

        <%--账号--%>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="loginacct" placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>

        <%--密码--%>
        <div class="form-group has-success has-feedback">
            <input type="password" class="form-control" id="userpswd" placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>

        <%--确认密码--%>
        <div class="form-group has-success has-feedback">
            <input type="password" class="form-control" id="confirmpswd" placeholder="确认密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>

        <%--用户姓名--%>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="username" placeholder="请输入用户名称" style="margin-top:10px;">
            <span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>

        <%--邮箱--%>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="email" placeholder="请输入邮箱地址" style="margin-top:10px;">
            <span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>

        <%--用户类型--%>
        <div class="form-group has-success has-feedback">
            <select class="form-control" id="accttype">
                <option value="2">企业</option>
                <option value="1">个人</option>
            </select>
        </div>
        <div class="checkbox">
            <label>
                忘记密码
            </label>
            <label style="float:right">
                <a href="${APP_PATH }/login/login.html">我有账号</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" href="#" onclick="submitForm();"> 注册</a>
    </form>
</div>
<script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH }/jquery/layer/layer.js"></script>
<script type="text/javascript">
        $(function(){

        });

        //登录账号离开焦点的校验
        $("#loginacct").blur(function(){
            var floginacct = $(this);
            $.ajax({
                type : "post",
                data : {"loginacct" : $.trim(floginacct.val())},
                url : "${APP_PATH}/member/checkLoginacctIsExist.do",
                beforeSend : function(){
                    if($.trim(floginacct.val()) == ""){
                        return false;
                    }
                    return true;
                },
                success : function(data){
                    if(data.success){
                        layer.msg(data.message,{time:1000,icon:5,shift:6});
                        floginacct.val("");
                        return false; //防止离开焦点和点击注册一起触发
                    }else {
                        layer.msg(data.message, {time: 1000, icon: 6});
                    }
                }
            });
        });


        //注册提交
        function submitForm(){
            var $loginacct = $("#loginacct");
            var $userpswd = $("#userpswd");
            var $confirmpswd = $("#confirmpswd");
            var $username = $("#username");
            var $email = $("#email");
            var $accttype = $("#accttype");

            //后台注册
            var loadingIndex = -1;
            $.ajax({
                type : "post",
                data : {
                    "loginacct" : $.trim($loginacct.val()),
                    "userpswd" : $.trim($userpswd.val()),
                    "username" : $.trim($username.val()),
                    "email" : $.trim($email.val()),
                    "accttype" : $.trim($accttype.val())
                },
                url : "${APP_PATH}/member/regist.do",
                beforeSend : function(){
                    //判空处理
                    if($.trim($loginacct.val()) == ""){
                        layer.msg("登录账号不能为空",{time:1500,icon:5,shift:6},function(){
                            $loginacct.focus();
                        });
                        return false;
                    }else if($.trim($userpswd.val()) == ""){
                        layer.msg("登录密码不能为空",{time:1500,icon:5,shift:6},function(){
                            $userpswd.focus();
                        });
                        return false;
                    }else if($.trim($confirmpswd.val()) == ""){
                        layer.msg("确认密码不能为空",{time:1500,icon:5,shift:6},function(){
                            $confirmpswd.focus();
                        });
                        return false;
                    }else if($.trim($confirmpswd.val()) != $.trim($userpswd.val())){
                        layer.msg("两次密码不一致，请重新输入",{time:1500,icon:5,shift:6},function(){
                            $confirmpswd.focus();
                        });
                        return false;
                    }else if($.trim($username.val()) == ""){
                        layer.msg("用户姓名不能为空",{time:1500,icon:5,shift:6},function(){
                            $email.focus();
                        });
                        return false;
                    }else if($.trim($email.val()) == ""){
                        layer.msg("邮箱不能为空",{time:1500,icon:5,shift:6},function(){
                            $email.focus();
                        });
                        return false;
                    }else if($.trim($accttype.val()) == "2"){
                        var confirm = -1;
                        layer.confirm("确定是要注册企业账号？",{icon:3,title:"提示"},
                            function(index){
                                layer.close(index);
                                confirm = 1;
                            },
                            function(index){
                                layer.close(index);
                                confirm = 0;
                            }
                        );
                        if(confirm != 1){
                            return false;
                        }
                    }

                    //对邮箱做正则校验：数字、字母、下划线 + @ + 数字、英文 + . +英文（长度是2-4）
                    var reg = /^[\w]+@[a-z0-9A-Z]+\.[a-zA-Z]{2,4}$/g;
                    if(!reg.test(femail.val())){
                        layer.msg("邮箱格式不合法，请重新填写",{time:1000,icon:5,shift:6},function(){
                            femail.focus();
                        });
                        return false;
                    }

                    loadingIndex = layer.msg("注册中...",{icon:16});
                    return true;
                },
                success : function(result){
                    layer.close(loadingIndex);
                    if(result.success){
                        layer.confirm(result.message+"! 是否现在前往登录页面？",{icon:3,title:"提示"},
                            function(){
                                window.location.href = "${APP_PATH}/login/login.htm";
                            },
                            function(index){
                                layer.close(index);
                                window.history.go(0);
                            }
                        );
                    }else{
                        layer.msg(result.message,{time:1500,icon:5,shift:6});
                        window.history.go(0);
                    }
                },
                error : function(result){
                    layer.close(loadingIndex);
                    layer.msg(result.message,{time:1500,icon:5,shift:6});
                }
            });
        }
</script>
</body>
</html>
