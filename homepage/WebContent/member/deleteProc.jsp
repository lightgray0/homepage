<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_member.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
	String id = request.getParameter("id");
	String oldfile = request.getParameter("oldfile");
	String grade = (String)session.getAttribute("grade");
	
	boolean flag = dao.delete(id);
	
	if(flag && !oldfile.equals("member.jpg")){
		UploadSave.deleteFile(upDir, oldfile);
	}
	
	if(flag && !grade.equals("A")){
		session.invalidate();
	}
%>

<!DOCTYPE html> 
<html> 
<head>
<title>회원탈퇴처리</title>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container">
		<div class="well well-lg" style="color:black;">
			<%
				if(flag){
					out.println("회원탈퇴를 성공했습니다. 자동 로그아웃됩니다");
				}else{
					out.println("회원탈퇴를 실패했습니다");
				}
			%>
		</div>
		<!-- root는 ssi에서 webtest의경로를 잡아준다 -->
		<button class="btn btn-default" onclick="location.href='<%=root%>/index.jsp'">홈</button>
		<%
			if(!flag){
		%>
			<button class="btn btn-default" onclick="history.back()">다시시도</button>
		<%
			}
		%>
	</div>
</body> 
</html> 