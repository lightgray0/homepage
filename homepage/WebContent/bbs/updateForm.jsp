<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_bbs.jsp" %>
<jsp:useBean id="dao" class="bbs.BbsDAO"></jsp:useBean>
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	BbsDTO dto = dao.read(bbsno);
%>

<!DOCTYPE html> 
<html> 
<head>
<meta charset="utf-8">
<title>게시판 글 수정</title>
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container" style="color:white;">
	<h2>게시판 글 수정</h2><hr>
		<form class="form-horizontal" method="post" action="updateProc.jsp">
		
		<input type="hidden" name="bbsno" value="<%=dto.getBbsno() %>">
		<input type="hidden" name="col" value="<%=request.getParameter("col")%>">
		<input type="hidden" name="word" value="<%=request.getParameter("word")%>">
		<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">
		
			<div class="form-group">
				<label class="control-label col-sm-2" for="wname">작성자</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="wname" name="wname"
						value="<%=dto.getWname() %>" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="title">제목</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="title" name="title" 
							value="<%=dto.getTitle()%>"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="content">내용</label>
				<div class="col-sm-6">
					<textarea class="form-control" id="content" name="content" rows="10"><%=dto.getContent() %></textarea>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="passwd">비밀번호</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="passwd" name="passwd" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default">수정</button>
					<button type="reset" class="btn btn-default">취소</button>
					<button type="button" class="btn btn-default" onclick="location.href='./list.jsp'">목록</button>
				</div>
			</div>
		</form>
	</div>
</body> 
</html> 