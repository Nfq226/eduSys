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
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 专业管理 <span class="c-gray en">&gt;</span> 专业列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        &nbsp;<button onclick="removeIframe()" class="btn btn-primary radius">关闭选项卡</button>
        <span class="l">
            <a href="javascript:;" onclick="datadel()" class="btn btn-danger radius">
                <i class="Hui-iconfont">&#xe6e2;</i>
                批量删除
            </a>
            <a class="btn btn-primary radius" data-title="添加学院" data-href="${path}/college/toAddCollege" onclick="Hui_admin_tab(this)" href="javascript:;">
                <i class="Hui-iconfont">&#xe600;</i> 添加专业
            </a>
        </span>
    </div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort table-responsive">
            <thead>
            <tr class="text-c">
                <th width="25"><input type="checkbox" name="" ></th>
                <th width="80">ID</th>
                <th width="120">专业名称</th>
                <th width="120">专业所属学院编号</th>
                <th width="60">专业状态</th>
                <th width="60">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${majorList}" var="major">
                <tr class="text-c">
                    <td><input type="checkbox" value="${major.major_no}" name="colcheck"></td>
                    <td>${major.major_no}</td>
                    <td>${major.major_name}</td>
                    <td>${major.college_no}</td>
                    <td class="td-status">
                        <c:if test="${major.major_status==1}">
                            <span class="label label-success radius">正常</span>
                        </c:if>
                        <c:if test="${major.major_status==0}">
                            <span class="label label-default radius">关闭</span>
                        </c:if>
                    </td>
                    <td class="f-14 td-manage">
                        <c:if test="${major.major_status==1}">
                            <a style="text-decoration:none" onClick="major_stop(this,'${major.major_no}')" href="javascript:;" title="关闭">
                                <i class="Hui-iconfont">&#xe6de;</i>
                            </a>
                        </c:if>
                        <c:if test="${major.major_status==0}">
                            <a style="text-decoration:none" onClick="major_start(this,'${major.major_no}')" href="javascript:;" title="运行">
                                <i class="Hui-iconfont">&#xe603;</i>
                            </a>
                        </c:if>

                        <a style="text-decoration:none" class="ml-5" href="javascript:;" onclick="getOneMajor(${major.major_no})" data-toggle="modal" data-target="#myModal" title="编辑">
                            <i class="Hui-iconfont">&#xe6df;</i>
                        </a>
                        <a style="text-decoration:none" class="ml-5" onClick="major_del(this,'${major.major_no}')" href="javascript:;" title="删除">
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
                            更新专业
                        </h4>
                    </div>
                    <div class="modal-body">
                        <input type="text" class="input-text radius" name="major_no" id="major_no_up" hidden="hidden">
                        专业名称:<input type="text" class="input-text radius" name="major_name" id="major_name_up" placeholder="请输入专业名称">
                        <br>专业所属学院:<input type="text" class="input-text radius" name="college_no" id="college_no_up" placeholder="请选择学院">
                        <br><div class="dropdown">请选择专业状态:
                        <select class="btn" name="major_status" id="major_status_up" role="menu" aria-labelledby="dropdownMenu1">
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
            {"orderable":false,"aTargets":[0,5]}// 不参与排序的列
        ]
    });


    /*学院-删除*/
    function major_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            $.ajax({
                type: 'POST',
                url: '${path}/major/delById',
                data:{"major_no":id},
                dataType: 'text',
                success: function(data){
                    $(obj).parents("tr").remove();
                    layer.msg('已删除!',{icon:1,time:4000});
                },
                error:function(data) {
                    layer.msg('删除失败!',{icon:5,time:4000});
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
                url: '${path}/major/delByIds',
                data:{Ids:colIds},
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


    /*专业-关闭*/
    function major_stop(obj,id){
        layer.confirm('确认要关闭吗？',function(index){
            $.ajax({
                type: 'POST',
                url: '${path}/major/updateStatus',
                data:{"major_no":id,"status":0},
                dataType:"text",
                success: function(data){
                    $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="major_start(this,'+data+')" href="javascript:;" title="运行"><i class="Hui-iconfont">&#xe603;</i></a>');
                    $(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">关闭</span>');
                    $(obj).remove();
                    $(obj).parents("tr").remove();
                    layer.msg('已关闭!',{icon:5,time:1000});
                },
                error:function(data) {
                    layer.msg('失败啦!',{icon: 5,time:1000});
                    console.log(data.msg);
                },
            });
        });
    }

    /*专业运行*/
    function major_start(obj,id){
        layer.confirm('确认要运行该专业吗？',function(index){
            $.ajax({
                type: 'POST',
                url: '${path}/major/updateStatus',
                data:{"major_no":id,"status":1},
                dataType:"text",
                success: function(data){
                    $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="major_stop(this,'+data+')" href="javascript:;" title="关闭"><i class="Hui-iconfont">&#xe6de;</i></a>');
                    $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">正常</span>');
                    $(obj).remove();
                    $(obj).parents("tr").remove();
                    layer.msg('已运行该专业!',{icon: 6,time:1000});
                },
                error:function(data) {
                    layer.msg('失败啦!',{icon: 5,time:1000});
                    console.log(data.msg);
                },
            });
        });
    }
    /*获取一个专业信息*/
    function getOneMajor(id) {
        $.ajax({
            type: 'POST',
            url: '${path}/major/getOneMajor',
            data:{"major_no":id},
            dataType:"json",
            success: function(data){
                $('#major_no_up').val(data.major_no);
                $('#major_name_up').val(data.major_name);
                $('#college_no_up').val(data.college_no);
                if (data.major_status==1){
                    $('#major_status_up').val("1");
                }else{
                    $('#major_status_up').val("0");
                }
            },
            error:function(data) {
                layer.msg('失败!',{icon: 5,time:1000});
                console.log(data.msg);
            },
        });
    }

    <!--更新专业-->
    function doUpdate() {
        layer.confirm('确认要这样更新吗？',function(index){
            var params = $('#form-update').serialize();
            $.ajax({
                type: 'POST',
                url: '${path}/major/doUpdate',
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