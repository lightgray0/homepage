<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<title>기본 페이지</title>
<meta charset="utf-8">
<style>
/* Make the image fully responsive */
.carousel-inner img {
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
	<jsp:include page="/menu/top.jsp" />
	<div class="container">
		<h1 style="color: white;">Welcome to my Trip Story</h1>
		<hr>
		<p style="font-size: 20px; color: white;"></p>
		<div class="row">
			<div class="col-sm-6">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
						<li data-target="#myCarousel" data-slide-to="3"></li>
						<li data-target="#myCarousel" data-slide-to="4"></li>
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner">
						<div class="item active">
							<img src="./images/photo1.jpg" alt="pho1" width="400px"
								height="300px" >
						</div>

						<div class="item">
							<img src="./images/photo2.jpg" alt="pho2" width="400px"
								height="300px" >
						</div>

						<div class="item">
							<img src="./images/photo3.jpg" alt="pho3" width="400px"
								height="300px" >
						</div>
					
						<div class="item">
							<img src="./images/photo4.jpg" alt="pho4" width="400px"
								height="300px" >
						</div>

						<div class="item">
							<img src="./images/photo5.jpg" alt="pho5" width="400px"
								height="300px" >
						</div>
					</div>

					<!-- Left and right controls -->
					<a class="left carousel-control" href="#myCarousel"
						data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#myCarousel"
						data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
			</div>
			<div class="col-sm-6">
				<iframe width="100%" height="310px"
					src="https://youtube.com/embed/N1-Jmq7BLFE"> </iframe>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-sm-6">
				<iframe width="100%" height="310px"
					src="https://youtube.com/embed/FCPdIvXo2rU"> </iframe>
			</div>
			<div class="col-sm-6">
				<div id="myCarousel2" class="carousel slide" data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#myCarousel2" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel2" data-slide-to="1"></li>
						<li data-target="#myCarousel2" data-slide-to="2"></li>
						<li data-target="#myCarousel2" data-slide-to="3"></li>
						<li data-target="#myCarousel2" data-slide-to="4"></li>
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner">
						<div class="item active">
							<img src="./images/photo6.jpg" alt="pho6" width="400px"
								height="300px">
						</div>

						<div class="item">
							<img src="./images/photo7.jpg" alt="pho7" width="400px"
								height="300px">
						</div>

						<div class="item">
							<img src="./images/photo8.jpg" alt="pho8" width="400px"
								height="300px">
						</div>

						<div class="item">
							<img src="./images/photo9.jpg" alt="pho9" width="400px"
								height="300px">
						</div>

						<div class="item">
							<img src="./images/photo10.jpg" alt="pho10" width="400px"
								height="300px">
						</div>
					</div>

					<!-- Left and right controls -->
					<a class="left carousel-control" href="#myCarousel2"
						data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#myCarousel2"
						data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
		