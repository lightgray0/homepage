<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_guestbook.jsp" %>
<jsp:useBean id="dao" class="guestbook.GuestBookDAO"></jsp:useBean>
<%
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total"))
		word="";
	
	int nowPage=1;
	if(request.getParameter("nowPage")!=null){
		nowPage=Integer.parseInt(request.getParameter("nowPage"));
	}
	
	int recordPerPage = 5;
	int sno = ((nowPage-1)*recordPerPage)+1;
	int eno = nowPage*recordPerPage;
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	
	int total = dao.total(map);
	List<GuestBookDTO> list = dao.list(map);
%>
<!DOCTYPE html>
<html>
<head>
<title>방명록 리스트</title>
<meta charset="utf-8">
<script type="text/javascript">
	function read(no) {
      var url = "read.jsp";
      url += "?no=" + no;
      location.href = url;
    }
	
	function update(no){
	  var url = "updateForm.jsp";
	  url += "?no=" + no;
	  location.href = url;
	}

    function del(no) {
      var url = "deleteForm.jsp";
      url += "?no=" + no;
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
		<h2>방명록 리스트</h2><hr>
		<form class="form-inline" method="post" action="./list.jsp">
			<div class="form-group">
				<select class="form-control" name="col">
					<option value="name"
					<%if(col.equals("name")) out.print("selected"); %>
					>이름</option>
					<option value="title"
					<%if(col.equals("title")) out.print("selected"); %>
					>제목</option>
					<option value="content"
					<%if(col.equals("content")) out.print("selected"); %>
					>내용</option>
					<option value="part"
					<%if(col.equals("part")) out.print("selected"); %>
					>분야</option>
					<option value="title_content"
					<%if(col.equals("title_content")) out.print("selected"); %>
					>제목+내용</option>
					<option value="total"
					<%if(col.equals("total")) out.print("selected"); %>
					>전체출력</option>
				</select>
			</div>
			<div class="form-group">
			<input type="text" class="form-control" placeholder="Enter 검색어"
					name="word" value="<%=word %>">
			</div>
			<button class="btn btn-default">검색</button>
			<button type="button" class="btn btn-default" 
					onclick="location.href='./createForm.jsp'"
			>등록</button>
		</form><br>
		<table class="table" style="background-color:transparent; color:#fff;">
			<thead>
				<tr>
					<th>번호</th>
					<th>이름</th>
					<th>제목</th>
					<th>분야</th>
					<th>수정일</th>
					<th>grpno</th>
					<th>indent</th>
					<th>ansnum</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
				<%
					if (list.size() == 0) {
				%>
				<tr>
					<td colspan="9">등록된 방명록이 없습니다.</td>
				</tr>
				<%
					} else {
						for (int i = 0; i < list.size(); i++) {
							GuestBookDTO dto = list.get(i);
				%>
				<tr>
					<td><%=dto.getNo()%></td>
					<td>
					<%=dto.getName()%>
					</td>
					<td>
					<%for(int j=0;j<dto.getIndent();j++){
						out.print("&nbsp;&nbsp;");
					}
					if(dto.getIndent()>0){
						out.print("<img src='../images/re3.png'>");
					}
					%> <a href="javascript:read('<%=dto.getNo()%>')"><%=dto.getTitle()%></a></td>
					<td><%=dto.getPartStr()%></td>
					<td><%=dto.getRegdate()%></td>
					<td><%=dto.getGrpno()%></td>
					<td><%=dto.getIndent()%></td>
					<td><%=dto.getAnsnum()%></td>
					<td><a href="javascript:update('<%=dto.getNo()%>')">수정</a> / <a
						href="javascript:del('<%=dto.getNo()%>')">삭제</a></td>
				</tr>
				<%
					}
				}
				%>
			</tbody>
		</table>
		<%=Utility.paging(total, nowPage, recordPerPage, col, word) %>
	</div>
</body>
</html>
