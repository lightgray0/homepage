<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_member.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("passwd");
	
	Map map = new HashMap();
	map.put("id",id);
	map.put("pw",pw);
	
	boolean flag = dao.updatePw(map);
%>
<!DOCTYPE html> 
<html> 
<head>
<title>비밀번호 변경 처리</title>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container">
		<div class="well well-lg" style="color:black;">
			<%
				if(flag)
					out.print("비밀번호 변경을 성공했습니다");
				else
					out.print("비밀번호 변경을 실패했습니다");
			%>
		</div>
		<button class="btn btn-default" onclick="location.href='loginForm.jsp'">로그인</button>
		<button class="btn btn-default"
			onclick="history.back()">다시시도</button>
	</div>
</body> 
</html> 