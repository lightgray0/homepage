<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_gallery.jsp"%>
<jsp:useBean id="dao" class="gallery.GalleryDAO" />
<jsp:useBean id="dto" class="gallery.GalleryDTO" />
<jsp:setProperty name="dto" property="*" />
<%
	Map map = new HashMap();
	map.put("gno", dto.getGno());
	map.put("passwd", dto.getPasswd());

	boolean flag = false;
	boolean pflag = dao.passCheck(map);
	if (pflag)
		flag = dao.update(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script type="text/javascript">
  function list() {
    var url = "list.jsp";

    location.href = url;
  }
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container" style="color: lightgray;">
		<br>
		<div class="panel panel-default">
			<div class="panel-body">
				<%
					if (!pflag) {
						out.println("잘못된 비밀번호 입니다");
					} else if (flag) {
						out.println("수정 성공");
					} else {
						out.println("수정 실패");
					}
				%>
			</div>
		</div>
		<%
			if (!pflag) {
		%>
		<button type="button" class="btn btn-deault" onclick="history.back()">다시시도</button>
		<%
			}
		%>
		<button type="button" class="btn btn-deault"
			onclick="location.href='./createForm.jsp'">다시등록</button>
		<button type="button" class="btn btn-deault" onclick="list()">목록</button>
	</div>
</body>
</html>
