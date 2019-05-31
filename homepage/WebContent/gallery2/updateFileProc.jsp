<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_gallery.jsp"%>
<jsp:useBean id="dao" class="gallery.GalleryDAO"></jsp:useBean>
<%
	upDir = "/gallery2/storage";
	tempDir = "/gallery2/temp";
	upDir = application.getRealPath(upDir);
	tempDir = application.getRealPath(tempDir);

	UploadSave upload = new UploadSave(request, -1, -1, tempDir);

	String gno = upload.getParameter("gno");
	String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
	
	FileItem fileItem = upload.getFileItem("fname");

	UploadSave.deleteFile(upDir, oldfile);

	String fname = UploadSave.saveFile(fileItem, upDir);

	Map map = new HashMap();
	map.put("gno", gno);
	map.put("fname", fname);

	boolean flag = dao.updateFile(map);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script type="text/javascript">
function readG(){
  var url="read.jsp";
  
  url += "?gno=<%=gno%>";

    location.href = url;
  }
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container" style="color: lightgray;">
		<br>
		<div class="well well-lg">
		<%
		if (flag) {
				out.println("파일 수정 성공");
			} else {
				out.println("파일 수정 실패");
			}
		%>
			<button class="btn btn" onclick="readG()">나의정보</button>
			<button class="btn btn" onclick="history.back()">다시시도</button>
		</div>
	</div>
</body>
</html>
