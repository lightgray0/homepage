<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_gallery.jsp"%>

<jsp:useBean id="dao" class="gallery.GalleryDAO"></jsp:useBean>
<%
	int gno = Integer.parseInt(request.getParameter("gno"));
	GalleryDTO dto = dao.read(gno);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container" style="color: lightgray;">
		<h2>수정</h2>
		<form class="form-horizontal" method="post" action="updateProc.jsp">
			<input type="hidden" name="gno"
				value="<%=request.getParameter("gno")%>">
			<div class="form-group">
				<label class="control-label col-sm-2" for="iname">작가</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="iname" name="iname"
						value="<%=dto.getIname() %>" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="title">작품명</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="title" name="title"
						value="<%=dto.getTitle()%>" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="content">설명</label>
				<div class="col-sm-6">
					<textarea class="form-control" id="content" name="content"
						rows="10"><%=dto.getContent()%></textarea>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="passwd">비밀번호</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="passwd"
						name="passwd" />
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn">수정</button>
					<button type="reset" class="btn btn">취소</button>
					<button type="button" class="btn btn" onclick="location.href='./list.jsp'">목록</button>
				</div>
			</div>

		</form>
	</div>
</body>
</html>
