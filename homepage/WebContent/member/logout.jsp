<%@ page contentType="text/html; charset=UTF-8" %> 
<%
	session.invalidate();	// 모든 세션변수 삭제 (세션 객체가 없애는게 아님)
	response.sendRedirect("../index.jsp");	// 세션 객체는 임의로 지울수 없다
%>