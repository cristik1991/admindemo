<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<title>目的地修改</title>
<head>
	<jsp:include page="../main/resource.jsp"/>
	<script>
		function updateDestination(){
			$.ajax({
				type:"post",
				url:"${base}/destination/updatedestination",
				data:$("#form").serializeObject(),
				dataType: "json",
				success:function(data){
					if(data.success){
						window.location.href="${base}/destination/list";
					}else{
						alert(data.msg);
					}
				}
			})
		}

		$(function(){
			$("#user-image-file").fileinput({
				uploadUrl: "${base}/image/save",
				deleteUrl: "${base}/image/delete",
				showPreview: true,
				dropZoneEnabled:false,
				allowedFileExtensions: ["jpg", "png", "gif"],
				maxImageWidth: 200,
				maxImageHeight:100,
				maxFileCount: 1,
				resizeImage: true,
				initialPreview:[
					<c:if test="${subject.subjectImg!=null and subject.subjectImg!=''}">
						<c:forTokens items="${subject.subjectImg}" delims="#" var="i" varStatus="vs">
							"<img src='${base}/image/view/${i}' class='file-preview-image'>"
							<c:if test="${!vs.last}">,</c:if>
						</c:forTokens>
					</c:if>

				],
				initialPreviewConfig: [
					<c:if test="${subject.subjectImg!=null and subject.subjectImg!=''}">
						<c:forTokens items="${subject.subjectImg}" delims="#" var="i" varStatus="vs">
							{
								url: '${base}/image/delete',
								frameAttr: {
									style: 'height:80px',
									title: 'My Custom Title',
								}
							}
							<c:if test="${!vs.last}">,</c:if>
						</c:forTokens>
					</c:if>

				]
			}).on('filepreupload', function(event, data, id, index) {
			}).on('fileuploaded', function(event, data, id, index) {
				var obj = data.response;
				if(obj.success){
					var ids = $("#user-image").val();
					if(ids!=""){
						ids+="#"+obj.data.result;
					}else{
						ids = obj.data.result;
					}
					$("#user-image").val(ids);
				}
			});
		})


	</script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
	<%--头部--%>
	<jsp:include page="../main/header.jsp"/>
	<%--导航栏--%>
	<jsp:include page="../main/navigation.jsp"/>
	<%--主体部分--%>
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<section class="content-header">
			<h1>目的地详情</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i>主菜单</a></li>
				<li class="active">目的地详情</li>
			</ol>
		</section>

		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box box-primary ">
						<div class="box-header with-border"></div>
						<c:choose>
							<c:when test="${destinationMVO!=null}">
								<form id="form" class="form-horizontal">
									<div class="box-body">
										<div class="col-md-12 col-md-offset-3">
											<input type="hidden" name="id" value="${destinationMVO.id}"/>
											<div class="form-group">
												<label class="col-md-1 control-label">目的地</label>
												<div class="col-md-3">
													<input type="text" name="destinationName" value="${destinationMVO.destinationName}" class="form-control" />
												</div>
											</div>

											<div class="form-group">
												<label class="col-md-1 control-label">所属洲</label>
												<div class="col-md-3">
													<select id="state-id" name="stateId" class="form-control">
														<c:forEach items="${states}" var="state" varStatus="status">
															<option value="${state.id}" <c:if test="${state.id eq destinationMVO.stateId}">selected="selected"</c:if> >${state.areaName}</option>
														</c:forEach>
													</select>
												</div>
											</div>

											<div class="form-group">
												<label class="col-md-1 control-label">所属国家</label>
												<div class="col-md-3">
													<input type="text" id="country-name" value="${destinationMVO.country}" class="form-control" />
													<input type="hidden" id="country-id" name="countryId" value="${destinationMVO.countryId}"/>
												</div>
											</div>

										</div>
									</div>
								</form>
							</c:when>
							<c:otherwise>
								<div class="box-body">
									<div class="callout callout-info">
										<p>无数据</p>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
						<div class="box-footer">
							<div class="form-group col-md-offset-5">
								<button type="submit" class="btn btn-info" onclick="updateDestination()">修改</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<jsp:include page="../main/footer.jsp"/>
	<jsp:include page="../main/control-sidebar.jsp"/>
</div>
<script src="${base}/static/adminlte-2.3.0/dist/js/demo.js"></script>
<script src="${base}/static/adminlte-2.3.0/dist/js/app.min.js"></script>
</body>
</html>

