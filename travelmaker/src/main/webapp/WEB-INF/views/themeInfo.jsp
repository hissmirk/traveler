<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/adminheader.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

지역<br>
테마<br>

<button id="searchBtn" class="btn btn-sm- btn-primary" 
onClick = "location.href='/admin/modifyTheme/${themeNo}'">수정하기</button>	

<table  class="table table-bordered" id="dataTable" style="width:70%">
<tr>
	<th>장소번호</th>
	<th>장소명</th>
</tr>

<c:forEach items="${list}" var="list">
	<tr name = row id = '<c:out value="${list.plcNo}" />'>
	<td><c:out value="${list.plcNo}" /></td>
		<td><c:out value="${list.plcTitle}" /></td>
	</tr>
</c:forEach>
</table>


<script>

$(document).ready(function() {
$("tr[name=row]").click(function(){
	
	const plcNum = $(this).attr("id");

	let URL = "https://place.map.kakao.com/"+plcNum;
	
	window.open(URL, "카카오 지도", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
	
})

})

</script>

<%@ include file="includes/adminfooter.jsp"%>