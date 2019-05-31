<%@ page contentType="text/html; charset=UTF-8" %> 
<%
 	String root = request.getContextPath();
 	String id = (String)session.getAttribute("id");
 	String grade = (String)session.getAttribute("grade");
 	
 	String str = "Home";
 	if (id != null && !grade.equals("A")) {
 		str = id+"'s Home";
 	} else if (id != null && grade.equals("A")) {
 		str = "ADMIN";
 	}
 %>
	
<!DOCTYPE html> 
<html> 
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body style="background-image: url('<%=root%>/images/background.jpg'); background-repeat: no-repeat; background-size: 2000px;">
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a href="<%=root %>/index.jsp"class="navbar-brand"><%=str %></a>
			</div>
			<ul class="nav navbar-nav">
				<li><a href="<%=root%>/bbs/list.jsp">Board</a></li>
				<li><a href="<%=root%>/guestbook/list.jsp">GuestBook</a></li>
				<li><a href="<%=root%>/gallery2/list.jsp">Gallery</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
			 <% if(id==null){ %>
				<li><a href="<%=root%>/member/agreement.jsp"><span
						class="glyphicon glyphicon-user"></span>SignUp</a></li>
				<li><a href="<%=root%>/member/loginForm.jsp"><span
						class="glyphicon glyphicon-log-in"></span>Login</a></li>
		<%} else {%>
				<li><a href="<%=root%>/member/read.jsp"><span
						class="glyphicon glyphicon-user"></span>MyInfo</a></li>
				<li><a href="<%=root%>/member/updateForm.jsp"><span
						class="glyphicon glyphicon-user"></span>Modify</a></li>
			<%if(id!=null&&grade.equals("A")){%> 
				<li><a href="<%=root %>/admin/list.jsp"><span
						class="glyphicon glyphicon-th-list"></span>List</a></li>
			<% } %>
				<li><a href="<%=root%>/member/logout.jsp"><span
						class="glyphicon glyphicon-log-out"></span>Logout</a></li>
		<%} %>
			</ul>
		</div>
	</nav>
</body>
</html> 