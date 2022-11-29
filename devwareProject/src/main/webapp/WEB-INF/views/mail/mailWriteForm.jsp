<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
  <!--  jQuery, bootstrap -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
	
    <!-- summernote css/js-->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
    
    <script type="text/javascript">
	    // 메인화면 페이지 로드 함수
	   /*  $(document).ready(function () {
	        $('#summernote').summernote({
	            placeholder: '내용을 작성하세요',
	            height: 400,
	            maxHeight: 800
	        });
	    }); */
	    
	    $(function(){
			$('#receiver_mail').attr('value','${replyMail}');
			$('#receiver_name').attr('value','${replyName}');
				
			
	    	$('#summernote').summernote({
	            placeholder: '내용을 작성하세요',
	            height: 400,
	            maxHeight: 800
	        });

			
		});
	</script>
<body>
	<h1>메일 작성</h1>
	<form action="/mail/writeMail" method="post" enctype="multipart/form-data">
		<input type="hidden" name="emp_num" value="1">
		<input type="hidden" name="sender_mail" value="jehwan@devware.shop">
		<input type="hidden" name="sender_name" value="제환">
		제목 : <input type="text" name="mail_title"><p>
		받는이 : <input type="text" name="receiver_name" id="receiver_name">
		받는이 메일 : <input type="text" name="receiver_mail" id="receiver_mail"><p/>
		첨부파일 : <input type="file" name="uploadFile" multiple="multiple" >
		<textarea name="mail_content" id="summernote"></textarea><p/>
		<input type="submit" value="작성">
	</form>
</body>
</html>