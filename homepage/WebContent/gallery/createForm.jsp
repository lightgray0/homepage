<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_gallery.jsp" %>

<!DOCTYPE html> 
<html> 
<head>
<title>갤러리 작품 등록</title>
<meta charset="utf-8">
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container" style="color:white;">
	<h2>갤러리 작품 등록</h2><hr>
		<form class="form-horizontal" method="post" action="createProc.jsp" enctype="multipart/form-data" name="frm"
				>
			<div class="form-group">
				<label class="control-label col-sm-2" for="fname">작품</label>
				<div class="col-sm-6">
					<input type="file" class="form-control" id="fname" name="fname"
							accept=".jpg,.gif,.png" />
				</div>
			</div>		
			<div class="form-group">
				<label class="control-label col-sm-2" for="iname">작가</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="iname" name="iname" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="title">작품명</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="title" name="title" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="content">설명</label>
				<div class="col-sm-6">
					<textarea class="form-control" 
								id="content" name="content" rows="10"></textarea>
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
					<button type="submit" class="btn btn-default">등록</button>
					<button type="reset" class="btn btn-default">취소</button>
					<button type="button" class="btn btn-default" onclick="location.href='./list.jsp'">목록</button>
				</div>
			</div>
			
		</form>
	</div>
</body> 
</html> 