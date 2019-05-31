<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>비밀번호 찾기</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/
jquery/1.9.1/jquery.js"></script>
<script src="<%=request.getContextPath()%>/js/ajaxsetup.js"></script>
<script>
function pwFind(form){
	if(form.id.value==""){
	  alert("아이디를 입력해주세요");
	  document.frm.id.focus();
	}
	else if(form.mname.value==""){
	  alert("이름을 입력해주세요");
	  document.frm.mname.focus();
	}
	else{
	  var url = "pwSearchProc.jsp";
	  var param ="id="+form.id.value+"&mname="+form.mname.value;
	  
	  $.get(url, param, function(data, textStatus) {
	    // 응답함수
	    // alert(data);
	    $("#pwfind").text(data);
	  });
	}
}
</script>
</head>
<body>
	<div class="container">
		<h2 class="col-sm-10">비밀번호 찾기</h2>
		<form class="form-horizontal" method="post" name="frm" action="">
			<div class="form-group">
				<label class="control-label col-sm-2" for="id">아이디</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="id" name="id" required="required" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="mname">이름</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="mname" name="mname" required="required" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="button" class="btn btn-default" onclick="pwFind(document.frm)">확인</button>
					<button type="button" class="btn btn-default" onclick="window.close()">취소</button>
				</div>
			</div>
		</form>
		<div id="pwfind"></div>
	</div>
</body>
</html>
