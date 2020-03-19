<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>        
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link rel="stylesheet" href="<c:url value='/resources/css/findPW.css' />">
<script src="<c:url value='/resources/js/common.js' />"></script>
<script src="<c:url value='/resources/js/findPW.js' />"></script>
</head>
<body>
  <div class="container">
  <table>
    <caption><h3>비밀번호 찾기</h3></caption>
    <colgroup>
      <col width="30%">
      <col width="70%">
    </colgroup>
    <thead>
      <tr>
        <th>아 이 디</th>
        <td><input type="text" name="id" id="id"></td>
      </tr>
      <tr><td colspan="2" class="errmsg" id="id_errmsg"></td></tr>
      <tr>
        <th>전화번호</th>
        <td><input type="tel" name="tel" id="tel"></td>
      </tr>
      <tr><td colspan="2" class="errmsg" id="tel_errmsg"></td></tr>
      <tr>
        <th>생년월일</th>
        <td><input type="date" name="birth" id="birth"></td>
      </tr>
      <tr><td colspan="2" class="errmsg" id="birth_errmsg"></td></tr>
      <tr class="hide">
        <th>비밀번호</th>
        <td><input type="password" name="pw" id="pw"></td>
      </tr>
      <tr class="hide"><td colspan="2" class="errmsg" id="pw_errmsg"> </td></tr>
      <tr class="hide">
        <th>비밀번호확인</th>
        <td><input type="password" name="pwchk" id="pwChk"></td>
      </tr>
      <tr class="hide"><td colspan="2" class="errmsg" id="pwChk_errmsg"> </td></tr>
      <tr>
        <td colspan="2"><button id="findBtn">비밀번호찾기</button></td>
      </tr>
    </thead>    
  </table>
  </div>
</body>
</html>