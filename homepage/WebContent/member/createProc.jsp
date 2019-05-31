<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp"%>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<jsp:useBean id="dto" class="member.MemberDTO"></jsp:useBean>
<%

	// ★★★forward로 받아왔기 때문에 request 객체가 살아있어서 참조 가능하다.
	// 리턴형이 오브젝트형이므로 UploadSave로 다운 캐스팅이 요구됨
	UploadSave upload = (UploadSave) request.getAttribute("upload");
	// request객체에서 받아온 upload 객체에서 dto에 세팅함
	dto.setId(upload.getParameter("id"));
	dto.setEmail(upload.getParameter("email"));
	dto.setPasswd(upload.getParameter("passwd"));
	dto.setTel(upload.getParameter("tel"));
	dto.setZibcode(upload.getParameter("zibcode"));
	dto.setMname(UploadSave.encode(upload.getParameter("mname")));
	dto.setJob(UploadSave.encode(upload.getParameter("job")));
	dto.setAddress1(UploadSave.encode(upload.getParameter("address1")));
	dto.setAddress2(UploadSave.encode(upload.getParameter("address2")));
	
	FileItem fileItem = upload.getFileItem("fname");

	int size = (int)fileItem.getSize();

	String fname = UploadSave.saveFile(fileItem, upDir);

	if (size > 0)
		dto.setFname(fname);
	else
		dto.setFname("member.jpg");

	boolean flag = dao.create(dto);
%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입처리</title>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container">
		<div class="well well-lg" style="color:black;">
			<%
				if (flag) {
					out.print("회원가입을 했습니다");
				} else {
					out.print("회원가입을 실패했습니다");
				}
			%>
		</div>
		<%
			if (flag) {
		%>
		<input class='btn btn-default' type='button' value='로그인'
			onclick="location.href='loginForm.jsp'"> <input class='btn btn-default' type='button'
			value='홈' onclick="location.href='../index.jsp'">
		<%
			} else {
		%>
		<input class='btn btn-default' type='button' value='다시시도' onclick="history.back()"> <input
			type='button' value='홈' onclick="location.href='../index.jsp'">
		<%
			}
		%>
	</div>
</body>
</html>
