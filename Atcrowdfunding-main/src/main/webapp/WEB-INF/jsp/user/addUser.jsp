<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="user.html">众筹平台 - 用户维护</a></div>
        </div>
        <%--顶部导航栏--%>
        <%@include file="../common/header2.jsp"%>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <%--左侧导航栏--%>
        <%@include file="../common/sidebar.jsp"%>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="${APP_PATH}/index.htm">首页</a></li>
                <li><a href="${APP_PATH}/user/toUser.do">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form role="form" id="userForm">
                        <div class="form-group">
                            <label for="floginacct">登陆账号</label>
                            <input type="text" class="form-control" id="floginacct" placeholder="请输入登陆账号">
                        </div>
                        <div class="form-group">
                            <label for="fusername">用户名称</label>
                            <input type="text" class="form-control" id="fusername" placeholder="请输入用户名称">
                        </div>
                        <div class="form-group">
                            <label for="femail">邮箱地址</label>
                            <input type="email" class="form-control" id="femail" placeholder="请输入邮箱地址">
                            <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                        </div>
                        <button type="button" class="btn btn-success" id="addBtn"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                        <button type="button" class="btn btn-danger" id="refreshBtn"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题1</h4>
                    <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题2</h4>
                    <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
                </div>
            </div>
            <!--
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/jquery/layer/layer.js"></script>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }

        });

        $("#floginacct").blur(function(){
            var floginacct = $("#floginacct");
            $.ajax({
                type : "post",
                data : {"loginacct" : $.trim(floginacct.val())},
                url : "${APP_PATH}/user/checkLoginacct.do",
                beforeSend : function(){
                    if($.trim(floginacct.val()) == ""){
                        return false;
                    }
                    return true;
                },
                success : function(result){
                    if(result.success){
                        layer.msg("用户名已存在，请重新输入用户名",{time:1000,icon:5,shift:6});
                        floginacct.val("").focus();
                        return false; //防止离开焦点和点击新增一起触发
                    }
                }
            });
        });

        //新增用户
        var loadIndex = -1;
        $("#addBtn").click(function(){
            var floginacct = $("#floginacct");
            var fusername = $("#fusername");
            var femail = $("#femail");

            $.ajax({
                type : "post",
                data : {
                    "loginacct" : $.trim(floginacct.val()),
                    "username" : $.trim(fusername.val()),
                    "email" : $.trim(femail.val())
                },
                url : "${APP_PATH}/user/addUser.do",
                beforeSend : function(){
                    //对表单做校验
                    if($.trim(floginacct.val()) == ""){
                        layer.msg("登录账号不能为空，请输入",{time:1000,icon:5,shift:6},function(){
                            floginacct.focus();
                        });
                        return false;
                    }else if($.trim(fusername.val()) == ""){
                        layer.msg("用户名称不能为空，请输入",{time:1000,icon:5,shift:6},function(){
                            fusername.focus();
                        });
                        return false;
                    }

                    //对邮箱做正则校验：数字、字母、下划线 + @ + 数字、英文 + . +英文（长度是2-4）
                    var reg = /^[\w]+@[a-z0-9A-Z]+\.[a-zA-Z]{2,4}$/g;
                    if(!reg.test(femail.val())){
                        layer.msg("邮箱格式不合法，请重新填写",{time:1000,icon:5,shift:6},function(){
                            femail.focus();
                        });
                        return false;
                    }

                    loadIndex = layer.load(2,{time:10*1000});
                    return true;
                },
                success : function(result){
                    layer.close(loadIndex);
                    if(result.success){
                        window.location.href = "${APP_PATH}/user/toUser.do";
                    }else{
                        layer.msg(result.message,{time:2000,icon:5,shift:6});
                    }
                },
                error : function(result){
                    layer.msg(result.message,{time:2000,icon:5,shift:6});
                }
            })
        });

        $("#refreshBtn").click(function(){
            //JS中表单对象的reset()函数可重置，而jquery中没有
            $("#userForm")[0].reset();
        });
    });
</script>
</body>
</html>

