<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	table {
		border-collapse: collapse;
	}
	
	tr td {
		border: 1px solid black;
		text-align: center;
		padding: 5px;
	}
	
	input[type="button"] {
		width: 100%;
	}
</style>
<script src="<c:url value='/resources/js/common.js'/>"></script>
<script>
	window.addEventListener("load", init,false)
	function init(){
		//등록 버튼 클릭시
		writeBtn.addEventListener("click", function(e) {
			e.preventDefault();



			document.getElementById("boardVO").submit();
		})
		//취소 버튼 클릭시
		cancelBtn.addEventListener("click", function(e) {
			e.preventDefault();
			document.getElementById("boardVO").reset();
			
		})
		//목록 버튼 클릭시
		listBtn.addEventListener("click", function(e) {
			e.preventDefault();
            let returnPage = e.target.getAttribute("data-returnPage")
			location.href= getContextPath() + "/board/" + returnPage;
		},false)

	}
</script>
<body>
 <table style="border:1px solid black;">
    <form:form action="${pageContext.request.contextPath }/board/write/${returnPage }"
    		   enctype="multipart/form-data"
    		   method="post"
    		   modelAttribute="boardVO">
      <colgroup">
        <col width="10%">
        <col width="50%">
        <col width="10%">
        <col width="10%">
        <col width="10%">
      </colgroup>
      <caption>게시글 작성</caption>
      <tr>
        <td><form:label path="boardCategoryVO.cid" for="">분류</form:label></td>
        <td colspan="4">
          <form:select path="boardCategoryVO.cid" style="width: 100%;">
            <option value="0">=====선택=====</option>
            <form:options path="boardCategoryVO.cid"
            		 	  items="${boardCategoryVO}"
            		 	  itemValue="cid"
            		 	  itemLabel="cname"/>
          </form:select>
        </td>
      <tr>
        <td colspan="5"><form:errors path="boardCategoryVO.cid"></form:errors></td>
      </tr>
      <tr>
        <td><form:label path="btitle">제목</form:label></td>
        <td colspan="4"><form:input type="text" style="width: 100%;" path="btitle"/></td>
      </tr>
      <tr>
      	<td colspan="5"><form:errors path="btitle"></form:errors></td>
      </tr>
      <tr>
        <td><form:label path="bid">작성자</form:label></td>
        <td colspan="4"><form:input type="text" style="width: 100%;" readonly="true" path="bid"/></td>
        <%-- <td colspan="4">${sessionScope.member.nickname}(${sessionScope.member.id}님)</td> --%>
      </tr>
      <tr>
        <td><form:label path="bnickname">별칭</form:label></td>
        <td colspan="4"><form:input type="text" style="width: 100%;" readonly="true" path="bnickname"/></td>
      </tr>
      <tr>
        <td><form:label path="bcontent">내용</form:label></td>
        <td colspan="4"><form:textarea rows="10" cols="100" style="width: 99%;" path="bcontent"/></td>
      </tr>
      <tr>
      	<td colspan="5"><form:errors path="bcontent"></form:errors></td>
      </tr>
      
      <tr>
        <td><form:label path="files">첨부</form:label></td>
        <td colspan="2"></td>
        <td colspan="2"><form:input type="file" multiple="multiple" path="files"/></td>
      </tr>
      <tr>
      	<form:errors path="files"></form:errors>
      </tr>
      
      <tr>
        <td colspan="2"></td>
        <td><form:button id="writeBtn">등록</form:button></td>
        <td><form:button id="cancelBtn">취소</form:button></td>
        <td><form:button id="listBtn" data-returnPage="${returnPage }">목록</form:button></td>
      </tr>
    </form:form>
  </table>
  
</body>
</html>