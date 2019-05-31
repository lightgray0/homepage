<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_guestbook.jsp" %>
<jsp:useBean id="dao" class="guestbook.GuestBookDAO"/>
<jsp:useBean id="dto" class="guestbook.GuestBookDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%
	Map map = new HashMap();
	map.put("grpno", dto.getGrpno());
	map.put("ansnum", dto.getAnsnum());
	dao.upAnsnum(map);
	
	boolean flag = dao.createReply(dto);
%>
<!DOCTYPE html> 
<html> 
<head>
<meta charset="utf-8">
</head>
<body>
<jsp:include page="/menu/top.jsp"/>
	<div class="container">
		<div class="panel panel-default" style="color:black;">
			<div class="panel-body">
				<%
					if (flag) {
						out.println("방명록 답글 생성을 성공 했습니다.");
					} else {
						out.println("방명록 답글 생성을 실패 했습니다.");
					}
				%>
			</div>
		</div>
		<button type="button" class="btn btn-default"
			onclick="location.href='createForm.jsp'">다시등록</button>
		<button type="button" class="btn btn-default"
			onclick="location.href='list.jsp'">목록</button>
	</div>
</body> 
</html> 