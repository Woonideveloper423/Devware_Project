<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://kit.fontawesome.com/f7fe0761ae.js" crossorigin="anonymous"></script>
<script type="text/javascript">
$(function(){

		receiveMailList();
		
		$(document).on("click","#select_all", function(){
			if($(this).html() == '전체 선택'){
				$(".deleteCheck").prop("checked", true);
				$(this).html('전체 해제');
			}else{
				$(".deleteCheck").prop("checked", false);
				$(this).html('전체 선택');
			}
		});
		
		$(document).on("click","#delete_mail", function(){
			console.log($('input:checkbox[name="cancel"]').is(":checked"));
			if($(".deleteCheck").is(":checked") == false){
				alert("적어도 한개 이상의 메일을 선택해주세요");
			}else{
				$("#select_all").html('전체 선택');
				delete_mail($(".curPage").val());
			}
		});
		
		$(document).on("click","#searchResult", function(){
			receiveMailList($(".curPage").val());
		});
		
		$(document).on("click","#restore_mail", function(){
			restore_mail($(".curPage").val());
		});
		
		$(document).on("click","#delete_not_read", function(){
			delete_not_read($(".curPage").val());
		});
		
		$(document).on("click",".mailDetail", function(event){
			mailDetail($(this).attr('name'));
		});
		
		
		$(document).on("click",".mailImportant", function(event){
			//mailImportant($(this).attr('name'), $(this).attr('id'));
			mailImportant($(".curPage").val(), $(this).attr('name'), $(this).attr('id'));
			/* if($(this).attr('id') == "important"){
				$(this).removeClass('important').addClass('notImportant');
			}else{
				$(this).removeClass('notImportant').addClass('important')
			} */

			event.stopPropagation();
		});
		
		$(document).on("click","#prev", function(){
			var prevNum = parseInt($(".pageNum:first").val())-1;
			receiveMailList(prevNum);
		});
		
		$(document).on("click","#next", function(){
			var nextNum = parseInt($(".pageNum:last").val())+1;
			receiveMailList(nextNum);
		});
		
		$(document).on("click",".pageNum", function(){
			receiveMailList($(this).val());
		});
		
	});
	
	
	function receiveMailList(pageNum) {
		var search = $("#search").val();
		var keyword= $("#keyword").val();
		$.ajax(
				{
					url:"/mail/viewMailList",
					data:{"currentPage" : pageNum,
						  "search"  : search,
						  "keyword" : keyword,
						  "mailType" : '${mailType}'},
					dataType:'json',
					success:function(data){
						showMailList(data);
					}
				}		
		);
	} 
	
	function delete_not_read(pageNum){
		var search = $("#search").val();
		var keyword= $("#keyword").val();
		$.ajax(
				{
					url:"/mail/deleteNotRead",
					data:{"currentPage" : pageNum,
						  "search"  : search,
						  "keyword" : keyword,
						  "mailType" : '${mailType}'},
					dataType:'json',
					success:function(data){
						showMailList(data);
					}
				}		
		);
	}
	
	function delete_mail(pageNum){
		var search = $("#search").val();
		var keyword= $("#keyword").val();
		var lists = [];
		$("input[name='deleteCheck']:checked").each(function(i){   //jQuery로 for문 돌면서 check 된값 배열에 담는다
		 lists.push($(this).val());
		});
		$.ajax(
				{
					url:"/mail/deleteMail",
					data:{"currentPage" : pageNum,
						  "search"  : search,
						  "keyword" : keyword,
						  "deleteArray" : lists,
						  "mailType" : '${mailType}'},
					dataType:'json',
					success:function(data){
						showMailList(data);
					}
				}		
		);
	}
	
	function restore_mail(pageNum){
		var search = $("#search").val();
		var keyword= $("#keyword").val();
		var lists = [];
		$("input[name='deleteCheck']:checked").each(function(i){   //jQuery로 for문 돌면서 check 된값 배열에 담는다
		 lists.push($(this).val());
		});
		$.ajax(
				{
					url:"/mail/restore_mail",
					data:{"currentPage" : pageNum,
						  "search"  : search,
						  "keyword" : keyword,
						  "deleteArray" : lists,
						  "mailType" : '${mailType}'},
					dataType:'json',
					success:function(data){
						showMailList(data);
					}
				}		
		);
	}
	
	 function mailImportant(pageNum, mailNum, isImportant){
		var search = $("#search").val();
		var keyword= $("#keyword").val();
		$.ajax(
				{
					url:"/mail/mailImportant",
					data:{"currentPage" : pageNum,
						  "search"  : search,
						  "keyword" : keyword,
						  "mailNum" : mailNum,
						  "isImportant" : isImportant,
						  "mailType" : '${mailType}'},
					dataType:'json',
					success:function(data){
						showMailList(data);
					}
				}		
		);
	} 
	
	/* function mailImportant(mailNum, isImportant){
		$.ajax(
				{
					url:"/mailImportant",
					data:{
						  "mailNum" : mailNum,
						  "isImportant" : isImportant},
					dataType:'text',
					success:function(data){
						console.log(data);
					}
				}		
		);
	} */
	
 	function mailDetail(mail_num){
 		var sendFrmName = "frm" + mail_num;
 		console.log(mail_num);
 		console.log(sendFrmName);
 		$("#"+sendFrmName).submit();
	}
	
	function showMailList(data){
		var mailType = parseInt('${mailType}');
		$("#mailList").empty();
		$("#paging").empty();
		var str ="";
		$(data.mailList).each(
				function(index){
					str2 = "<tr class='mailDetail' name='" + this.mail_num +"'>";
					//str2 += "<form action='mailDetail' id='frm" + this.mail_num + "' method='post'>"
					
					//create element (form)
					var frmName = "frm" + this.mail_num
					var frmName = $('<form></form>');
					//set attribute (form) 
					frmName.attr("name","frm" + this.mail_num);
					frmName.attr("id","frm" + this.mail_num);
					frmName.attr("method","post");
					frmName.attr("action","/mail/mailDetail");
					frmName.attr("target","_self");
					
					// create element & set attribute (input) 
					frmName.append($('<input/>', {type: 'hidden', name: 'mailType', value:'${mailType}' }));
					frmName.append($('<input/>', {type: 'hidden', name: 'mail_num', value: this.mail_num }));
					frmName.append($('<input/>', {type: 'hidden', name: 'sender_mail', value:this.sender_mail }));
					frmName.append($('<input/>', {type: 'hidden', name: 'sender_name', value:this.sender_name }));
					frmName.append($('<input/>', {type: 'hidden', name: 'receiver_mail', value:this.receiver_mail }));
					frmName.append($('<input/>', {type: 'hidden', name: 'receiver_name', value:this.receiver_name }));
					frmName.append($('<input/>', {type: 'hidden', name: 'mail_title', value:this.mail_title }));
					frmName.append($('<input/>', {type: 'hidden', name: 'mail_content', value:this.mail_content }));
					
					/* str2 += "<input form='frm" + this.mail_num + "' type='hidden' name='mailType' value='" + '${mailType}' + "'>";
					str2 += "<input form='frm" + this.mail_num + "' type='hidden' name='mail_num' value='" + this.mail_num + "'>";
					str2 += "<input form='frm" + this.mail_num + "' type='hidden' name='sender_mail' value='" + this.sender_mail + "'>";
					str2 += "<input form='frm" + this.mail_num + "' type='hidden' name='sender_name' value='" + this.sender_name + "'>";
					str2 += "<input form='frm" + this.mail_num + "' type='hidden' name='receiver_mail' value='" + this.receiver_mail + "'>";
					str2 += "<input form='frm" + this.mail_num + "' type='hidden' name='receiver_name' value='" + this.receiver_name + "'>";
					str2 += "<input form='frm" + this.mail_num + "' type='hidden' name='mail_title' value='" + this.mail_title + "'>";
					str2 += "<input form='frm" + this.mail_num + "' type='hidden' name='mail_content' value='" + this.mail_content + "'>";  */
					//str2 += "<input form='frm" + this.mail_num + "' type='hidden' name='mail_date' value='" + this.mail_date + "'>";
					for(var i=0 ; i < data.mailAttaches[index].length ; i ++){
						frmName.append($('<input/>', {type: 'hidden', name: 'mail_attach_save_path', value:data.mailAttaches[index][i].mail_attach_save_path }));
						frmName.append($('<input/>', {type: 'hidden', name: 'mail_attach_save_name', value:data.mailAttaches[index][i].mail_attach_save_name }));
						frmName.append($('<input/>', {type: 'hidden', name: 'mail_attach_real_name', value:data.mailAttaches[index][i].mail_attach_real_name }));
						/* str2 += "<input form='frm" + this.mail_num + "' type='hidden' name='mail_attach_save_path' value='" + data.mailAttaches[index][i].mail_attach_save_path + "'>";
						str2 += "<input form='frm" + this.mail_num + "' type='hidden' name='mail_attach_save_name' value='" + data.mailAttaches[index][i].mail_attach_save_name + "'>";
						str2 += "<input form='frm" + this.mail_num + "' type='hidden' name='mail_attach_real_name' value='" + data.mailAttaches[index][i].mail_attach_real_name + "'>";
						str2 += "<input form='frm" + this.mail_num + "' type='hidden' name='mail_attach_type' value='" + data.mailAttaches[index][i].mail_attach_type + "'>"; */
					}
					
					// append form (to body) 
					frmName.appendTo('body');
					
					str2 += "<td><input onclick='event.stopPropagation(true)' type='checkbox' name='deleteCheck' class='deleteCheck' value='" + this.mail_num +  "'></td>";
					if(mailType != 3){
						if(this.isImportant == '1'){
							console.log(this.mail_num);
							str2 += "<td><i class='fa-solid fa-star mailImportant' name='" + this.mail_num + "' id='important'></i></td>";
						}else{
							console.log(this.mail_num);
							str2 += "<td><i class='fa-regular fa-star mailImportant' name='" + this.mail_num + "' id='notImportant'></i></td>";
						}
					}
					if(mailType == 0){
						str2 += "<td>" + this.receiver_mail + "</td><td>";
					}else if(mailType == 1){
						if(this.read_chk == '0'){
							str2+="<td onclick='event.stopPropagation(true)'><i class='fa-sharp fa-solid fa-envelope'></i></td><td>";
						}else if(this.read_chk == '1'){
							str2+="<td onclick='event.stopPropagation(true)'><i class='fa-regular fa-envelope-open'></i></td><td>";
						}
						str2 += this.sender_mail + "</td><td>";
					}else if(mailType == 2){
						str2 += "<td>"+ this.sender_mail + "</td><td>";
					}else if(mailType == 3){
						str2 += "<td>"+ this.sender_mail + "</td><td>";
					}
					if(data.mailAttaches[index].length != 0){
						str2 += "<i class='fa-solid fa-paperclip'></i>"
					}
					
					str2 += this.mail_title + "</td><td>" + this.mail_date + "</td></tr>";
					str += str2;
				}		
		)
		$('#mailList').append(str);
		var pageInfo = "";
		var startPage = parseInt(data.paging.startPage);
		var endPage   = parseInt(data.paging.endPage);
		var blockSize   = parseInt(data.paging.pageBlock);
		var pageCnt = parseInt(data.paging.totalPage);
		var currentPage = parseInt(data.paging.currentPage)
		if(startPage > blockSize){
			pageInfo+="<input id='prev' class='page-item' type='button' value='<'>";
		}
		for(startPage ; startPage<=endPage ; startPage++){
			if(startPage == currentPage){
				pageInfo+="<input class='pageNum curPage page-item' type='button' value='" + startPage +"'>";
			}else{
				pageInfo+="<input class='pageNum page-item' type='button' value='" + startPage +"'>";
			}
		}
		if(endPage < pageCnt){
			pageInfo+="<input id='next' class='page-item' type='button' value='>'>";
		}
		$('#paging').html(pageInfo);
		
	}
	
	
