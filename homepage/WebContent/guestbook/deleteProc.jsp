<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_guestbook.jsp"%>
<jsp:useBean id="dao" class="guestbook.GuestBookDAO" />
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String pw = request.getParameter("passwd");

	boolean flag = false;

	Map map = new HashMap<>();
	map.put("no", no);
	map.put("passwd", pw);

	// 받아온 dto를 실제로 바꿔주는것
	if (dao.passwdCheck(map))
		flag = dao.delete(no);
%>
<!DOCTYPE html>
<html>
<head>
<title>방명록 삭제</title>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container">
		<div class="panel panel-default" style="color:black;">
			<div class="panel-body">
				<%
					if (flag) {
						out.println("방명록을 삭제했습니다.");
					} else {
						out.println("방명록 삭제를 실패 했습니다.");
					}
				%>
			</div>
		</div>
		<button type="button" class="btn btn-default"
			onclick="location.href='createForm.jsp'">다시등록</button>
		<button type="button" class="btn btn-default" onclick="location.href='list.jsp'">목록</button>
	</div>
</body>
</html>
