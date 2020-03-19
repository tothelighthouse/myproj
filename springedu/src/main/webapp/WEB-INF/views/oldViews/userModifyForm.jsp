<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
  <style>
    table{
      border-collapse: collapse;
    }
    tr td{
      border: 1px solid black;
      text-align: center;
      padding: 5px;
    }
    input[type="button"]{
      width: 100%;
    }
    .imgContainer{
    	width: 20px;
    	height: 20px;
    }
  </style>

<body>
 <table style="border:1px solid black;">
    <form action="${pageContext.request.contextPath }/board/modify/${boardVO.bnum}" method="post">
      <colgroup">
        <col width="10%">
        <col width="50%">
        <col width="10%">
        <col width="10%">
        <col width="10%">
      </colgroup>
      <caption>게시글 수정</caption>
      <tr>
        <td>분류</td>
        <td colspan="4">
          <select name="boardCategoryVO.cid" style="width: 100%;">
            <option value="1004">SPRING</option>
            <option value="1005">DATABASE</option>
            <option value="1006">JAVA</option>
          </select>
        </td>
      </tr>
      <tr>
        <td>제목</td>
        <td colspan="4"><input type="text" style="width: 100%;" name="btitle" value="${boardVO.btitle }"></td>
      </tr>
      <tr>
        <td>작성자</td>
        <td colspan="4">${sessionScope.member.nickname}(${sessionScope.member.id}님)</td>
      </tr>
      <tr>
        <td>내용</td>
        <td colspan="4"><textarea rows="10" cols="100" style="width: 99%;" name="bcontent">${boardVO.bcontent }</textarea></td>
      </tr>
      <tr>
        <td>첨부</td>
		<td>
			<c:forEach var="file" items="${files}">
				<%-- <p>${file.fid}</p> --%>
				<%-- <p>${file.bnum}</p> --%>
				<p>파일 이름 : ${file.fname} 파일 크기 : ${file.fsize}</p>
				<p>파일 타입 : ${file.ftype}</p>
				<c:if test="${file.ftype  eq 'image/jpeg'|| 
							  file.ftype  eq 'image/png'||
							  file.ftype  eq 'image/gif' && file.fsize < 3*1024}">
					<div id="imgContainer"><img width="100%" height="100%" src="${pageContext.request.contextPath }/board/file/${file.fid}" alt=""/></div>
				</c:if>
			<a href="${pageContext.request.contextPath }/board/file/${file.fid}">${file.fname }다운로드</a>
			</c:forEach>
		</td>
        <td colspan="3"><input type="button" value="파일 업로드"></td>
      </tr>
      <tr>
        <td colspan="2"></td>
        <td><input type="submit" value="수정"></td>
        <td><a href="${pageContext.request.contextPath }/board/writeForm"><input type="button" value="취소"></a></td>
        <td><a href="${pageContext.request.contextPath }/board"><input type="button" value="목록"></a></td>
      </tr>
    </form>
  </table>
</body>
</html>