<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_gallery.jsp" %>
<jsp:useBean id="dao" class="gallery.GalleryDAO"/>
<jsp:useBean id="dto" class="gallery.GalleryDTO"/>
<%
	UploadSave upload = new UploadSave(request, -1, -1, tempDir);

	dto.setIname(UploadSave.encode(upload.getParameter("iname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	
	FileItem fileItem = upload.getFileItem("fname");
	int size = (int)fileItem.getSize();

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
<title>갤러리 작품 등록 처리</title>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container"><br>
		<div class="panel panel-default" style="color:black;">
			<div class="panel-body">
			<%
			if(flag){
				out.println("갤러리 작품 등록 성공입니다");
			}else{
				out.println("갤러리 작품 등록 실패입니다");
			}
			%>
			</div>
		</div>
		<button type="button" class="btn btn-default" onclick="location.href='./createForm.jsp'">다시등록</button>
		<button type="button" class="btn btn-default" onclick="location.href='./list.jsp'">목록</button>
	</div>
</body> 
</html> 