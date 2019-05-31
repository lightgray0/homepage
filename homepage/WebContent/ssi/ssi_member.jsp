<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="utility.*" %>
<%@ page import="member.MemberDAO"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%
	request.setCharacterEncoding("utf-8");
	// 현재 webtest의 경로를 반환해주는 메소드
	String root = request.getContextPath();
	String upDir = "/member/storage";
	String tempDir = "/member/temp";

	upDir = application.getRealPath(upDir);
	tempDir = application.getRealPath(tempDir);
	
%>
