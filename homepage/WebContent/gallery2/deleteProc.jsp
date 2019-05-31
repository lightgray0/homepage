<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_gallery.jsp"%>
<jsp:useBean id="dao" class="gallery.GalleryDAO"></jsp:useBean>

<%
	int gno = Integer.parseInt(request.getParameter("gno"));
	String passwd = request.getParameter("passwd");

	Map map = new HashMap();
	map.put("gno", gno);
	map.put("passwd", passwd);

	boolean flag = false;
	boolean pflag = dao.passCheck(map);
	if (pflag)
		flag = dao.delete(gno);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script type="text/javascript">
  function listM() {
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
						out.println("삭제 성공");
					} else
						out.println("삭제 실패");
				%>
			</div>
			<%
				if (!pflag) {
			%>
			<button type="button" class="btn btn" onclick="history.back()">다시시도</button>
			<%
				}
			%>
			<button type="button" class="btn btn"
				onclick="location.href='./createForm.jsp'">다시등록</button>
			<button type="button" class="btn btn" onclick="listM()">목록</button>
		</div>
	</div>
</body>
</html>
