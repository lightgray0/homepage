<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_member.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<%
	UploadSave upload = new UploadSave(request,-1,-1,tempDir);
	
	String id = UploadSave.encode(upload.getParameter("id"));
	String email = UploadSave.encode(upload.getParameter("email"));
	
	String str = "";
	if(dao.duplicateId(id)){
		str = "중복된 아이디, ID중복확인이 필요합니다.";
	} else if(dao.duplicateEmail(email)){
		str = "중복된 이메일, email중복확인이 필요합니다.";
	} else{
		// id와 email이 중복이 없다면
		// createProc.jsp으로 이동해서 db에 회원정보를 저장한다.
		// upload도 같이 넘겨준다
		request.setAttribute("upload", upload);
		%>
		<jsp:forward page="/member/createProc.jsp"/>
		<%
		return;
	}		
	%>
<!DOCTYPE html> 
<html> 
<head>
<meta charset="utf-8">
<title>ID 및 Email 중복확인</title>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container" style="color:lightgray">
		<div class="well well-lg">
		<br>
		<%=str %>
		</div>
		<button type="button" class="btn btn-default" onclick="history.back()">다시시도</button>
	</div>
</body> 
</html> 