<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String ctx = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
	var ctx = "${pageContext.request.contextPath}"
</script>
<script src="<%=ctx%>/admin/pages/education/material/add.js" type="text/javascript"></script>
<title>添加课程信息</title>
</head>
<body>
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i>首页</a></li>
		<li><a href="#">教务教学</a></li>
		<li class="active">添加教材</li>
	</ol>
	</section>

	<!-- Main content -->
	<section class="content">
	<div class="row">
		<div class="col-xs-12">

			<div id="myTabContent" class="tab-content ">
				<div id="info" class="tab-pane fade in active">
					<form role="form" class="form-horizontal">
						<input type="hidden" name="form.mtlId" id="form.mtlId" /> <input
							type="hidden" name="form.createTime" id="form.createTime" /> <input
							type="hidden" name="form.creator" id="form.creator" /> <input
							type="hidden" name="form.updateTime" id="form.updateTime" /> <input
							type="hidden" name="form.updator" id="form.updator" />
							<input
							type="hidden" name="form.mtlRemain" id="form.mtlRemain" />
								<input
							type="hidden" name="form.mtlSaled" id="form.mtlSaled" />
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">
									<i class='fa fa-github'></i> 教材信息
								</h3>
							</div>
							<div class="box-body">
								<div class="col-sm-12">

									<div class="form-group">
										<label class="col-sm-2 control-label">教材名称：</label>
										<div class="col-sm-10">
											<input name="form.mtlName" id="form.mtlName" type="text"
												class="form-control" placeholder="教材名称">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">教材价格：</label>
										<div class="col-sm-10">
											<input name="form.mtlPrice" id="form.mtlPrice" type="text"
												class="form-control" placeholder="教材价格">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label">教材数量：</label>
										<div class="col-sm-10">
											<input name="form.mtlVolume" id="form.mtlVolume" type="text"
												class="form-control" placeholder="教材数量">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-2 control-label"><i
											class="fa fa-mobile-phone"></i> 对应课程：</label>
										<div class="col-sm-10">
											<select  class="form-control" id="form.coId" name="form.coId">
												
											</select>

										</div>
									</div>
									
								</div>
							</div>
						</div>
					</form>

					<div class="col-xs-12">
						<div class="col-xs-4 col-xs-offset-4" style="height: 155px;">
							<button type="button" onclick="$.page.config.fnSave();"
								class="btn btn-primary  btn-lg btn-block">保&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;存</button>
						</div>
					</div>
				</div>

			</div>
		</div>


	</div>
	</section>
</body>
</html>