<%@ page contentType="text/html; charset=UTF-8" %> 
<%
 	String c_id = "";     // ID 저장 여부를 저장하는 변수, Y
 	String c_id_val = ""; // ID 값
  
 	Cookie[] cookies = request.getCookies(); 
 	Cookie cookie=null; 
  
 	if (cookies != null){ 
  		for (int i = 0; i < cookies.length; i++) { 
    		cookie = cookies[i]; 
  
    	if (cookie.getName().equals("c_id")){ 
     		c_id = cookie.getValue();		// Y 
    	}else if(cookie.getName().equals("c_id_val")){ 
  			c_id_val = cookie.getValue(); 	// user1... 
 			}
 		}
 	}
 %>
<!DOCTYPE html> 
<html> 
<head>
<title>로그인</title>
<meta charset="utf-8">
<script type="text/javascript">
function idSearch(){
	var url = "idSearch.jsp";

	wr = window.open(url,"아이디찾기","width=500,height=500");
	wr.moveTo((window.screen.width-500)/2,(window.screen.height-500)/2);
}

function pwSearch(){
	var url = "pwSearch.jsp";

	wr = window.open(url,"비밀번호찾기","width=500,height=500");
	wr.moveTo((window.screen.width-500)/2,(window.screen.height-500)/2);
}
</script>
</head>
<body>
	<jsp:include page="/menu/top.jsp"/>
	<div class="container" style="color:white;">
	<h2>로그인</h2><hr>
		<form class="form-horizontal" method="post" action="loginProc.jsp">

			<div class="form-group">
				<label class="control-label col-sm-2" for="id">아이디</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="id" name="id"
						value='<%=c_id_val %>' />
				</div>
				<div class="col-sm-4">
					<%
						if (c_id.equals("Y")) { // id 저장 상태라면
					%>
					<label class="checkbox">
					<input type='checkbox' name='c_id' value='Y' checked='checked'>
					ID 저장
					</label>
					
					<%	} else {%>
					<label class="checkbox">
					<input type='checkbox' name='c_id' value='Y'> ID 저장
					</label>
					<%
						}
					%>
					
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="passwd">비밀번호</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="passwd"
						name="passwd" required="required" />
				</div>
			</div>
			<div class="form-group">
			<div class="col-sm-offset-2 col-sm-7">
			<button class="btn btn-default">로그인</button>
			<button type="button" class="btn btn-default"
					onclick="location.href='agreement.jsp'">회원가입</button>
			<button type="button" class="btn btn-default" onclick="idSearch()">아이디찾기</button>
			<button type="button" class="btn btn-default" onclick="pwSearch()">비밀번호찾기</button>
			</div>
			</div>
		</form>
	</div>
</body> 
</html> 