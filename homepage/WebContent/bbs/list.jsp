<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_bbs.jsp"%>
<jsp:useBean id="dao" class="bbs.BbsDAO" />
<%
	// 검색 관련-----------------------------
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total"))
		word="";
	// 페이지 관련----------------------------
	int nowPage = 1; // 현재 보고있는 페이지
	// 현재 보고있는 페이지가 1이 아닐때 해당 페이지를 출력 
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	int recordPerPage = 5; // 한 페이지당 보여줄 레코드 갯수

	// DB에서 가져올 순번-----------------------
	int sno = ((nowPage - 1) * recordPerPage) + 1;
	int eno = nowPage * recordPerPage;

	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	
	int total = dao.total(col,word);
	
	List<BbsDTO> list = dao.list(map);
%>
<!DOCTYPE html>
<html>
<head>
<title>게시판 목록</title>
<meta charset="utf-8">
<script>
  function readM(bbsno) {
    var url = "read.jsp"
    
    // bbsno는 자바스크립트 변수
    // col, word, nowPage는 스크립틀릿 안에 선언된 jsp 변수
   	// 넘겨주는 파라미터의 처음만 ?를 붙이고 이후에 복수 개의 파라미터를 넘길 시에는 &를 붙인다
    url += "?bbsno=" + bbsno;
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	
    location.href = url;
  }
</script>
  <style>
  .table a, .table a:active, .table a:visited, .table a:link, .table a:hover {color:#fff;}
  .table a:hover{text-decoration: underline; color:red;}
  </style>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container" style="color:white;">
		<h2 style="color: white;">게시판 목록</h2><hr>
		<form class="form-inline" action="./list.jsp">
			<div class="form-group">
				<select class="form-control" name="col">
					<option value="wname" 
					<% if(col.equals("wname")) out.print("selected"); %>
					>작성자</option>
					<option value="title"
					<% if(col.equals("title")) out.print("selected"); %>
					>제목</option>
					<option value="content"
					<% if(col.equals("content")) out.print("selected"); %>
					>내용</option>
					<option value="title_content"
					<% if(col.equals("title_content")) out.print("selected"); %>
					>제목+내용</option>
					<option value="total"
					<% if(col.equals("total")) out.print("selected"); %>
					>전체출력</option>
				</select>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Enter 검색어"
					name="word" value="<%=word%>">
			</div>
			<button type="submit" class="btn btn-default">검색</button>
			<button type="button" class="btn btn-default"
					onclick="location.href='createForm.jsp'"
			>등록</button>
		</form>
		<table class="table" style="background-color:transparent; color:white;">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>grpno</th>
					<th>indent</th>
					<th>ansnum</th>
				</tr>
			</thead>
			<tbody>
				<%
					if (list.size() == 0) {
				%>
				<tr>
					<td colspan='6'>등록된 글이 없습니다.</td>
				</tr>
				<%
					} else {
						for (int i = 0; i < list.size(); i++) {
							BbsDTO dto = list.get(i);
				%>
				<tr>
					<td><%=dto.getBbsno()%></td>
					<td>
					<%
						for(int j=0;j<dto.getIndent();j++){
							out.print("&nbsp;&nbsp;");
						}
						if(dto.getIndent()>0){
							out.print("<img src='../images/re3.png'>");
						}
					%>
					<a href="javascript:readM('<%=dto.getBbsno()%>')"> 
					<%=dto.getTitle()%></a>

					<% 
					// 엑박표시, 이미지가 안보이는 문제가 생기면 이미지가 포함된
					// 폴더에서 수동으로 직접 새로고침(Refresh)해준다
					if(Utility.compareDay(dto.getWdate())){%>
						<img src="../images/new.gif">
					<% } %>
					</td>
					<td><%=dto.getWname()%></td>
					<td><%=dto.getGrpno()%></td>
					<td><%=dto.getIndent()%></td>
					<td><%=dto.getAnsnum()%></td>
				</tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		<div>
			<%= Utility.paging(total, nowPage, recordPerPage, col, word) %>
		</div>
	</div>
</body>
</html>
