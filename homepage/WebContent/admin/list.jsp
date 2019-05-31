<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp"%>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
	// 검색 관련
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total"))
		word="";
	
	// 페이지 관련
	int nowPage = 1;
	int recordPerPage = 3;
	
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	int sno = ((nowPage-1)*recordPerPage)+1;
	int eno = nowPage*recordPerPage;
	
	Map map = new HashMap();
	map.put("col",col);
	map.put("word",word);
	map.put("sno",sno);
	map.put("eno",eno);
	
	int total = dao.total(map);
	List<MemberDTO> list = dao.list(map);
	
	String paging = Utility.paging(total, nowPage, recordPerPage, col, word);
%>
<!DOCTYPE html>
<html>
<head>
<title>회원목록</title>
<meta charset="utf-8">
<script type="text/javascript">
function read(id){
  var url = "<%=root%>/member/read.jsp";
  url += "?id="+id;
  
  location.href=url;
}
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container" style="color:lightgray">
		<h2>회원목록</h2><hr>
		<form class="form-inline" method="post" action="./list.jsp">
			<div class="form-group">
				<select class="form-control" name="col">
					<option value="mname"
						<%if (col.equals("mname"))
				out.print("selected");%>>이름</option>
					<option value="id"
						<%if (col.equals("id"))
				out.print("selected");%>>아이디</option>
					<option value="email"
						<%if (col.equals("email"))
				out.print("selected");%>>이메일</option>
					<option value="total"
						<%if (col.equals("total"))
				out.print("selected");%>
					>전체출력</option>
				</select>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Enter 검색어"
					name="word" value="<%=word%>">
			</div>
			<button class="btn btn-default">검색</button>
			<button type="button" class="btn btn-default" onclick="location.href='<%=root%>/member/createForm.jsp'">등록</button>
		</form>
		<%
		for(int i=0;i<list.size();i++){
				MemberDTO dto = list.get(i);
		%>
		<br>
		<table class="table table-bordered">
			<tr>
				<td rowspan="5" class="col-sm-2"><img class="img-rounded" width="200px" height="200px" src="<%=root %>/member/storage/<%=dto.getFname() %>"></td>
				<th class="col-sm-2">아이디</th>
				<td class="col-sm-8"><a href="javascript:read('<%=dto.getId() %>')"><%=dto.getId() %></a></td>
			</tr>
			<tr>
				<th>성명</th>
				<td><%=dto.getMname() %></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><%=dto.getTel() %></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><%=dto.getEmail() %></td>
			</tr>
			<tr>
				<th>주소</th>
				<td>(<%=dto.getZibcode() %>) <%=dto.getAddress1() %> <%=dto.getAddress2() %></td>
			</tr>
		</table>
		<%
		} 
		%>
		<%=paging%>
	</div>
</body>
</html>
