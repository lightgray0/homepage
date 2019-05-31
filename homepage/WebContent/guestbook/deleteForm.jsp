<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
</head>
<body>
<jsp:include page="/menu/top.jsp"/>
	<div class="container">
		<form method="post" action="deleteProc.jsp">
			<input type="hidden" name="no" value="<%=request.getParameter("no")%>"/>
			<h2>삭제 확인</h2><hr>
			<div class="jumbotron" style="color:black;">
				<br/>
				<p>
					삭제를 하면 복구 될 수 없습니다.<br/><br/>
					삭제하시려면 삭제버튼을 클릭하세요<br/><br/>
					취소는 '목록'버튼을 누르세요
					<br><br>
				</p>
			<input type="password" class="form-control" id="passwd"
						placeholder="Enter password" name="passwd">
			</div>
			<button type="submit" class="btn btn-default">삭제</button>
			<button type="button" class="btn btn-default" onclick="location.href='./list.jsp';">목록</button>
		</form>
	</div>
</body>
</html>