<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_guestbook.jsp" %>
<jsp:useBean id="dao" class="guestbook.GuestBookDAO"/>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	GuestBookDTO dto = dao.read(no);
	
	String part = dto.getPartStr();
%>

<!DOCTYPE html>
<html>
<head>
<title>방명록 수정</title>
<meta charset="utf-8">
</head>
<body>
<jsp:include page="/menu/top.jsp"/>
	<div class="container" style="color:white;">
		<h2>방명록 수정</h2><hr>
		<form class="form-horizontal" method="post" action="updateProc.jsp">
		<input type="hidden" name="no" value="<%=dto.getNo()%>"/>
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">이름</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="name"
						placeholder="Enter name" name="name" value="<%=dto.getName() %>">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="title">제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="title"
						placeholder="Enter title" name="title" value="<%=dto.getTitle() %>">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="content">내용</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="content" name="content" placeholder="Enter content" rows="10"><%=dto.getContent()%></textarea>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="passwd">암호</label>
				<div class="col-sm-10">
					<input type="password" class="form-control" id="passwd"
						placeholder="Enter password" name="passwd">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="gender">성별</label>
				<div class="col-sm-10">
					<label class="radio-inline"> <input type="radio"
						name="gender" value="남자" 
					<% if(dto.getGender().indexOf("남자")!=-1) 
						out.print("checked");
					%>
					>남자
					</label> <label class="radio-inline"> <input type="radio"
						name="gender" value="여자" 
					<% if(dto.getGender().indexOf("여자")!=-1) 
						out.print("checked");
					%>
					>여자
					</label>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2">분야</label>
				<div class="col-sm-10">
					<label class="checkbox-inline"> <input type="checkbox"
						name="part" value="JAVA"
					<% if(part.indexOf("JAVA")!=-1) 
						out.print("checked");
					%>
						>JAVA
					</label> <label class="checkbox-inline"> <input type="checkbox"
						name="part" value="JSP"
					<% if(part.indexOf("JSP")!=-1) 
						out.print("checked");
					%>
						>JSP
					</label> <label class="checkbox-inline"> <input type="checkbox"
						name="part" value="C#"
					<% if(part.indexOf("C#")!=-1) 
						out.print("checked");
					%>
						>C#
					</label> <label class="checkbox-inline"> <input type="checkbox"
						name="part" value="HADOOP"
					<% if(part.indexOf("HADOOP")!=-1) 
						out.print("checked");
					%>
						>HADOOP
					</label> <label class="checkbox-inline"> <input type="checkbox"
						name="part" value="R"
					<% if(part.indexOf("R")!=-1) 
						out.print("checked");
					%>
						>R
					</label>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-5">
					<button class="btn btn-default">수정</button>
					<button class="btn btn-default" type="reset">취소</button>
					<button class="btn btn-default" type="button"
						onclick="location.href='./list.jsp'">목록</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>