<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
  <meta charset="UTF-8">
  <!-- 뷰포트 추가 -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  
  <!-- BOOTSTRAP CSS -->
  <link rel="stylesheet"
        href="${pageContext.request.contextPath }/webjars/bootstrap/4.4.1-1/css/bootstrap.css">
  
  <!-- Optional JavaScript -->
  <!-- jQuery first, then Popper.js, then Bootstrap JS -->
  <script defer="defer" src="${pageContext.request.contextPath }/webjars/jquery/3.4.1/jquery.js"></script>
  <script defer="defer" src="${pageContext.request.contextPath }/webjars/popper.js/2.0.2/umd/popper.js"></script>
  <script defer="defer" src="${pageContext.request.contextPath }/webjars/bootstrap/4.4.1-1/js/bootstrap.js"></script>
  
  <style>
  /* *{
    border: solid 1px black;
  }
   */
  
  </style>
  <title>Insert title here</title>
  </head>
  <body>
    <button type="button" class="btn btn-primary btn-sm">Small button</button>
    <button type="button" class="btn btn-secondary btn-sm">Small button</button>
    
    <a href="#" class="badge badge-primary">Primary</a>
    <a href="#" class="badge badge-secondary">Secondary</a>
    <a href="#" class="badge badge-success">Success</a>
    <a href="#" class="badge badge-danger">Danger</a>
    <a href="#" class="badge badge-warning">Warning</a>
    <a href="#" class="badge badge-info">Info</a>
    <a href="#" class="badge badge-light">Light</a>
    <a href="#" class="badge badge-dark">Dark</a>
    
    <form>
    <div class="form-group">
      <label for="exampleInputEmail1">Email address</label>
      <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
      <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">Password</label>
      <input type="password" class="form-control" id="exampleInputPassword1">
    </div>
    <div class="form-group form-check">
      <input type="checkbox" class="form-check-input" id="exampleCheck1">
      <label class="form-check-label" for="exampleCheck1">Check me out</label>
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>
    
  
  </body>
</html>