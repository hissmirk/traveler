<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>


  <!-- Page Content -->
  <div class="container">
<div class="black_bg"></div>
    <div class="row">

      <div class="col-lg-3">

        <h1 class="my-4">메뉴메뉴</h1>
        <div class="list-group">	
          <a href="/mypage/pickPL" class="list-group-item">찜한장소</a>
          <a href="/mypage/pickSch" class="list-group-item">찜한일정</a>
          <a href="/mypage/past" class="list-group-item">지나간여행</a>
          <a href="/mypage/upcomming" class="list-group-item">다가올여행</a>
        </div>

      </div>
      <!-- /.col-lg-3 -->
<!-- col-lg-9(content) -->
      <div class="col-lg-9" style="padding-top: 20px;">
        <div class="row">

<c:forEach items="${list }" var="sch">
          <div class="col-lg-4 col-md-6 mb-4">
            <div class="card h-100">
            <a class='move' href='<c:out value="${sch.schNo }"/>'>
           <img class="card-img-top" src="http://placehold.it/700x400" alt="">
           </a>
              <div class="card-body">
                <h4 class="card-title">
                   <a class='move' href='<c:out value="${sch.schNo }"/>'>
                   <c:out value="${sch.schTitle }"></c:out>
                   </a>
                   
                </h4>
             
                
             <!-- Like  -->
             <!-- <i class="fa fa-heart-o" style="font-size:24px;color:red"></i>
             <i class="fa fa-heart" style="font-size:24px;color:red"></i> -->
               <div style="float:right;" class="heart">
       <a data-sch_no="${sch.schNo }">
          <i id="heart"  class="fa fa-heart" style="font-size:24px;color:red"></i>
       </a>
   </div>
             <!-- Like end -->
              </div>
              <div class="card-footer">
                <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
              </div>
            </div>
          </div>
</c:forEach>

<form id='actionForm' action="/mypage/pickSch" method='get'>
	<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
	<input type='hidden' name='amount' value = '${pageMaker.cri.amount }'>
</form>
        </div>
        <!-- /.row -->
 <div style="text-align: center;">
<ul class="pagination">
<c:if test="${pageMaker.prev }">
<li class="paginate_button previous"><a href="${pageMaker.startPage-1 }">Previous</a></li>
</c:if>

<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }">
<a href="${num}"> ${num }</a></li>
</c:forEach>

<c:if test="${pageMaker.next }">
<li class="paginate_button next">
<a href="${pageMaker.endPage +1 }">Next</a></li>
</c:if>
</ul>
</div>
      </div> 
      <!-- /.col-lg-9 -->


<script type="text/javascript">
	$(document).ready(function(){
		
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click",function(e){
			
			e.preventDefault();
			
			console.log('click');
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		$(".move").on("click",function(e){
			
			e.preventDefault();
		actionForm.append("<input type='hidden' name='sch_no' value='"+
				$(this).attr("href")+"'>");
			actionForm.attr("action","/mypage/pickSch/get");
			actionForm.submit();
			
		})
		
		//좋아요 취소하는 버튼
		$(".heart a").on("click", function() {

			$(this).hide(30);
			var that = $(".heart");
			var sendData = {
				'sch_no' : $(this).data('sch_no'),
				'heart' : 1
			}
			$.ajax({
				type : 'post',
				url : '/mypage/heartSch',
				data : sendData,
				success : function(data) {
					
					alert("목록에서 삭제되었습니다.")
					location.reload();
				}
			});
		});
		
	});
	

</script>   
<%@include file="../includes/footer.jsp" %>