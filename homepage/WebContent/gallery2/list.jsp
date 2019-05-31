<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_gallery.jsp"%>
<jsp:useBean id="dao" class="gallery.GalleryDAO" />
<%
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));

	if (col.equals("total"))
		word = "";

	int nowPage = 1;
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	int recordPerPage = 5;

	int sno = ((nowPage - 1) * recordPerPage) + 1;
	int eno = nowPage * recordPerPage;

	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);

	int total = dao.total(col, word);

	List<GalleryDTO> list = dao.list(map);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script>
function read(gno) {
  var url = "read.jsp"
  url+="?gno="+gno;
  
  location.href = url;
}
function filedown(fname){
  var url="<%=root%>/download";
    url += "?dir=/gallery2/storage";
    url += "&filename=" + fname;

    location.href = url;
  }
</script>
<style>
  .table a, .table a:active, .table a:visited, .table a:link, .table a:hover {color:#fff;}
  .table a:hover{text-decoration: underline; color:red;}
  </style>
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container" style="color: lightgray;">
		<h2>목록</h2>
		<hr>
		<form class="form-inline" action="./list.jsp">
			<div class="form-group">
				<select class="form-control" name="col">
					<option value="iname"
						<%if (col.equals("iname"))
				out.print("selected");%>>작가</option>
					<option value="title"
						<%if (col.equals("title"))
				out.print("selected");%>>작품명</option>
					<option value="content"
						<%if (col.equals("content"))
				out.print("selected");%>>설명</option>
					<option value="title_content"
						<%if (col.equals("title_content"))
				out.print("selected");%>>작품명+설명</option>
					<option value="total"
						<%if (col.equals("total"))
				out.print("selected");%>>전체출력</option>
				</select>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Enter 검색어"
					name="word" value="<%=word%>">
			</div>
			<button type="submit" class="btn btn-default">검색</button>
			<button type="button" class="btn btn-default"
				onclick="location.href='createForm.jsp'">등록</button>
		</form>
		<table class="table" style="color: white;">
			<thead>
				<tr>
					<th>번호</th>
					<th>사진</th>
					<th>작가</th>
					<th>작품명</th>
					<th>수정일</th>
					<th>조회수</th>
					<th>다운로드</th>
				</tr>
			</thead>
			<tbody>
				<%
					if (list.size() == 0) {
				%>
				<tr>
					<td colspan='7'>등록된 작품이 없습니다.</td>
				</tr>
				<%
					} else {
						for (int i = 0; i < list.size(); i++) {
							GalleryDTO dto = list.get(i);
							%>
							<tr style="font-size: 15px;">
								<td><%=dto.getGno()%></td>
								<td class="col-sm-2"><img class="img-rounded" width="50px"
									height="50px" src="./storage/<%=dto.getFname()%>"></td>
								<td><%=dto.getIname()%></td>
								<td><a href="javascript:read('<%=dto.getGno()%>')"><%=dto.getTitle()%></a>
								<td><%=dto.getWdate()%></td>
								<td><%=dto.getViewcnt()%></td>
								<td><button class="btn btn-default"
							onclick="filedown('<%=dto.getFname()%>')">다운로드</button></td>
				</tr>
				<%
					}
					}
				%>
			</tbody>
		</table>
		<div>
				<%=Utility.paging(total, nowPage, recordPerPage, col, word)%>
		</div>
	</div>
</body>
</html>
