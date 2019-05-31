<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_member.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<% 
	UploadSave upload = new UploadSave(request,-1,-1, tempDir);
		
	String id = upload.getParameter("id");
	String oldfile = UploadSave.encode(upload.getParameter("oldfile")); 
	
	FileItem fileItem = upload.getFileItem("fname");
	
	// upDir경로에있는 oldfile 원본 파일을 삭제
	UploadSave.deleteFile(upDir, oldfile);
	
	String fname = UploadSave.saveFile(fileItem, upDir);
	
	Map map = new HashMap();
	
	map.put("id",id);
	map.put("fname",fname);
	
	boolean flag = dao.updateFile(map);
%>
<!DOCTYPE html> 
<html> 
<head>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container">
		<div class="well well-lg" style="color: black;">
			<%
				if (flag) {
					out.println("사진 수정을 성공했습니다");
				} else {
					out.println("사진 수정을 실패했습니다");
				}
			%>
		</div>
		<button class="btn btn-default"
			onclick="location.href='read.jsp?id=<%=id%>'">나의정보</button>
		<button class="btn btn-default" onclick="history.back()">다시시도</button>
	</div>
</body>
</html> 