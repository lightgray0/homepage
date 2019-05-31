<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_gallery.jsp"%>
<jsp:useBean id="dao" class="gallery.GalleryDAO" />
<%
	int gno = Integer.parseInt(request.getParameter("gno"));

	dao.upViewcnt(gno);
	GalleryDTO dto = dao.read(gno);
	String content = dto.getContent().replaceAll("\r\n", "<br>");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style type="text/css">

.curImg {
	margin-right: 0;
	border-style: solid;
	border-width: 3px;
	border-color: pink;
}

.td_padding {
	padding: 5px 5px;
}
</style>
<script type="text/javascript">
function readGo(gno){
	var url = "./read.jsp";
	url = url +"?gno="+gno;
  	
	location.href=url;
}
function filedown(){
	var url="<%=root%>/download";
	url += "?dir=/gallery2/storage";
	url += "&filename=<%=dto.getFname()%>";
  
	location.href=url;
}
function del(){
	var url="deleteForm.jsp";
	url += "?gno=<%=gno%>";
	url += "&oldfile=<%=dto.getFname()%>";
	
	location.href=url;
}
function update(){
	var url="updateForm.jsp";
	url += "?gno=<%=gno%>";
  
	location.href=url;
}
function updateFile(){
	var url="updateFileForm.jsp";
	url += "?gno=<%=gno%>";
	url += "&oldfile=<%=dto.getFname()%>";

    location.href = url;
  }
  function list() {
    var url = "list.jsp";

    location.href = url;
  }
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container" style="color: lightgray;">
		<h1>조회</h1>
		<table class="table table-bordered">
			<tr>
				<td colspan="5" align="center"><img
					src="./storage/<%=dto.getFname()%>" class="img-rounded"
					width="300px" height="300px"></td>
			</tr>
			<TR>
				<%
					List list = dao.imgRead(gno);
					String[] files = (String[]) list.get(0);
					int[] noArr = (int[]) list.get(1);
					for (int i = 0; i < 5; i++) {
						if (files[i] == null) {
				%>
				<td class="td_padding" align="center"><img
					src="./storage/image.jpg" width="110px" height="90px"></td>
				<%
					} else {
							if (noArr[i] == gno) {
				%>

				<td class="td_padding" align="center"><a
					href="javascript:readGo('<%=noArr[i]%>')"> <img class="curImg"
						src="./storage/<%=files[i]%>" width="100px" height="100px"
						border="0">
				</a>
				</td>
				<%
					} else {
				%>
				<td class="td_padding" align="center"><a
					href="javascript:readGo('<%=noArr[i]%>')"> <img
						src="./storage/<%=files[i]%>" width="100px" height="100px"
						border="0">
				</a>
				</td>

				<%
					}
						}
					}
				%>
			</TR>
			<tr>
				<th>작가</th>
				<td colspan="4"><%=dto.getIname()%></td>
			</tr>
			<tr>
				<th>작품명</th>
				<td colspan="4"><%=dto.getTitle()%></td>
			</tr>
			<tr>
				<th>설명</th>
				<td colspan="4"><%=dto.getContent()%></td>
			</tr>
			<tr>
				<th>수정날짜</th>
				<td colspan="4"><%=dto.getWdate()%></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td colspan="4"><%=dto.getViewcnt()%></td>
			</tr>
		</table>
		<button class="btn btn-default" onclick="update()">정보수정</button>
		<button class="btn btn-default" onclick="updateFile()">파일수정</button>
		<button class="btn btn-default" onclick="del()">삭제하기</button>
		<button class="btn btn-default" onclick="filedown()">다운로드</button>
		<button class="btn btn-default" onclick="list()">목록으로</button>
	</div>
</body>
</html>
		