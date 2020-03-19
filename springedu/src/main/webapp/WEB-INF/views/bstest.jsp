<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- BOOTSTRAP CSS -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath }/webjars/bootstrap/4.4.1-1/css/bootstrap.css">

<title>Insert title here</title>



</head>
<body>

<div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleCaptions" data-slide-to="0" ></li>
    <li data-target="#carouselExampleCaptions" data-slide-to="1" class="active"></li>
    <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="https://cdn.pixabay.com/photo/2020/02/20/20/55/snowdrop-4865866__340.jpg" class="d-block w-100" alt="...">
      <div class="carousel-caption d-none d-md-block">
        <h5>First slide label</h5>
        <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="https://cdn.pixabay.com/photo/2020/02/15/18/10/crocus-4851641__340.jpg" class="d-block w-100" alt="...">
      <div class="carousel-caption d-none d-md-block">
        <h5>Second slide label</h5>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="https://cdn.pixabay.com/photo/2020/02/24/16/49/butterfly-4876775__340.jpg" class="d-block w-100" alt="...">
      <div class="carousel-caption d-none d-md-block">
        <h5>Third slide label</h5>
        <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</p>
      </div>
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    
    <script src="${pageContext.request.contextPath }/webjars/jquery/3.4.1/jquery.js"></script>
    <script src="${pageContext.request.contextPath }/webjars/popper.js/2.0.2/umd/popper.js"></script>
    <script src="${pageContext.request.contextPath }/webjars/bootstrap/4.4.1-1/js/bootstrap.js"></script>

</body>
</html>




















