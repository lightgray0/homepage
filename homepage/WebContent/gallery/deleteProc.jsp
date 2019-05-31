<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_gallery.jsp" %>
<jsp:useBean id="dao" class="gallery.GalleryDAO"></jsp:useBean>

<%
	int gno = Integer.parseInt(request.getParameter("gno"));
	String passwd = request.getParameter("passwd");
	String oldfile = request.getParameter("oldfile");
	
	Map map = new HashMap();
	map.put("gno",gno);
	map.put("passwd",passwd);
	
	boolean pflag = dao.passCheck(map);
	boolean flag = false;
	if(pflag){
		flag=dao.delete(gno);
		if(flag && !oldfile.equals("image.jpg")){
			UploadSave.deleteFile(upDir, oldfile);
		}
	}
%>
<!DOCTYPE html> 
<html> 
<head>
<title>갤러리 작품 삭제 처리</title>
<meta charset="utf-8">
 <script type="text/javascript">
  function listM(){
    var url="list.jsp";
    
    url += "?col=<%=request.getParameter("col")%>";
    url += "&word=<%=request.getParameter("word")%>";
    url += "&nowPage=<%=request.getParameter("nowPage")%>";
      
    location.href=url;
  }
  </script>
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container"><br>
		<div class="panel panel-default" style="color:black;">
			<div class="panel-body">
			<%
			if(!pflag){
				out.println("잘못된 비밀번호 입니다");
			}else if(flag){
				out.println("게시판 글 삭제 성공입니다");
			}else
				out.println("게시판 글 삭제 실패입니다");
			%>
			</div>
		</div>
		<% if(!pflag){ %>
			<button type="button" class="btn btn-default" onclick="history.back()">다시시도</button>
		<%} %>
		<button type="button" class="btn btn-default" onclick="location.href='./createForm.jsp'">다시등록</button>
		<button type="button" class="btn btn-default" onclick="listM()">목록</button>
	</div>
</body> 
</html> 