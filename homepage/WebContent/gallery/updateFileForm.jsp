<%@ page contentType="text/html; charset=UTF-8" %> 
<%
	String gno = request.getParameter("gno");
	String oldfile = request.getParameter("oldfile");
	
	//out.println(request.getParameter("col"));
	//out.println(request.getParameter("word"));
	//out.println(request.getParameter("nowPage"));
%>

<!DOCTYPE html> 
<html> 
<head>
<title>갤러리 작품 파일 수정</title>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container" style="color:white;">
	<h2>갤러리 작품 파일 수정</h2><hr>
		<form class="form-horizontal" method="post" action="updateFileProc.jsp" enctype="multipart/form-data" name="frm">
			<input type="hidden" name="gno" value="<%=gno %>">
			<input type="hidden" name="oldfile" value="<%=oldfile %>">
			
			<input type="hidden" name="col" value="<%=request.getParameter("col")%>">
			<input type="hidden" name="word" value="<%=request.getParameter("word")%>">
			<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">
			
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
					<button type="reset" class="btn btn-default" onclick="history.back()">취소</button>
				</div>
			</div>
			
		</form>
	</div>
</body> 
</html> 