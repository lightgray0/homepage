<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp"%>
<jsp:useBean id="dao" class="member.MemberDAO" />
<%
	String name = request.getParameter("mname");
	String email = request.getParameter("email");

	String id = dao.idSearch(name, email);
	if (id == "") {
		out.print("ID가 존재하지 않습니다");
	} else {
		out.print("조회된 ID는 " + id + " 입니다");
	}
%>
