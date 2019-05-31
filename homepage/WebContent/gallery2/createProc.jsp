<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_gallery.jsp"%>
<jsp:useBean id="dao" class="gallery.GalleryDAO" />
<jsp:useBean id="dto" class="gallery.GalleryDTO" />
<%
	upDir = "/gallery2/storage";
	tempDir = "/gallery2/temp";
	upDir = application.getRealPath(upDir);
	tempDir = application.getRealPath(tempDir);

	UploadSave upload = new UploadSave(request, -1, -1, tempDir);

	dto.setIname(UploadSave.encode(upload.getParameter("iname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));

	FileItem fileItem = upload.getFileItem("fname");
	int size = (int) fileItem.getSize();

	String fname = UploadSave.saveFile(fileItem, upDir);

	if (size > 0)
		dto.setFname(fname);
	else
		dto.setFname("image.jpg");

	boolean flag = dao.create(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container" style="color: lightgray;">
		<br>
		<div class="panel panel-default">
			<div class="panel-body">
				<%
					if (flag) {
						out.println("등록 성공");
					} else {
						out.println("등록 실패");
					}
					%>
			</div>
		</div>
		<button type="button" class="btn btn-deault"
			onclick="location.href='./createForm.jsp'">다시등록</button>
		<button type="button" class="btn btn-deault"
			onclick="location.href='./list.jsp'">목록</button>
	</div>
</body>
</html>
