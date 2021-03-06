<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String ctx = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="<%=ctx%>/admin/pages/business/consult/view.js" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<!-- Head Css -->
</head>
<body>
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i>首页</a></li>
		<li><a href="#">前台业务</a></li>
		<li class="active">添加咨询</li>
	</ol>
	</section>

	<!-- Main content -->

	<section class="content">
	<form role="form" class="form-horizontal">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">资询详细信息</h3>
			</div>
			<div class="panel-body" style="height: 255px;">
				<div class="row">
					<div class="col-xs-12">
						<div class="box box-primary">
							<div class="box-body">
								<div class="col-sm-12">
									<div class="col-sm-4">
										<div class="form-group">
											<label class="col-sm-4 control-label">咨询者名：</label>
											<div class="col-sm-8">
												<input name="form.adName" id="form.adName" type="text"
													class="form-control" disabled>
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<label class="col-sm-4 control-label">资询者性别：</label>
											<div class="col-sm-8">
												<select class="form-control" name="form.adSex"
													id="form.stSex" disabled>
													<option value="0">男</option>
													<option value="1">女</option>

												</select>
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<label class="col-sm-4 control-label">资询者电话：</label>
											<div class="col-sm-8">
												<input name="form.adPhone" id="form.adPhone" type="text"
													class="form-control" disabled>
											</div>
										</div>
									</div>

									<div class="col-sm-4">
										<div class="form-group">
											<label class="col-sm-4 control-label">资询者邮箱：</label>
											<div class="col-sm-8">
												<input name="form.adEmial" id="form.adEmial" type="text"
													class="form-control" disabled>
											</div>
										</div>
									</div>

									<div class="col-sm-4">
										<div class="form-group">
											<label class="col-sm-4 control-label">居住区域：</label>
											<div class="col-sm-8">
												<input name="form.adAddress" id="form.adAddress" type="text"
													class="form-control" disabled>
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<label class="col-sm-4 control-label">兴趣爱好：</label>
											<div class="col-sm-8">
												<input name="form.adHobbies" id="form.adHobbies" type="text"
													class="form-control" disabled>
											</div>
										</div>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<label class="col-sm-4 control-label">备注信息：</label>
											<div class="col-sm-8">
												<input name="form.adRemark" id="form.adRemark" type="text"
													class="form-control" disabled>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>

				</div>
			</div>
		</div>
		<div class="panel panel-primary">
			<div class="panel-body">
				<div class="col-sm-12">
					<div class="form-group">
						<label class="col-sm-2 control-label">咨询方式：</label>
						<div class="col-sm-10">
							<select class="form-control" name="form.adWays" id="form.adWays"
								disabled>
								<option value="0">来访</option>
								<option value="1">来电</option>
								<option value="2">网络</option>
								<option value="3">其他</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">咨询课程：</label>
						<div class="col-sm-6">
							<input class="form-control" name="form.coursename"
								id="form.coursename" disabled>						
						</div>
						<div class="col-sm-4"></div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">咨询内容：</label>
						<div class="col-sm-6">
							<input name="form.adContent" id="form.adContent"
								style="height: 155px;" class="form-control" disabled>
						</div>
						<div class="col-sm-4"></div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">学习意向：</label>

						<div class="col-sm-6">
							<select
								class="form-control" name="form.adIntention"
								id="form.adIntention" disabled>
								<option value="0">一般</option>
								<option value="1">中等</option>
								<option value="2">强烈</option>
							</select>
						</div>
						<div class="col-sm-4"></div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">标记：</label>
						<div class="col-sm-6">
							<span name="form.adRemarks" id="form.adRemarks" type="text"
								class="form-control"></span>
						</div>
						<div class="col-sm-4"></div>
					</div>
				</div>
			</div>
		</div>

		<!-- <div class="col-xs-12">
			<div class="col-xs-4 col-xs-offset-4" style="height: 155px;">
				<button type="button" onclick="$.page.config.finish();"
					class="btn btn-primary  btn-lg btn-block">保存</button>
			</div>
		</div> -->
	</form>
	</section>

</body>
</html>