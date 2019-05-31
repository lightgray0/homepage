<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_gallery.jsp"%>
<jsp:useBean id="dao" class="gallery.GalleryDAO"></jsp:useBean>
<%
	// Form에서 enctype="multipart/form-data" 속성으로 통해 보냈고
	// request객체를 upload 객체로 담았기 때문에 
	// upload객체에서 getParameter()해야한다
	UploadSave upload = new UploadSave(request, -1, -1, tempDir);

	String gno = upload.getParameter("gno");
	String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
	String col = UploadSave.encode(upload.getParameter("col"));
	String word = UploadSave.encode(upload.getParameter("word"));
	String nowPage = upload.getParameter("nowPage");

	FileItem fileItem = upload.getFileItem("fname");

	UploadSave.deleteFile(upDir, oldfile);

	String fname = UploadSave.saveFile(fileItem, upDir);

	Map map = new HashMap();
	map.put("gno", gno);
	map.put("fname", fname);

	boolean flag = dao.updateFile(map);
	
	//out.println(gno);
	//out.println(oldfile);
	//out.println(col);
	//out.println(word);
	//out.println(nowPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script type="text/javascript">
function readG(){
  var url="read.jsp";
  
  url += "?gno=<%=gno%>";
  url += "&col=<%=col%>";
  url += "&word=<%=word%>";
  url += "&nowPage=<%=nowPage%>";

    location.href = url;
  }
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container"><br>
		<div class="well well-lg" style="color:black;">
			<%
				if (flag) {
					out.println("작품 파일 수정을 성공했습니다");
				} else {
					out.println("작품 파일 수정을 실패했습니다");
				}
			%>
		</div>
			<button class="btn btn-default"
				onclick="readG()">나의정보</button>
			<button class="btn btn-default" onclick="history.back()">다시시도</button>
	</div>
</body>
</html>
