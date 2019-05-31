<%@ page contentType="text/html; charset=UTF-8" %> 
<%
	String id = request.getParameter("id");
	String oldfile = request.getParameter("oldfile");
%>

<!DOCTYPE html> 
<html> 
<head>
<title>사진수정</title>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container" style="color:white;">
	<h2>사진수정</h2><hr>
		<form class="form-horizontal" method="post" action="updateFileProc.jsp"
				enctype="multipart/form-data">
			<input type="hidden" name="id" value="<%=id %>">
			<input type="hidden" name="oldfile" value="<%=oldfile %>">
			<div class="form-group">
				<label class="control-label col-sm-2" for="oldfile">원본파일</label>
				<div class="col-sm-6">
					<img class="img-rounded" width="200px" height="200px" src="./storage/<%=oldfile%>">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="fname">변경파일</label>
				<div class="col-sm-6">
				<input type="file" name="fname" class="form-control" required="required"
						accept=".png,.jpg,.gif">
				</div>
			</div>
			
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default">수정</button>
					<button type="button" class="btn btn-default"
							onclick="history.back()">취소</button>
				</div>
			</div>
		</form>
	</div>
</body> 
</html> 