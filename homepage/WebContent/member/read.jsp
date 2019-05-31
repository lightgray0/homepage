<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_member.jsp" %>
<jsp:useBean id="dao" class="member.MemberDAO"></jsp:useBean>
<%
	String id = request.getParameter("id");
	String grade = (String)session.getAttribute("grade");

	if(id==null){
		id = (String)session.getAttribute("id");
	}

	MemberDTO dto= dao.read(id);
%>

<!DOCTYPE html> 
<html> 
<head>
<title>회원정보</title>
<meta charset="utf-8">
<script type="text/javascript">
function filedown(){
	var url="<%=root%>/download";
	url += "?dir=/member/storage";
	url += "&filename=<%=dto.getFname()%>";
  
	location.href=url;
}
function del(){
	var url="deleteForm.jsp";
	url += "?id=<%=id%>";
	url += "&oldfile=<%=dto.getFname()%>";
  
	location.href=url;
}
function updateM(){
	var url="updateForm.jsp";
	url += "?id=<%=id%>";
  
	location.href=url;
}
function updatePw(){
	var url="updatePwForm.jsp";
	url += "?id=<%=id%>";
  
	location.href=url;
}
function updateFile(){
	var url="updateFileForm.jsp";
	url += "?id=<%=id%>";
	url += "&oldfile=<%=dto.getFname()%>";
  
	location.href=url;
}
function listM(){
    var url="<%=root%>/admin/list.jsp";
    
    location.href=url;
}
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container" style="color:white;">
	<h2><%=dto.getMname() %> 회원정보</h2><hr>
	<table class="table table-bordered">
	<tr>
		<td colspan="2">
		<img src="./storage/<%=dto.getFname() %>"
			class="img-rounded" width="200px" height="200px">
		</td>
	</tr>
			<tr>
				<th>아이디</th>
				<td><%=dto.getId() %></td>
			</tr>
			<tr>
				<th>성명</th>
				<td><%=dto.getMname()%></td>
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
				<th>우편번호</th>
				<td><%=dto.getZibcode() %></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><%=dto.getAddress1() %></td>
			</tr>
			<tr>
				<th>직업</th>
				<td>직업코드: <%=dto.getJob() %>(<%=Utility.getCodeValue(dto.getJob()) %>)</td>
			</tr>
			<tr>
				<th>날짜</th>
				<td><%=dto.getMdate() %></td>
			</tr>
		</table>
		<button class="btn btn-default" onclick="updateM()">정보수정</button>
		<button class="btn btn-default" onclick="del()">회원탈퇴</button>
		<%if(id!=null && !grade.equals("A")){ %>
		<button class="btn btn-default" onclick="updateFile()">사진수정</button>
		<button class="btn btn-default" onclick="updatePw()">암호변경</button>
		<button class="btn btn-default" onclick="filedown()">다운로드</button>
		<%} %>
		<%if(id!=null && grade.equals("A")) {%>
		<button class="btn btn-default" onclick="listM()">회원목록</button>
		<%} %>
	</div>
</body> 
</html> 