<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<title>방명록 글 등록</title>
<meta charset="utf-8">
<script type="text/javascript">
  function incheck(f) {
    if (f.name.value == '') {
      alert('이름을 입력하세요.');
      f.name.focus();
      return false;
    }
    if (f.title.value == '') {
      alert('제목을 입력하세요.');
      f.title.focus();
      return false;
    }
    if (f.content.value == '') {
      alert('내용을 입력하세요.');
      f.content.focus();
      return false;
    }
    if(f.passwd.value == ''){
      alert("암호를 입력하세요.")
      f.passwd.focus();
      return false;
    }
    if(f.gender[0].checked==false && f.gender[1].checked==false){
      alert("성별을 체크해주세요.")
      f.gender[0].focus();
      return false;
    }
    
    var check = 0;
  	for (var i = 0; i < f.part.length; i++) {
		if(f.part[i].checked){
		  check++;
		}
    }
	if (check == 0){
	  alert("보유기술 체크하세요");
	  f.part[0].focus();
	  return false;
	}
  }
</script>
</head>
<body>
<jsp:include page="/menu/top.jsp"/>
	<div class="container" style="color:white;">
		<h2>방명록 글 등록</h2><hr>
		<form class="form-horizontal" method="post" action="createProc.jsp" onsubmit="return incheck(this)">
			<div class="form-group">
				<label class="control-label col-sm-2" for="name">이름</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="name"
						placeholder="Enter name" name="name">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="title">제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="title"
						placeholder="Enter title" name="title">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="content">내용</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="content" name="content" placeholder="Enter content" rows="10"></textarea>
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
						name="gender" value="남자">남자
					</label> <label class="radio-inline"> <input type="radio"
						name="gender" value="여자">여자
					</label>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2">분야</label>
				<div class="col-sm-10">
					<label class="checkbox-inline"> <input type="checkbox"
						name="part" value="JAVA">JAVA
					</label> <label class="checkbox-inline"> <input type="checkbox"
						name="part" value="JSP">JSP
					</label> <label class="checkbox-inline"> <input type="checkbox"
						name="part" value="C#">C#
					</label> <label class="checkbox-inline"> <input type="checkbox"
						name="part" value="HADOOP">HADOOP
					</label> <label class="checkbox-inline"> <input type="checkbox"
						name="part" value="R">R
					</label>
				</div>
			</div>
			<div class="form-group">
			<div class="col-sm-offset-2 col-sm-5">
				<button class="btn btn-default">등록</button>
				<button class="btn btn-default" type="reset">취소</button>			
				<button class="btn btn-default" type="button" onclick="location.href='./list.jsp'" >목록</button>
			</div>
			</div>
		</form>
	</div>
</body>
</html>