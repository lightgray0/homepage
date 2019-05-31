<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_guestbook.jsp"%>
<jsp:useBean id="dao" class="guestbook.GuestBookDAO" />
<jsp:useBean id="dto" class="guestbook.GuestBookDTO" />
<!-- dto에 값을 받아오고 -->
<jsp:setProperty name="dto" property="*" />

<%
	// 아직 바뀐건 아니지만 바꿀 dto임
	// out.println(dao.pp(dto));
	boolean flag = false;

	Map map = new HashMap<>();
	map.put("no", dto.getNo());
	map.put("passwd", dto.getPasswd());

	// 받아온 dto를 실제로 바꿔주는것
	if (dao.passwdCheck(map))
		flag = dao.update(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container">
		<div class="panel panel-default" >
			<div class="panel-body" style="color:black;">
				<%
					if (flag) {
						out.println("방명록을 수정했습니다.");
					} else {
						out.println("방명록을 수정을 실패 했습니다.");
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
