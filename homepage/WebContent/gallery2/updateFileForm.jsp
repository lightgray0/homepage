<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String gno = request.getParameter("gno");
	String oldfile = request.getParameter("oldfile");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container" style="color: lightgray;">
		<h2>파일 수정</h2>
		<form class="form-horizontal" method="post"
			action="updateFileProc.jsp" enctype="multipart/form-data" name="frm">
			<input type="hidden" name="gno" value="<%=gno%>"> <input
				type="hidden" name="oldfile" value="oldfilele %>">

			<div class="form-group">
				<label class="control-label col-sm-2" for="oldfile">원본파일</label>
				<div class="col-sm-6">
					<img class="img-rounded" width="200px" height="200px"
						src="./storage/<%=oldfile%>">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="fname">변경파일</label>
				<div class="col-sm-6">
					<input type="file" name="fname" class="form-control"
						required="required" accept=".png,.jpg,.gif">
				</div>
			</div>

			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" class="btn btn-default">수정</button>
				<button type="reset" class="btn btn-default"
					onclick="history.back()">취소</button>
			</div>
		</form>
	</div>
</body>
</html>
