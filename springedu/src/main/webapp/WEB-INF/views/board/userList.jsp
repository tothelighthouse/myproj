<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
<script src="<c:url value='/resources/js/common.js'/>"></script>
<script>
window.addEventListener("load", init,false)
function init(){
	writeBtn.addEventListener("click", function(e){
		e.preventDefault();
        let returnPage = e.target.getAttribute("data-returnPage")
		location.href=getContextPath() + "/board/writeForm/" + returnPage;
	},false)
    //검색버튼 클릭시
    searchBtn.addEventListener("click", function(e){
      e.preventDefault();
      console.log("검색!!");
      //검색어 입력값이 없으면
      if(keyword.value.trim().length == 0){
        alert("검색어를 입력하세요");
        keyword.value="";
        keyword.focus();
        return false;
      }

      let stype = searchType.value; // 검색유형
      let kword = keyword.value;    // 검색어

      location.href = getContextPath() + "/board/" + "1/" + stype + "/" + kword;
      
    },false)
}

</script>
</head>
<body>
<style>
table {
	border-top: 1px solid black;
	border-collapse: collapse;
}

tr {
	border-bottom: 1px solid black;
}

a.on {
	background-color: pink;
}

td:nth-child(1), td:nth-child(2), td:nth-child(4), td:nth-child(5), td:nth-child(6),
	td:nth-child(7), td:nth-child(8), td:nth-child(9) {
	text-align: center;
}
</style>
</head>
<body>
	<table>
	<caption><h3>게 시 판</h3></captionn>
	<colgroup>
		<col width="5%">
		<col width="5%">
		<col width="50%">
		<col width="10%">
		<col width="10%">
		<col width="5%">
		<col width="5%">
		<col width="5%">
		<col width="5%">
	</colgroup>
	<thead>
		<tr style="text-align: center">
			<th>번호</th>
			<th>분류</th>
			<th>제목</th>
			<th>아이디</th>
			<th>별명</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>삭제</th>
			<th>수정</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="rec" items="${list}">
			<fmt:formatDate value="${rec.bcdate }" pattern="yyyy/MM/dd -- HH:mm" var="cdate"/>

		<tr>
			<td>${rec.bnum }</td>
			<td>${rec.boardCategoryVO.cname }</td>
			<td>
                <c:forEach begin="1" end="${rec.bindent}">-</c:forEach>
                <c:if test="${rec.bindent > 0}">
                  <i class="fas fa-reply-all"></i>
                </c:if>
				<a href="${pageContext.request.contextPath}/board/view/${pc.rc.reqPage}/${rec.bnum }">
				${rec.btitle }
				</a>
			</td>
			<td>${rec.bid }</td>
			<td>${rec.bnickname }</td>
			<td>${cdate}</td>
			<td>${rec.bhit}</td>
			<td><a href="${pageContext.request.contextPath }/board/delete/${reqPage}/${rec.bnum}"><input type="button" value="삭제"></a></td>
			<td><a href="${pageContext.request.contextPath }/board/modifyForm/${reqPage}/${rec.bnum}"><input type="button" value="수정"></a></td>
		</tr>
		</c:forEach>
        <tr style="text-align: center">
          <td colspan="9">
          <c:if test="${pc.prev }">
			<a href="${contextRoot}/board/1/${pc.fc.searchType }/${pc.fc.keyword }"><i class="fas fa-angle-double-left"></i></a>
			<a href="${contextRoot}/board/${pc.startPage - 1}/${pc.fc.searchType }/${pc.fc.keyword }"><i class="fas fa-angle-left"></i></a>
          </c:if>
          <c:forEach var="pageNum" begin="${pc.startPage }" end="${pc.endPage }">
            <!-- 현재 페이지와 요청 페이지가 다르면 -->
            <c:if test="${pc.rc.reqPage != pageNum }">
              <c:if test="${pc.fc.searchType!=null && pc.fc.keyword!=null }">
  			   <a href="${contextRoot }/board/${pageNum}/${pc.fc.searchType }/${pc.fc.keyword }" class="off">${pageNum }</a>
              </c:if>
   
<%--   			   <a href="${contextRoot }/board/${pageNum}/" + 
                      <c:out value="${null ne pc.fc.seachType && null ne pc.fc.keword ? 'pc.fc.searchType/pc.fc.keyword':''}"/>>
               <c:out value="${null ne pc.fc.seachType && null ne pc.fc.keword ? 'pc.fc.searchType/pc.fc.keyword':''}"/>
               </a>--%>         
              <c:if test="${pc.fc.searchType==null && pc.fc.keyword==null }">
			   <a href="${contextRoot }/board/${pageNum}" class="off">${pageNum }</a>
              </c:if>
            </c:if>
            <!-- 현재 페이지와 요청페이지가 같으면 -->
            <c:if test="${pc.rc.reqPage == pageNum }">
              <c:if test="${pc.fc.searchType!=null && pc.fc.keyword!=null }">
			   <a href="${contextRoot }/board/${pageNum}/${pc.fc.searchType }/${pc.fc.keyword }" class="on">${pageNum }</a>
              </c:if>
              <c:if test="${pc.fc.searchType==null && pc.fc.keyword==null }">
			   <a href="${contextRoot }/board/${pageNum}" class="on">${pageNum }</a>
              </c:if>
            </c:if>
          </c:forEach>
          <c:if test="${pc.next }">
			<a href="${contextRoot}/board/${pc.endPage + 1 }/${pc.fc.searchType }/${pc.fc.keyword }"><i class="fas fa-angle-right"></i></a>
			<a href="${contextRoot}/board/${pc.finalEndPage }/${pc.fc.searchType }/${pc.fc.keyword }"><i class="fas fa-angle-double-right"></i></a>
          </c:if>
          </td>
        </tr>
        <tr>
          <form>
            <td>
             <select name="searchType" id="searchType">
               <option value="TC"
                <c:out value="${pc.fc.searchType == 'TC' ? 'selected' :''}" />>제목+내용</option>
               <option value="T"
                <c:out value="${pc.fc.searchType == 'T' ? 'selected' :''}" />>제목</option>
               <option value="C"
                <c:out value="${pc.fc.searchType == 'C' ? 'selected' :''}" />>내용</option>
               <option value="N"
                <c:out value="${pc.fc.searchType == 'N' ? 'selected' :''}" />>작성자</option>
               <option value="I"
                <c:out value="${pc.fc.searchType == 'I' ? 'selected' :''}" />>아이디</option>
            </select>
            </td>
            <td><input type="search" id="keyword" name="keyword" value="${pc.fc.keyword }"></td>
            <td><button id="searchBtn">검색</td>
          </form>
        </tr>
		<tr>
			<td colspan="7"></td>
			<td colspan="2"><form:button id="writeBtn" data-returnPage="${pc.rc.reqPage }">글쓰기</form:button></td>
		</tr>
		</tbody>
	</table>
	</body>
</html>














