<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_member.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<jsp:useBean id="dto" class="member.MemberDTO"></jsp:useBean>
<jsp:setProperty name="dto" property="*"/>
<%
boolean flag=dao.update(dto);
%>
<!DOCTYPE html> 
<html> 
<head>
<title>회원수정처리</title>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container">
		<div class="well well-lg" style="color:black;">
			<%
				if (flag) {
					out.print("회원수정을 성공했습니다");
				} else {
					out.print("회원수정을 실패했습니다");
				}
			%>
		</div>
		<button class="btn btn-default"
			onclick="location.href='read.jsp?id=<%=dto.getId()%>'">회원정보</button>
		<button class="btn btn-default" onclick="history.back()">다시시도</button>
	</div>
</body> 
</html> 