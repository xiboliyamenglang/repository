<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
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
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
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
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <%--模糊搜索表单--%>
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input class="form-control has-success" type="text" id="condition" name="condition" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning" onclick="queryUserCondition();"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" id="delBatchBtn" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${APP_PATH}/user/toAddUser.do'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox" id="allCheckBtn"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                                <%--用户展示表格--%>
                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <%--分页导航条--%>
                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
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

            queryUser(1);
        });
        $("tbody .btn-success").click(function(){
            window.location.href = "${APP_PATH}/role/toAssignRole.htm";
        });
        $("tbody .btn-primary").click(function(){
            window.location.href = "${APP_PATH}/user/toEditUser.htm";
        });

        function changePage(pageno){
            window.location.href = "${APP_PATH}/user/queryuser.do?pageno="+pageno;
        }


        //分页查询用户
        var layerIndex = -1;
        var jsonObj = {
                            "pageno" : 1,
                            "pagesize" : 10
                        };
        function queryUser(pageno){
            jsonObj.pageno = pageno;
            $.ajax({
                type : "post",
                data : jsonObj,
                url : "${APP_PATH}/user/queryuser.do",
                beforeSend : function(){
                    //alert(jsonObj.pageno+"|"+jsonObj.pagesize);
                    layerIndex = layer.load(2, {time: 10*1000});
                    return true;
                },
                success : function(result){
                    layer.close(layerIndex);
                    if(result.success){
                        var page = result.page; //Page对象
                        var userList = page.objList; //User集合

                        //循环将用户数据写入表格
                        var content = "";
                        $.each(userList,function(i,user){
                            content += '<tr>';
                            content += '<td>'+(i+1)+'</td>';
                            content += '<td><input type="checkbox" value="'+user.id+'"></td>';
                            content += '	<td>'+user.loginacct+'</td>';
                            content += '	<td>'+user.username+'</td>';
                            content += '	<td>'+user.email+'</td>';
                            content += '	<td>';
                            content += '	<button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                            content += '<button type="button" onclick="window.location.href=\'${APP_PATH}/user/toEditUser.do?id='+user.id+'\'" class="btn btn-primary btn-xs" ><i class=" glyphicon glyphicon-pencil"></i></button>';
                            content += '<button type="button" onclick="delUser('+user.id+');" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                            content += '</td>';
                            content += '</tr>';
                        });
                        $("tbody").html(content);

                        //生成分页导航条
                        var foot = "";
                        if(page.pageno == 1){
                            foot += '<li class="disabled"><a href="#">上一页</a></li>';
                        }else{
                            foot += '<li ><a href="#" onclick="queryUser('+(page.pageno-1)+')">上一页</a></li>';
                        }
                        for(var i=1; i<=page.totalpage; i++){
                            if(page.pageno == i){
                                foot += '<li class="active"><a href="#" onclick="queryUser('+i+')">'+i+'</a></li>'
                            }else{
                                foot += '<li><a href="#" onclick="queryUser('+i+')">'+i+'</a></li>'
                            }
                        }
                        if(page.pageno == page.totalpage){
                            foot += '<li class="disabled"><a href="#">下一页</a></li>';
                        }else{
                            foot += '<li ><a href="#" onclick="queryUser('+(page.pageno+1)+')">下一页</a></li>';
                        }
                        $("ul.pagination").html(foot);

                    }else{
                        layer.load(result.message,{time:2000,icon:5,shift:6});
                    }
                },
                error : function(){
                    layer.msg("加载数据异常!", {time:1000, icon:5, shift:6});
                }
            });
        }

        //通过条件查询用户
        function queryUserCondition(){
            var condition = $("#condition").val();
            jsonObj.condition = condition;
            queryUser(1);
        }

        //单次删除用户
        function delUser(id){
            layer.confirm("确定删除该用户？",{icon:3,title:'提示'},
                function(index){
                    $.ajax({
                        type : "post",
                        data : {"id" : id},
                        url : "${APP_PATH}/user/deleteUser.do",
                        beforeSend : function(){
                            return true;
                        },
                        success : function(result){
                            layer.close(index);
                            if(result.success){
                                layer.msg(result.message,{time:1000,icon:6});
                                window.location.href = "${APP_PATH}/user/toUser.do";
                            }else{
                                layer.msg(result.message,{time:1000,icon:5,shift:6});
                            }
                        },
                        error : function(result){
                            layer.close(index);
                            layer.msg(result.message,{time:1000,icon:5,shift:6});
                        }
                    });
                },
                function(index){
                    layer.close(index);
                }
            );
        }

        //批量勾选、未勾选
        $("#allCheckBtn").click(function(){
            //方式一：将attr换成porp
            $("tbody tr td input[type='checkbox']").prop("checked",this.checked);

            //方式二：循环赋值
            /*var status = this.checked
            $.each($("tbody tr td input[type='checkbox']"),function(i,n){
                n.checked = status;
            });*/
        });


        //批量删除用户
        $("#delBatchBtn").click(function(){
            var $checkbtn = $("tbody tr td input:checked");
            //alert($checkbtn.length);

            if($checkbtn.length == 0){
                layer.msg("还未选择需要删除的用户，请先勾选",{time:1500,icon:5,shift:6});
                return false;
            }

            var ids = "";
            $.each($checkbtn,function(i,n){
                //方式一：json传递字符串数组，例如{"id" : ["5","6","7"]}，后台只能通过String类型接收
                /*if(i != 0){
                    ids += ",";
                }
                ids += n.value;*/

                //方式二：传递拼串，例如id=5&id=6&id=7
                if(i != 0){
                    ids += "&";
                }
                ids += "id="+n.value;
            });

            layer.confirm("确定删除这些用户吗？",{icon:3,title:'提示'},
                function(index){
                    $.ajax({
                        type : "post",
                        data : ids,
                        url : "${APP_PATH}/user/deleteBatchUser.do",
                        beforeSend : function(){
                            return true;
                        },
                        success : function(result){
                            layer.close(index);
                            if(result.success){
                                layer.msg(result.message,{time:1000,icon:6},function(){
                                    window.location.href = "${APP_PATH}/user/toUser.do";
                                });
                            }else{
                                layer.msg(result.message,{time:1000,icon:5,shift:6});
                            }
                        },
                        error : function(result){
                            layer.close(index);
                            layer.msg(result.message,{time:1500,icon:5,shift:6});
                        }
                    });
                },
                function(index){
                    layer.close(index);
                }
            );

        });
</script>
</body>
</html>

