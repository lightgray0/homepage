<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_gallery.jsp" %>

<!DOCTYPE html> 
<html> 
<head>
<title>갤러리 작품 삭제</title>
<meta charset="utf-8">
<style type="text/css">
#red {
	color: red;
}
</style>
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container" style="color:white;">
	<h2>갤러리 작품 삭제</h2><hr>
		<form class="form-horizontal" method="post" action="deleteProc.jsp">
		<input type="hidden" name="gno" value="<%=request.getParameter("gno") %>">
		<input type="hidden" name="col" value="<%=request.getParameter("col") %>">
		<input type="hidden" name="word" value="<%=request.getParameter("word") %>">
		<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage") %>">
		<input type="hidden" name="oldfile" value="<%=request.getParameter("oldfile") %>">
			<div class="form-group">
				<label class="control-label col-sm-2" for="passwd">비밀번호</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="passwd" name="passwd" />
				</div>
			</div>
			<p id="red" class="col-sm-offset-2 col-sm-6">삭제하면 복구할 수 없습니다.</p>>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button class="btn btn-default">삭제</button>
					<button type="reset" class="btn btn-default">취소</button>
					<button type="button" class="btn btn-default" onclick="location.href='./list.jsp'">목록</button>
				</div>
			</div>
			
		</form>
	</div>
</body> 
</html> 