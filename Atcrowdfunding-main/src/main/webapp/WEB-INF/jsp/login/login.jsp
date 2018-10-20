<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
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
	  
      <form id="loginForm" method="post" action="${APP_PATH }/doLogin.do"  name="loginForm" class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
		  <div class="form-group has-success has-feedback">
			<input type="text" id="loginacct" name="loginacct" value="sysadmin" placeholder="请输入登录账号"  class="form-control" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="password" id="userpswd" name="userpswd" value="123" placeholder="请输入登录密码" class="form-control" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<select id="usertype" class="form-control" name="usertype">
                <option value="member" >会员</option>
                <option value="user" selected="selected">管理</option>
            </select>
		  </div>
		  <div>
		 	<p style="color:red;" id="error"><%-- ${ exception.message } --%></p>
		  </div>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住我
          </label>
          <br>
          <label>
            	忘记密码
          </label>
          <label style="float:right">
            <a href="${APP_PATH}/login/reg.html">我要注册</a>
          </label>
        </div>
        <a class="btn btn-lg disabled btn-success btn-block" id="loginbtn" onclick="dologin()" > 登录</a>
      </form>
    </div>
    <script src="${APP_PATH }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH }/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/jquery/layer/layer.js"></script>
    <script>
        $(function(){
            var loginacct = $("#loginacct");
            var userpswd = $("#userpswd");
            var loginbtn = $("#loginbtn");
            var error = $("#error");

            //表单内容改变，对按钮进行禁用检测
            $("#loginacct,#userpswd").on('input',function(e){
                if(loginacct.val() != "" && userpswd.val() != "") {
                    loginbtn.removeClass("disabled btn-success").addClass("btn-success");
                }else{
                    loginbtn.removeClass("disabled").addClass("disabled");
                }
            });

            //表单内容一聚焦，错误提示消失
            $("#loginacct,#userpswd").on('focus',function(e){
                if(loginacct.val() != "" || userpswd.val() != "") {
                    error.text("");
                }
            });

        });

	    function dologin() {
	    	var loginacct = $("#loginacct");
	    	var userpswd = $("#userpswd");
	    	var usertype = $("#usertype");
	    	var url = "${APP_PATH}/doLogin.do";
	    	var loadingIndex = -1;
	    	
	    	$.ajax({
	    		type : "POST",
	    		data : {
	    			//前面加不加双引号都可以，为了区别一般加上
	    			"loginacct" : loginacct.val(),
	    			"userpswd" : userpswd.val(),
                    usertype : usertype.val()
	    		},
	    		url : url,
	    		beforeSend : function(){
	    			//一般来做表单校验
	    			//对于表单数据而言不能用null来判空，如果文本框不输入，获取的是""
	    	    	if($.trim(loginacct.val()) == ""){
	    	    	    layer.msg("用户名不能为空，请重新输入！",{time:1000,icon:5,shift:6},function(){
                            userpswd.val("");
                            loginacct.focus();
                            //return false;  在layer中return，只是对layer的函数进行了返回，并未返回外层函数
                        });
	    	    		return false;
	    	    	}else if($.trim(userpswd.val()) == ""){
                        layer.msg("密码不能为空，请重新输入！",{time:1000,icon:5,shift:6},function(){
                            loginacct.val("");
                            userpswd.focus();
                            //return false;  在layer中return，只是对layer的函数进行了返回，并未返回外层函数
                        });
	    	    		return false;
	    	    	}

                    loadingIndex = layer.msg("登录中...",{icon:16});
	    			return true;
	    		},
	    		success : function(result){
	    		    layer.close(loadingIndex);
	    			if(result.success){
	    			    if("member" == usertype.val()){
                            window.location.href = "${APP_PATH}/index.html";
                        }else{
                            window.location.href = "${APP_PATH}/main.html";
                        }

	    			}else{
	    			    layer.msg(result.message,{time:2000,icon:5,shift:6});
	    				//$("#error").text("用户名密码不正确!");
	    			}
	    		},
	    		error : function(){
	    			//一般不用
                    layer.msg("登录异常!",{time:2000,icon:5,shift:6});
	    			//alert("error");
	    		}
	    	});
	    	
	    	//$("#loginForm").submit();
	    	
	        /* var type = $(":selected").val();
	        if ( type == "user" ) {
	        	//document.form1.action = "/checklogin";
	        	document.form1.submit();
	        } else {
	        	window.location.href = "main.html";
	        } */
	    }
    </script>
  </body>
</html>