﻿<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 获取应用的路径  并给与path变量 -->
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link rel="stylesheet" type="text/css" href="${path}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${path}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${path}/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${path}/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="${path}/static/h-ui.admin/css/style.css" />

    <title>资讯列表</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 学院管理 <span class="c-gray en">&gt;</span> 学院列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        &nbsp;<button onclick="removeIframe()" class="btn btn-primary radius">关闭选项卡</button>
        <span class="l">
            <a href="javascript:;" onclick="datadel()" class="btn btn-danger radius">
                <i class="Hui-iconfont">&#xe6e2;</i>
                批量删除
            </a>
            <a class="btn btn-primary radius" data-title="添加学院" data-href="${path}/college/toAddCollege" onclick="Hui_admin_tab(this)" href="javascript:;">
                <i class="Hui-iconfont">&#xe600;</i> 添加学院
            </a>
        </span>
    </div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort table-responsive">
            <thead>
            <tr class="text-c">
                <th width="25"><input type="checkbox" name="" ></th>
                <th width="80">ID</th>
                <th width="120">学院名称</th>
                <th width="100">学院开设人数</th>
                <th width="100">学院实际人数</th>
                <th width="120">学院专业数目</th>
                <th width="60">学院状态</th>
                <th width="60">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${collegeList}" var="colg">
                <tr class="text-c">
                    <td><input type="checkbox" value="${colg.college_no}" name="colcheck"></td>
                    <td>${colg.college_no}</td>
                    <td>${colg.college_name}</td>
                    <td>${colg.setting_quota}</td>
                    <td>${colg.current_quota}</td>
                    <td>${colg.major_int}</td>
                    <td class="td-status">
                        <c:if test="${colg.college_status==1}">
                            <span class="label label-success radius">正常</span>
                        </c:if>
                        <c:if test="${colg.college_status==0}">
                            <span class="label label-default radius">关闭</span>
                        </c:if>
                    </td>
                    <td class="f-14 td-manage">
                        <c:if test="${colg.college_status==1}">
                            <a style="text-decoration:none" onClick="college_stop(this,'${colg.college_no}')" href="javascript:;" title="关闭">
                                <i class="Hui-iconfont">&#xe6de;</i>
                            </a>
                        </c:if>
                        <c:if test="${colg.college_status==0}">
                            <a style="text-decoration:none" onClick="college_start(this,'${colg.college_no}')" href="javascript:;" title="运行">
                                <i class="Hui-iconfont">&#xe603;</i>
                            </a>
                        </c:if>

                        <a style="text-decoration:none" class="ml-5" href="javascript:;" onclick="getOneCol(${colg.college_no})" data-toggle="modal" data-target="#myModal" title="编辑">
                            <i class="Hui-iconfont">&#xe6df;</i>
                        </a>
                        <a style="text-decoration:none" class="ml-5" onClick="college_del(this,'${colg.college_no}')" href="javascript:" title="删除">
                            <i class="Hui-iconfont">&#xe6e2;</i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form id="form-update">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>
                        <h4 class="modal-title" id="myModalLabel">
                            更新学院
                        </h4>
                    </div>
                    <div class="modal-body">
                        <input type="text" class="input-text radius" name="college_no" id="college_no_up" hidden="hidden">
                        学院名称:<input type="text" class="input-text radius" name="college_name" id="college_name_up" placeholder="请输入学院名称">
                        <br>学院开设人数:<input type="text" class="input-text radius" name="setting_quota" id="setting_quota_up" placeholder="请输入开设人数">
                        <br>学院目前人数:<input type="text" class="input-text radius" name="current_quota" id="current_quota_up" placeholder="请输入实际人数">
                        <br>学院专业数目:<input type="text" class="input-text radius" name="major_int" id="major_int_up" placeholder="请输入专业数目">
                        <br><div class="dropdown">请选择学院状态:
                        <select class="btn" name="college_status" id="college_status_up" role="menu" aria-labelledby="dropdownMenu1">
                            <option role="presentation" value="0" >
                                关闭
                            </option>
                            <option role="presentation" selected="selected" value="1">
                                正常
                            </option>
                        </select>
                    </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                        </button>
                        <button type="button" onclick="doUpdate()" class="btn btn-primary">
                            提交更改
                        </button>
                    </div>
                </div>
            </form><!-- /.modal-content -->
        </div><!-- /.modal -->

    </div>
