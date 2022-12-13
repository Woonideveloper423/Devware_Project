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
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	$(function(){
		$(document).on("click",".reply_mail", function(){
			reply_mail('${mail.sender_mail }','${mail.sender_name }');
		});
		
		$(document).on("click",".delete_mail", function(){
			delete_mail('${mail.mail_num }','${mailType }');
		});
		
		$(document).on("click",".restore_mail", function(){
			restore_mail('${mail.mail_num }');
		});
		
		
		$(document).on("click",".save_attach", function(){
			//save_attach($(this).attr('id'),$(this).attr('name'));
			location.href = '/saveAttach?saveName='+ $(this).attr('id') + "&realName=" + $(this).attr('name');
		});
		
	});
	
	function reply_mail(senderMail, senderName){
		location.href = "/mail/mailWriteForm?replyMail=" + senderMail + "&replyName=" + senderName;
	}
	
	function delete_mail(mailNum, mailType){
		location.href = "/mail/deleteDetailMail?mailNum=" + mailNum + "&mailType=" + mailType;
	}
	
	function restore_mail(mailNum, mailType){
		location.href = "/mail/restoreDetailMail?mailNum=" + mailNum;
	}
	
	/* function save_attach(saveName, savePath){
		$.ajax(
				{
					url:"/saveAttach",
					data:{"saveName" : saveName,
						  "savePath"  : savePath},
					dataType:'text',
					success:function(data){
						
					}
				}		
		);
	} */

</script>
<body>
	<c:if test="${mailType eq '0'}">
		<h1>보낸 메일함</h1>
		<button class='delete_mail'>삭제</button>
	</c:if>
	<c:if test="${mailType eq '1'}">
		<h1>받은 메일함</h1>
		<button class='reply_mail'>답장</button><button class='delete_mail'>삭제</button>
	</c:if>
	<c:if test="${mailType eq '2'}">
		<h1>중요 메일함</h1>
		<button class='delete_mail'>삭제</button>
	</c:if>
	<c:if test="${mailType eq '3'}">
		<h1>휴지통</h1>
		<button class='restore_mail'>복구</button><button class='delete_mail'>영구삭제</button>
	</c:if>
	
	<div id="mail_title">
		제목 : ${mail.mail_title }
	</div><p>
	<div id="mail_sender">
		보낸이 : ${mail.sender_name }(${mail.sender_mail })
	</div><p>
	<div id="mail_receiver">
		받는이 : ${mail.receiver_name }(${mail.receiver_mail })
	</div><p>
	<div id="mail_attach">
		첨부파일 : <c:forEach var="attach" items="${mailAttaches }">
			${attach.mail_attach_real_name } <input class="save_attach" type="button" value="다운로드" id="${attach.mail_attach_save_name }" name="${attach.mail_attach_real_name }"><p>
		</c:forEach>
	</div><p>
	<div id="mail_content">
		내용 : ${mail.mail_content }
	</div>
	
	
	
</body>
</html>