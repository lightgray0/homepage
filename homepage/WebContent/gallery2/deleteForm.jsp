<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_gallery.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style type="text/css">
</style>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container" style="color: lightgray;">
		<h2>삭제</h2>
		<form class="form-horizontal" method="post" action="deleteProc.jsp">
			<input type="hidden" name="gno"
				value="<%=request.getParameter("gno")%>">
			<div class="form-group">
				<label class="control-label col-sm-2" for="passwd">비밀번호</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="passwd"
						name="passwd" />
				</div>
				<div class="col-sm-offset-2 col-sm-10">
					<button class="btn btn-default">삭제</button>
					<button type="button" class="btn btn-default"
						onclick="location.href='./list.jsp'">목록</button>
				</div>
			</div>

		</form>
	</div>
</body>
</html>
