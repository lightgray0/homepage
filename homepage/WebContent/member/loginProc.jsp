<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_member.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	Map map = new HashMap();
	map.put("id",id);
	map.put("pw",passwd);
	
	boolean flag = dao.loginCheck(map);
	String grade = null; // 회원 등급을 저장할 변수, 회원인 경우에만 받아옴
	
	if(flag){
		grade = dao.getGrade(id);
		session.setAttribute("id", id);
		session.setAttribute("grade", grade);
	}
	
	// ---------------------------------------------- 
    // Cookie 저장, Checkbox는 선택하지 않으면 null 임 
	Cookie cookie = null;
	
	String c_id = request.getParameter("c_id"); // Y, 아이디 저장 여부
	
	if(c_id!=null){	// 처음에는 값이 없으므로 null 체크로 처리
		cookie = new Cookie("c_id","Y"); // 아이디 저장 여부 쿠키
		cookie.setMaxAge(120);			// 2분간 유지
		response.addCookie(cookie);		// 쿠키 기록, 클라이언트에 저장함
		
		cookie = new Cookie("c_id_val", id); // 아이디 값 저장 쿠키
		cookie.setMaxAge(120);		
		response.addCookie(cookie);
	} else{		// 쿠키 삭제
		cookie = new Cookie("c_id","");	
		cookie.setMaxAge(0);
		response.addCookie(cookie);
		
		cookie = new Cookie("c_id_val","");
		cookie.setMaxAge(0);
		response.addCookie(cookie);
	}
    // --------------------------------------------- 
%>
<!DOCTYPE html> 
<html> 
<head>
<title>로그인처리</title>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container">
	<div class="well well-lg" style="color:black;">
	<%
		if(flag){
			out.print("로그인 되었습니다");
		}else{
			out.print("잘못된 아이디 또는 비밀번호입니다<br>");
			out.print("회원가입이 필요합니다.");
		}
	%>
	</div>
	<button class="btn btn-default" onclick="location.href='../index.jsp'">홈</button>
	<button class="btn btn-default" onclick="history.back()">다시시도</button>
	</div>
</body> 
</html> 