</div>
<script type="text/javascript" src="${path}/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${path}/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${path}/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<script type="text/javascript" src="${path}/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="${path}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${path}/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
    $('.table-sort').dataTable({
        "aaSorting": [[ 1, "desc" ]],//默认第几个排序
        "bStateSave": true,//状态保存
        "pading":false,
        "aoColumnDefs": [
            //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
            {"orderable":false,"aTargets":[0,7]}// 不参与排序的列
        ]
    });

    /*学院添加*/
    function article_add(title,url,w,h){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*学院更新*/
    function college_edit(title,id){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*学院-删除*/
    function college_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            $.ajax({
                type: 'POST',
                url: '${path}/college/delByColId',
                data:{"college_no":id},
                dataType: 'text',
                success: function(data){
                    $(obj).parents("tr").remove();
                    layer.msg('已删除!',{icon:1,time:1000});
                },
                error:function(data) {
                    alert("失败啦");
                    console.log(data.msg);
                },
            });
        });
    }

    <!--批量删除-->
    function datadel() {
        layer.confirm('确认要删除吗？',function(index){
            var colIds = [];
            $("input:checkbox[name = colcheck]:checked").each(function(i){
                //使用循环遍历迭代的方式得到所有被选中的checkbox复选框
                console.log($(this).val());
                colIds.push( $(this).val() ); //当前被选中checkbox背后对应的值
            });
            $.ajax({
                traditional: true,
                type: 'POST',
                url: '${path}/college/delByIds',
                data:{colIds:colIds},
                dataType:"text",
                success: function(data){
                    $("input:checkbox[name = colcheck]:checked").each(function(i){
                        $(this).parents("tr").remove();
                    });
                    layer.msg('已删除!',{icon:1,time:6000});

                },
                error:function(data) {
                    layer.msg('未选择!',{icon:5,time:2000});
                    console.log(data.msg);
                },
            });
        });
    }


    /*学院-关闭*/
    function college_stop(obj,id){
        layer.confirm('确认要关闭吗？',function(index){

            $.ajax({
                type: 'POST',
                url: '${path}/college/updateStatus',
                data:{"college_no":id,"status":0},
                dataType:"text",
                success: function(data){
                    $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="college_start(this,'+data+')" href="javascript:;" title="运行"><i class="Hui-iconfont">&#xe603;</i></a>');
                    $(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">关闭</span>');
                    $(obj).remove();
                    $(obj).parents("tr").remove();
                    layer.msg('已关闭!',{icon:5,time:1000});
                },
                error:function(data) {
                    alert("失败啦");
                    console.log(data.msg);
                },
            });
        });
    }

    /*学院运行*/
    function college_start(obj,id){
        layer.confirm('确认要运行该学院吗？',function(index){
            $.ajax({
                type: 'POST',
                url: '${path}/college/updateStatus',
                data:{"college_no":id,"status":1},
                dataType:"text",
                success: function(data){
                    $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="college_stop(this,'+data+')" href="javascript:;" title="关闭"><i class="Hui-iconfont">&#xe6de;</i></a>');
                    $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">正常</span>');
                    $(obj).remove();
                    $(obj).parents("tr").remove();
                    layer.msg('已运行该学院!',{icon: 6,time:1000});
                },
                error:function(data) {
                    alert("失败啦");
                    console.log(data.msg);
                },
            });
        });
    }
    /*获取一个学院信息*/
    function getOneCol(id) {
        $.ajax({
            type: 'POST',
            url: '${path}/college/getOneCol',
            data:{"college_no":id},
            dataType:"json",
            success: function(data){
                $('#college_no_up').val(data.college_no);
                $('#college_name_up').val(data.college_name);
                $('#setting_quota_up').val(data.setting_quota);
                $('#current_quota_up').val(data.current_quota);
                $('#major_int_up').val(data.major_int);
                if (data.college_status==1){
                    $('#college_status_up').val("1");
                }else{
                    $('#college_status_up').val("0");
                }
            },
            error:function(data) {
                layer.msg('失败!',{icon: 5,time:1000});
                console.log(data.msg);
            },
        });
    }

    <!--更新学院-->
    function doUpdate() {
        layer.confirm('确认要这样更新吗？',function(index){
            var params = $('#form-update').serialize();
            $.ajax({
                type: 'POST',
                url: '${path}/college/doUpdate',
                data: params,
                dataType:"text",
                success: function(data){
                    location.replace(location.href);
                },
                error:function(data) {
                    layer.msg('更新失败!',{icon: 5,time:5000});
                    console.log(data.msg);
                },
            });
        });
    }
</script>
</body>
</html>