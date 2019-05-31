<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_member.jsp" %>

<!DOCTYPE html> 
<html> 
<head>
<meta charset="utf-8">
<script type="text/javascript">
function incheck(f){
  if(f.passwd.value==""){
    alert("비밀번호를 입력하세요");
    f.passwd.focus();
    return false;
  }
  if(f.repasswd.value==""){
    alert("비밀번호 확인을 입력하세요");
    f.repasswd.focus();
    return false;
  }
  if(f.passwd.value!=f.repasswd.value){
    alert("비밀번호와 비밀번호확인이 일치하지 않습니다");
    f.repasswd.value="";
    f.repasswd.focus();
    return false;
  }
  
}
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container" style="color:white;">
	<h2>비밀번호 변경</h2><hr>
		<form class="form-horizontal" method="post" action="updatePwProc.jsp"
				onsubmit="return incheck(this);">
			<input type="hidden" id="id" name="id" value="<%=request.getParameter("id") %>">
			<div class="form-group">
				<label class="control-label col-sm-2" for="passwd">비밀번호</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="passwd" name="passwd" />
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="repasswd">비밀번호 확인</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="repasswd" name="repasswd" />
				</div>
			</div>
			
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default">변경</button>
					<button type="reset" class="btn btn-default"
							onclick="history.back()">취소</button>
				</div>
			</div>
		</form>
	</div>
</body> 
</html> 