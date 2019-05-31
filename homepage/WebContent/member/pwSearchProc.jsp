<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp"%>
<jsp:useBean id="dao" class="member.MemberDAO" />
<%
	String id = request.getParameter("id");
	String name = request.getParameter("mname");

	String passwd = dao.pwSearch(id, name);
	if (passwd == "") {
		out.print("해당 ID와 일치하는 패스워드가 존재하지 않습니다");
	} else {
		out.print("조회된 패스워드는 " + passwd + " 입니다");
	}
%>