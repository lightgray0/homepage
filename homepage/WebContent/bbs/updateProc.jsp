<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_bbs.jsp"%>
<jsp:useBean id="dao" class="bbs.BbsDAO"/>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<jsp:setProperty name="dto" property="*"/>

<!-- 다음과 같이 쓰면 모든 필드명의 이름이 같을때 한번에 세팅 가능하다 -->
<!--<jsp:setProperty name="dto" property="*"/>-->

<%
	Map map = new HashMap();
	map.put("bbsno", dto.getBbsno());
	map.put("passwd", dto.getPasswd());
	
	boolean flag = false;
	boolean pflag = dao.passCheck(map);
	if(pflag)
		flag=dao.update(dto);
%>
<!DOCTYPE html>
<html>
<head>
  <title>게시판 글 수정 처리</title>
  <meta charset="utf-8">
<script type="text/javascript">
  function listM(){
    var url="list.jsp";
    url += "?col=<%=request.getParameter("col")%>";
    url += "&word=<%=request.getParameter("word")%>";
    url += "&nowPage=<%=request.getParameter("nowPage")%>";

    location.href = url;
  }
</script>
</head>
<body>
<jsp:include page="/menu/top.jsp"/>
	<div class="container">
		<div class="panel panel-default" style="color:black;">
			<div class="panel-body">
			<%
			if(!pflag){
				out.println("잘못된 비밀번호 입니다");
			}else if(flag){
				out.println("게시판 글 수정 성공입니다");
			}else
				out.println("게시판 글 수정 실패입니다");
			%>
			</div>
		</div>
		<% if(!pflag){ %>
			<button type="button" class="btn btn-default" onclick="history.back()">다시시도</button>
		<%} %>
		<button type="button" class="btn btn-default" onclick="location.href='./createForm.jsp'">다시등록</button>
		<button type="button" class="btn btn-default" onclick="listM()">목록</button>
	</div>
</body>
</html>