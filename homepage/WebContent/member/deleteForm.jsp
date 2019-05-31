<%@ page contentType="text/html; charset=UTF-8" %> 

<!DOCTYPE html> 
<html> 
<head>
<title>회원탈퇴</title>
<meta charset="utf-8">
<%
	String id = request.getParameter("id");
	String oldfile = request.getParameter("oldfile");
%>
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container" style="color:white;">
	<h2>회원탈퇴</h2><hr>
		<form class="form-horizontal" method="post" action="deleteProc.jsp">
			<input type="hidden" name="id" value="<%=id %>">
			<input type="hidden" name="oldfile" value="<%=oldfile %>">
			
			<div class="form-group">
				<label class="col-sm-offset-2 col-sm-6">
					탈퇴를 하시면 더이상 컨텐트를 제공받을 수 없습니다.<br>
					그래도 탈퇴를 원하시면 아래 탈퇴버튼을 누르세요.
				</label>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-5">
					<button type="submit" class="btn btn-default">탈퇴</button>
					<button type="button" onclick="history.back()" class="btn btn-default">취소</button>
				</div>
			</div>
			
		</form>
	</div>
</body> 
</html> 