</script>
<body>
<div class="body_box">
	<div class="titlebox" align="center">
		<c:if test="${mailType eq '0'}">
			<h2>보낸 메일함</h2>
			<button id='select_all'>전체 선택</button><button id='delete_mail'>선택삭제</button>
		</c:if>
		<c:if test="${mailType eq '1'}">
			<h2>받은 메일함</h2>
			<button id='select_all'>전체 선택</button><button id='delete_mail'>선택삭제</button><button id='delete_not_read'>안 읽은 메일 삭제</button>
		</c:if>
		<c:if test="${mailType eq '2'}">
			<h2>중요 메일함</h2>
			<button id='select_all'>전체 선택</button><button id='delete_mail'>선택삭제</button>
		</c:if>
		<c:if test="${mailType eq '3'}">
			<h2>휴지통</h2>
			<button id='select_all'>전체 선택</button><button id='delete_mail'>선택삭제</button><button id='restore_mail'>복원</button>
		</c:if>
	</div>
	<div class="s003">
		
			<div class="inner-form">
		          <div class="input-field first-wrap">
		            <div class="input-select">
		           	 <select id="search">
						<option value="s_title">제목</option>
						<option value="s_content">내용</option>
						<option value="s_mail">메일</option>
					</select>
					</div>
				</div>
			</div>
			<div class="input-field second-wrap">
				<input type="text" id="keyword" placeholder="검색어를 입력하세요">
			</div>
	</div>
	<div class="input-field third-wrap">
		<button class="btn-search" id="searchResult">검색</button><p>
	</div>
	<table id="mailList" style="margin-top: 20px"  class="table table-hover">
	</table>
	<div id="paging" class="pagination pagination-lg justify-content-center"></div>
	
</div>
</body>
</html>