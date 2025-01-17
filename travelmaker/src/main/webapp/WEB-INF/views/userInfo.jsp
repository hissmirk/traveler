<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="includes/adminheader.jsp"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

			<h6 class="m-0 font-weight-bold text-primary">전체 회원 조회하기</h6>
		</div>
		<div class="card-body">
			<div class="form-group row justify-content-center">
			<div class="float-left">
				<form id='searchForm' action="/admin/userInfo" method='get'><!-- 
				<div class="w100 input-group custom-search-form" style="padding-right: 10px"> -->
				<div class="w100 input-group custom-search-form">
					<select class="form-control form-control-sm" name="type" id="type">
						<option selected disabled hidden>
						<c:if test="${criteria.type eq 'NO'}">
						회원번호
						</c:if>
						<c:if test="${criteria.type eq 'E'}">
						이메일
						</c:if>
						<c:if test="${criteria.type eq 'N'}">
						닉네임
						</c:if>
						</option>
						<option value="NO">회원번호</option>
						<option value="E">이메일</option>
						<option value="N">닉네임</option>
					</select>
 					<input type="text" class="form-control form-control-sm" placeholder="키워드를 입력하시오"
							name="keyword" id="keyword" value = '<c:out value="${criteria.keyword}"/>'>
					<span class="input-group-btn">
						<button onclick="return search()" class="btn btn-default" type="submit">
						<i class="fa fa-search"></i></button>
					</span>
				</div>
				</form>
				</div>
	
				<div class="table-responsive">
					<br><button type="button" class="btn btn-primary float-right"
						onClick="deleteUser()">강제 탈퇴</button>
					<table class="table table-hover" id="dataTable" width="100%"
						cellspacing="0">
						<thead>
							<tr>
								<th><input type="checkbox" id="th_checkAll" onclick="checkAll();" /></th>
								<th>MEM_NO</th>
								<th>EMAIL</th>
								<th>NICKNAME</th>
								<th>BIRTH</th>
								<th>GENDER</th>
								<th>STATUS</th>
								<th>REG_DATE</th>
								<th>LATEST LOGIN DATE</th>
								<th>MEM_GRADE</th>
							</tr>
						</thead>
						<tbody id="tableBody">
							<c:forEach items="${users}" var="users">
								<tr name="row" id='<c:out value="${users.memNo}" />'>
									<td><input type="checkbox" name="ChkBox" id="${users.memNo}"></td>
									<td><c:out value="${users.memNo}" /></td>
									<td id="email"><c:out value="${users.email}" /></td>
									<td id="nickname"><c:out value="${users.nickname}" /></td>
									<td id="birth"><c:out value="${users.birth}" /></td>
									<td id="gender"><c:out value="${users.gender}" /></td>
									<td id="status"><c:out value="${users.status}" /></td>
									<td id="regDate"><fmt:formatDate pattern="yyyy-MM-dd" value="${users.regDate}" /></td>
									<td id="lastDate"><fmt:formatDate pattern="yyyy-MM-dd" value="${users.lastDate}" /></td>
									<td id="memGrade"><c:out value="${users.memGrade}" /></td>
								</tr>
							</c:forEach>
						</tbody>

					</table>

					<!-- Modal -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel"></h4>
								</div>
								<div class="modal-body"></div>
								<div class="modal-footer">
									<button id="modalInBtn" type="button" class="btn btn-primary"
										data-dismiss="modal">확인</button>
									<button id="modalDefaultBtn" type="button"
										class="btn btn-primary" data-dismiss="modal">close</button>

								</div>
							</div>
							<!-- /.modal-content -->

						</div>
						<!-- /.modal-dialog -->
					</div>
					<!-- /.modal -->


					<!-- 2nd Modal -->
					<div class="modal fade" id="infoModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel"></h4>
								</div>
								<div class="modal-body">회원정보</div>
								<div class="modal-footer">
									<button id="moveBtn" type="button" class="btn btn-primary"
										data-dismiss="modal">게시글보기</button>
									<button id="removeBtn" type="button" class="btn btn-primary">강제
										탈퇴</button>
									<button id="modalInBtn" type="button" class="btn btn-primary"
										data-dismiss="modal">확인</button>
									<button id="modalDefaultBtn" type="button"
										class="btn btn-primary" data-dismiss="modal">close</button>
								</div>
							</div>
							<!-- /.modal-content -->

						</div>
						<!-- /.modal-dialog -->
					</div>


				</div>
			</div>

		</div>


