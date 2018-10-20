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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
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
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='form.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                                <tr >
                                    <th width="30">#</th>
                                    <th width="30"><input type="checkbox"></th>
                                    <th>名称</th>
                                    <th width="100">操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td><input type="checkbox"></td>
                                    <td>PM - 项目经理</td>
                                    <td>
                                        <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
                                        <button type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
                                        <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr >
                                    <td colspan="6" align="center">
                                        <ul class="pagination">
                                            <li class="disabled"><a href="#">上一页</a></li>
                                            <li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
                                            <li><a href="#">2</a></li>
                                            <li><a href="#">3</a></li>
                                            <li><a href="#">4</a></li>
                                            <li><a href="#">5</a></li>
                                            <li><a href="#">下一页</a></li>
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

            queryMember(1);
        });

        $("tbody .btn-success").click(function(){
            window.location.href = "assignPermission.html";
        });

        //分页查询用户
        var layerIndex = -1;
        var jsonObj = {
            "pageno" : 1, //当前页数
            "pagesize" : 10 //每页数量
        };
        function queryMember(pageno){
            jsonObj.pageno = pageno;
            $.ajax({
                type : "post",
                data : jsonObj,
                url : "${APP_PATH}/user/querymember.do",
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
</script>
</body>
</html>

