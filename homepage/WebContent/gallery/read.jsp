<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_gallery.jsp" %>
<jsp:useBean id="dao" class="gallery.GalleryDAO"/>
<%
	int gno = Integer.parseInt(request.getParameter("gno"));

	dao.upViewcnt(gno);
	GalleryDTO dto = dao.read(gno);
	String content = dto.getContent().replaceAll("\r\n", "<br>");
	
	//out.println(request.getParameter("col"));
	//out.println(request.getParameter("word"));
	//out.println(request.getParameter("nowPage"));
	
%>

<!DOCTYPE html> 
<html> 
<head>
<title>갤러리 작품 조회</title>
<meta charset="utf-8">
<style type="text/css"> 
.curImg{
	margin-right:0;
	border-style:solid;
	border-width: 3px;
	border-color: red;
}
.td_padding{
	padding:5px 5px;
}

</style> 
<script type="text/javascript">
function readGo(gno){
	var url = "./read.jsp";
	url = url +"?gno="+gno;
  	
	url += "&col=<%=request.getParameter("col")%>";
  	url += "&word=<%=request.getParameter("word")%>";
  	url += "&nowPage=<%=request.getParameter("nowPage")%>";
  	
	location.href=url;
}
function filedown(){
	var url="<%=root%>/download";
	url += "?dir=/gallery/storage";
	url += "&filename=<%=dto.getFname()%>";
  
	location.href=url;
}
function deleteG(){
	var url="deleteForm.jsp";
	url += "?gno=<%=gno%>";
	url += "&oldfile=<%=dto.getFname()%>";
	
  	url += "&col=<%=request.getParameter("col")%>";
  	url += "&word=<%=request.getParameter("word")%>";
  	url += "&nowPage=<%=request.getParameter("nowPage")%>";
  
	location.href=url;
}
function updateG(){
	var url="updateForm.jsp";
	url += "?gno=<%=gno%>";
  
  	url += "&col=<%=request.getParameter("col")%>";
  	url += "&word=<%=request.getParameter("word")%>";
  	url += "&nowPage=<%=request.getParameter("nowPage")%>";
  
	location.href=url;
}
function updateFile(){
	var url="updateFileForm.jsp";
	url += "?gno=<%=gno%>";
	url += "&oldfile=<%=dto.getFname()%>";
	
  	url += "&col=<%=request.getParameter("col")%>";
  	url += "&word=<%=request.getParameter("word")%>";
  	url += "&nowPage=<%=request.getParameter("nowPage")%>";
  	
	location.href=url;
}
function listG(){
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
	<div class="container" style="color:white;">
	<h2>갤러리 작품 조회</h2><hr>
		<table class="table table-bordered" class="col-sm-10">
			<TR>
				<%
					List list = dao.imgRead(gno);
					String[] files = (String[]) list.get(0);
					int[] noArr = (int[]) list.get(1);
					for (int i = 0; i < 5; i++) {
						if (files[i] == null) {
				%>
				<td class="td_padding" align="center"><img
					src="./storage/image.jpg" width="120px" height="80px"></td>
				<%
					} else {
							if (noArr[i] == gno) {
				%>

				<td class="td_padding" align="center"><a
					href="javascript:readGo('<%=noArr[i]%>')"> <img class="curImg"
						src="./storage/<%=files[i]%>" width="120px" height="80px"
						border="0">
				</a></td>
				<%
					} else {
				%>
				<td class="td_padding" align="center"><a
					href="javascript:readGo('<%=noArr[i]%>')"> <img
						src="./storage/<%=files[i]%>" width="120px" height="80px"
						border="0">
				</a></td>

				<%
					}
						}
					}
				%>
			</TR>
		</table>
		<table class="table table-bordered" class="col-sm-10">
			<tr>
				<td colspan="5" align="center">
				<img src="./storage/<%=dto.getFname() %>" class="img-rounded"
					width="300px" height="300px">
				</td>
			</tr>
			<tr>
				<th class="col-sm-1">작가</th>
				<td class="col-sm-4" colspan="4"><%=dto.getIname()%></td>
			</tr>
			<tr>
				<th class="col-sm-1">작품명</th>
				<td class="col-sm-4" colspan="4"><%=dto.getTitle()%></td>
			</tr>
			<tr>
				<th class="col-sm-1">설명</th>
				<td class="col-sm-4" colspan="4"><%=dto.getContent()%></td>
			</tr>
			<tr>
				<th class="col-sm-1">수정날짜</th>
				<td class="col-sm-4" colspan="4"><%=dto.getWdate()%></td>
			</tr>
			<tr>
				<th class="col-sm-1">조회수</th>
				<td class="col-sm-4" colspan="4"><%=dto.getViewcnt()%></td>
			</tr>
		</table>
		<button class="btn btn-default" onclick="updateG()">정보수정</button>
		<button class="btn btn-default" onclick="updateFile()">파일수정</button>
		<button class="btn btn-default" onclick="deleteG()">작품삭제</button>
		<button class="btn btn-default" onclick="filedown()">다운로드</button>
		<button class="btn btn-default" onclick="listG()">목록</button>
	</div>
</body> 
</html> 