<script type="text/javascript" src="/resources/js/admin.js"></script>
<script>
	$(document).ready(function() {
		const message = '<c:out value="${message}"/>';

		checkModal(message);

		history.replaceState({}, null, null);

		function checkModal(message) {

			if (message === '' || history.state) {
				
				return;
				
			}else{
				
				showModal("삭제를 완료하였습니다");
			}
		}

		const _sleep = (delay) => new Promise((resolve) => setTimeout(resolve, delay));

		const timer = async () => {
		    await _sleep(1000);
		    $("#dataTable_filter")[0].hidden=true;
		};
		
		timer();
		
	})

	function deleteUser() {

		let cnt = 0;
		let txt = "";

		for (let i = 0; i < $("input[name=ChkBox]").length; i++) {
			if ($("input[name=ChkBox]")[i].checked) {
				txt += $("input[name=ChkBox]")[i].id + ", ";
				cnt++;
			}
		}

		if (txt.length == 0) {
			
			showModal("탈퇴 처리 할 회원을 선택해주세요")

		} else {
			
			const ids = (txt.substring(0, txt.lastIndexOf(","))).split(",");
			
			showModal(cnt+"명의 회원을 강제로 탈퇴시키겠습니까?")

			$("#myModal #modalInBtn").on("click", function() {
				
				location.href = "/admin/remove/" + ids;
				
			})
		}

	};
	
	function search(){
		
		const type = $("select[id=type]").val();
		const keyword = $("input[id=keyword]").val();
		
		let msg="";
		
		if (type == ""||type==null) {
			msg = "검색할 대상을 선택하세요";
			showModal(msg);
			return false;
		}

		if (keyword == "") {
			msg = "검색할 단어를 입력하세요"
			showModal(msg);
			return false;
		}
		
		if(type =="NO"){
			if(isNaN(keyword)){
				msg = "회원번호는 숫자만 입력해주세요"
				showModal(msg);
				return false;
			}
		}
		
		if(keyword.length>100){
			msg = "검색은 100자리 이하만 가능합니다";
			showModal(msg);
			return false;
		}
		
		return true;
	}

		function showModal(msg){
			
			$(".modal-body").html(msg);
			$("#myModal").modal("show");
		};

	$("tr[name=row]").click(function() {
		
			const id = $(this).attr("id");
				
			const res = $("#" + id)[0].innerText;

			const info = (res.substring(1, res.length)).split("	");

			const output = "회원번호   :   " + info[0] + "<br>"
						+ "이메일      :   " + info[1] + "<br>"
						+ "닉네임      :   " + info[2] + "<br>"
						+ "생년월일      :   " + info[3] + "<br>"
						+ "성별      :   " + info[4] + "<br>"
						+ "상태      :   " + info[5] + "<br>"
						+ "가입일      :   " + info[6] + "<br>"
						+ "최근 로그인 날짜      :   " + info[7] + "<br>"
						+ "등급      :   " + info[8]

			$(".modal-body").html(output);
			$("#infoModal").modal("show");

			$("#removeBtn").on('click', function() {
				$(".modal-body").html("해당 회원을 강제로 탈퇴시키겠습니까?");
				$("#infoModal").modal("show");
				$("#infoModal #modalInBtn").on("click", function() {
					location.href = "/admin/remove/" + id;
				})
			})

		$("#moveBtn").on('click',function() {
			location.href = "/admin/boardList?type=NO&keyword="	+ id;})

	})

	function checkAll(event) {
		if ($("#th_checkAll").is(':checked')) {
			$("input[name=ChkBox]").prop("checked", true);
		} else {
			$("input[name=ChkBox]").prop("checked", false);
		}
	};
</script>

<%@ include file="includes/adminfooter.jsp"%>