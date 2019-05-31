<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_bbs.jsp"%>
<jsp:useBean id="dao" class="bbs.BbsDAO"/>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%
	Map map = new HashMap();
	map.put("grpno",dto.getGrpno());
	map.put("ansnum",dto.getAnsnum());
	map.put("indent",dto.getIndent());
	dao.upAnsnum(map);
	boolean flag = dao.createReply(dto);
%>
<!DOCTYPE html>
<html>
<head>
  <title>게시판 답글 등록 처리</title>
  <meta charset="utf-8">
</head>
<body>
<jsp:include page="/menu/top.jsp"/>
	<div class="container">
		<div class="panel panel-default" style="color:black;">
			<div class="panel-body">
			<%
			if(flag){
				out.println("게시판 답글 등록 성공입니다");
			}else{
				out.println("게시판 답글 등록 실패입니다");
			}
			%>
			</div>
		</div>
		<button type="button" class="btn btn-default" onclick="location.href='./replyForm.jsp'">답글등록</button>
		<button type="button" class="btn btn-default" onclick="location.href='./list.jsp'">목록</button>
	</div>
</body>
</html>