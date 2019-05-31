<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_bbs.jsp"%>
<jsp:useBean id="dao" class="bbs.BbsDAO"/>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<jsp:setProperty name="dto" property="*"/>

<!-- 다음과 같이 쓰면 모든 필드명의 이름이 같을때 한번에 세팅 가능하다 -->
<!--<jsp:setProperty name="dto" property="*"/>-->

<%
	boolean flag = dao.create(dto);
%>
<!DOCTYPE html>
<html>
<head>
  <title>게시판 글 등록 처리</title>
  <meta charset="utf-8">
</head>
<body>
<jsp:include page="/menu/top.jsp"/>
	<div class="container">
		<div class="panel panel-default" style="color:black;">
			<div class="panel-body">
			<%
			if(flag){
				out.println("게시판 글 등록 성공입니다");
			}else{
				out.println("게시판 글 등록 실패입니다");
			}
			%>
			</div>
		</div>
		<button type="button" class="btn btn-default" onclick="location.href='./createForm.jsp'">다시등록</button>
		<button type="button" class="btn btn-default" onclick="location.href='./list.jsp'">목록</button>
	</div>
</body>
</html>