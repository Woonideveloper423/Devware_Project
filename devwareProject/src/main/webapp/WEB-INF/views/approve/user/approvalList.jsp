<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>



	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/jquery-easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/jquery-easyui/themes/icon.css">
    <!-- <link rel="stylesheet" type="text/css" href="/resources/jquery-easyui/demo.css"> -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery-easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery-easyui/jquery.easyui.min.js"></script>
	

	<div class=" container-fluid" style="margin:20px;">
	
	<div class="row" style="margin: 10px; overflow-x:hidden; overflow-y:auto;">
	<h2>결재자 찾기</h2>
	</div>
	<div class="row">
	<div class="container col-4" style="margin: 0px; padding: 0px; width:200px; ">
    <div class="easyui-panel" style="margin: 0px; width: 300px; height: 400px;">
        <ul id="tt" class="easyui-tree">


						<li><span>DevWare</span>
							<ul>
								<c:forEach items="${deptlist}" var="dept">
									<li data-options="state:'closed'"><span>${dept.dept_num}) ${dept.dept_name}</span>
										<ul>
 											<c:forEach items="${emplist}" var="emp">
												<c:if test="${dept.dept_num eq emp.dept_num}">
													<li>${emp.position_name}|${emp.emp_num}|${emp.emp_name}</li> 
												</c:if>
											</c:forEach>
										</ul>
									</li>
								</c:forEach>
							</ul>
						</li>





        </ul>
    </div>
    </div>
    
    <div class="container col-4" style="height:400px; border: 1px solid gray; margin: 0px; padding: 5px 10px 5px 20px; overflow-x:hidden; overflow-y:auto;">
    
    	<div class="row" > 
    	<label>성명</label>
    	</div>
    	
    	<div class="row">
    	
    	<table>
    	
    	<tr>
    	<th>부서</th>
    	<th>성명</th>
    	<th>직위</th>
    	<th>사번</th>
    	</tr>
    	
    	<tbody id="tbody">
      	<c:forEach var="emp" items="${emplist}">
    	
    	<%-- <c:if test="${ item.dept_name == null }">${ item.dept_name = "발령대기" }</c:if> --%>
    	
	    	<tr onclick="pikAuthMem(${ emp.emp_num})" style="cursor: pointer;" class="hovBg">
	    	<td>
	    	<c:choose>
	    		<c:when test="${ emp.dept_name == null }">${ emp.dept_name = "발령대기" }</c:when>
	    		<c:otherwise>${ emp.dept_name }</c:otherwise>
	    	</c:choose>
	    	</td>
	    	<td>${ emp.emp_name }</td>
			<td>${ emp.position_name }</td>
			<td>${ emp.emp_num }</td>
    		</tr>
    	
    	</c:forEach>
    	</tbody>
    	</table>
    	
    	</div>
    
    </div>

	<div class="container col-4">
	
	<table>
    
      	<tr>
      	<th>No.</th>
    	<th>부서</th>
    	<th>성명</th>
    	<th>직위</th>
    	<th>사번</th>
    	<th>순서</th>
    	<th>삭제</th>
    	</tr>
    	
    	<tbody id="finalList">
    	<c:forEach begin="1" end="3" varStatus="stat">
    	
    	<tr id="${ stat.count }" >
    	<td id="no_${ stat.count }">${ stat.count }</td>
    	<td id="dept_${ stat.count }"></td>
    	<td id="name_${ stat.count }"></td>
    	<td id="rank_${ stat.count }"></td>
    	<td id="memId_${ stat.count }"></td>
    	<td id="order_${ stat.count }"></td>
    	<td id="del_${ stat.count }"></td>
    	</tr>
    	
    	</c:forEach>
    	</tbody>
    
    </table>
	
	</div>

    
    </div ><!-- row  -->
    
    
    <div class="float-right" style="margin-right: 30px;">
	    <button class="btn btn-outline-primary" onclick="apply()" >적용</button>
	    <button class="btn btn-outline-primary" onclick="window.close();" >닫기</button>
    </div></div>
    
  <script>
    
    
    $('html, body').css({'overflow': 'hidden', 'height': '100%'});
    $('#element').on('scroll touchmove mousewheel', function(event) {
      event.preventDefault();
      event.stopPropagation();
      return false;
    });
    
    $(document).ready(function(){
		 MIN_NUM = 1;
		 MAX_NUM = 3;
    	
    	for(var i = MIN_NUM; i <= MAX_NUM ; i++){
    		
	    	if($(opener.document).find('#authRank'+i+'').text().trim() != ''){
	    	$('#rank_'+i+'').text($(opener.document).find('#authRank'+i+'').text());
	    	$('#name_'+i+'').text($(opener.document).find('#authName'+i+'').text());
	    	$('#dept_'+i+'').text($(opener.document).find('#authDept'+i+'').val());
	    	$('#memId_'+i+'').text($(opener.document).find('#apv_mem'+i+'').text());
	    	
			 $('#del_'+i+'').html('<a class="xBtn" onclick="delLine('+i+')">[ X ]</a>');
			 $('#order_'+i+'').html('&nbsp;<a class="upBtn" onclick="upBtn('+i+')">▲</a>&nbsp;<a class="dnBtn" onclick="dnBtn('+i+')">▼</a>&nbsp;')
			 $('#'+i+'').val('exist');

	    	}// if end
			 
    	}// for end
    	
    })// ready end
    
    $('#tt').tree({
    	onClick: function(node){
    		
    		console.log(node);
    		console.log(node.text);
    		
    		if(node.text == "DevWare"){
    			console.log('test')
    			$.ajax({
                    type: 'POST',
                    async: false,
                    url: "${ pageContext.request.contextPath }/getMemList",
                    success: function(data) {

      					/* var obj = JSON.parse(data); */
      					
      					$('#tbody').empty();
      					
      					printList(data);
						console.log('in if KITWARE')
						return;
				}
		});
    		}else{
    			
    		
    		console.log('부서 선택 문 searchDept')
    		var arr = (node.text).split(')');
    		console.log('부서 선택 문 searchDept arr->'+arr)	
    		var param = "dept_num="+arr[0];
    		console.log('부서 선택 문 searchDept param->'+param)	
    		 $.ajax({
                          type: 'POST',
                          url: "${ pageContext.request.contextPath }/searchDept",
                          data: param,
                          success: function(data) {
                        	  console.log('부서 선택 문 searchDept success->'+data)	
            					try{
            						 console.log('부서 선택 문 searchDept try->'+data)	
            						 console.log('부서 선택 문 searchDept try->'+data.emp_num)	
            						/* var obj = JSON.parse(data); */
            					}catch(Exception){
            						//=================================================================================================================================final process
            						
            						var arr = data.split('|');
            						var emp_num = data.emp_num;
            						
            						pikAuthMem(emp_num);
            						return;
            						
            					} //catch end ==================================================================================================================final process end
            					
            					$('#tbody').empty();
            					
            					printList(data);

            					return;
					},
					error: function(){
						return;
					}
			});
    		
    	}
    	} // if end
    });
    

	 
	 function printList(obj){
			for(var i in obj){
				
			if(obj[i].dept_name == null){
				obj[i].dept_name = '발령대기'
			}
			console.log("obj[i].dept_name , obj[i].position_name" + obj[i].position_name +"" +obj[i].dept_name);
				if(obj[i].position_name == null){
					obj[i].position_name = '입사대기'	
				}
				$('<tr></tr>').css('cursor','pointer').attr('class','hovBg').attr('onclick','pikAuthMem('+obj[i].emp_num+')').attr('id', obj[i].emp_num).appendTo('#tbody');
				$('<td></td>').text(obj[i].dept_name).appendTo('#'+obj[i].emp_num+'');
				$('<td></td>').text(obj[i].emp_name).appendTo('#'+obj[i].emp_num+'');
				$('<td></td>').text(obj[i].position_name).appendTo('#'+obj[i].emp_num+'');
				$('<td></td>').text(obj[i].emp_num).appendTo('#'+obj[i].emp_num+'');
			}
	 }
	 

	 function pikAuthMem(emp_num){
		 //===================================================================================================================================================== final process end
		 try{
			 parseInt(emp_num);
		 }catch(Exception){
			 return;
		 }
		 
		 
		var trArr = $('#finalList > tr');
		 
		var cnt = 3;
		for(var j = MIN_NUM; j <= MAX_NUM ; j++){
			
			if(parseInt($('#memId_'+j+'').text()) == emp_num){
				alert('이미 추가되어 있는 결재자 입니다.')
				return;
			} 

 			if(trArr[j-1].value != 'exist'){
				cnt--;
			}  
			
		}
		
		
		if(cnt == 3){
			alert('결재자가 모두 선택되었습니다. 삭제하고 다시 추가해주세요.');
			return;
		}

		var position_name;
		var dept_name;
		var emp_name;
		
		var param = "emp_num="+emp_num;
		
		 $.ajax({
			 type: 'POST',
             url: "${pageContext.request.contextPath}/searchById",
             data:{emp_num : emp_num},
             async: false,
			 dataType:'json',
             success: function(empForSearch) {
            	 position_name = empForSearch.position_name;
            	 dept_name = empForSearch.dept_name;
            	 emp_name = empForSearch.emp_name;
					
			}
		}); //ajax end
		
		if(position_name == null){
			position_name = '입사대기';
		}
		if(dept_name == null){
			dept_name = '발령대기'
		}
		
		 for(var i = 0 ; i < trArr.length ; i++){
			 
			 if($('#'+(i+1)+'').val() != 'exist'){
				 
				 $('#memId_'+(i+1)+'').text(emp_num);
				 $('#dept_'+(i+1)+'').text(dept_name);
				 $('#name_'+(i+1)+'').text(emp_name);
				 $('#rank_'+(i+1)+'').text(position_name);
				 
				 $('#del_'+(i+1)+'').html('<a class="xBtn" onclick="delLine('+(i+1)+')">[ X ]</a>');
				 $('#order_'+(i+1)+'').html('&nbsp;<a class="upBtn" onclick="upBtn('+(i+1)+')">▲</a>&nbsp;<a class="dnBtn" onclick="dnBtn('+(i+1)+')">▼</a>&nbsp;')
				 $('#'+(i+1)+'').val('exist');
				 
				 return;
			 }
			 
		 }
		 
		 
		 
	 } // pikAuthMem() end
	 //===================================================================================================================================================== final process end

	 
	 function apply(){
		 
		 for(var i = MIN_NUM; i <= MAX_NUM ; i++){
			 
			$(opener.document).find('#authName'+i).text($('#name_'+i).text());
			$(opener.document).find('#authName_ath'+i).val($('#name_'+i).text());
			$(opener.document).find('#authRank'+i).text($('#rank_'+i).text());
			$(opener.document).find('#authRank_ath'+i).val($('#rank_'+i).text());
			$(opener.document).find('#authDept'+i).val($('#dept_'+i).text());
			$(opener.document).find('#authId'+i).val($('#memId_'+i).text());
			$(opener.document).find('#apv_mem'+i).text($('#memId_'+i).text());
			$(opener.document).find('#apv_mem_ath'+i).val($('#memId_'+i).text());
			
		 }
		 
		
		window.close();
		
	 }
	 
	 
	 function delLine(i){
		 
		 if($('#'+(i+1)+'').val() == 'exist'){
			 alert('차순 결재자가 있습니다.');
			 return;
		 }else{
			$('#'+i+'').val(null); 
			$('#dept_'+i+'').text('');
			$('#dept_'+i+'').val('');
			$('#name_'+i+'').text('');
			$('#rank_'+i+'').text('');
			$('#memId_'+i+'').text('');
			
			$('#del_'+i+'').html('');
			$('#order_'+i+'').html('');
		 }
		 
	 } // delLine() end
	 
	 function upBtn(i){
		 
		if(i == MIN_NUM){
			return;
		}
		 
		var dept = $('#dept_'+(i-1)+'').text();
		var name = $('#name_'+(i-1)+'').text();
		var rank = $('#rank_'+(i-1)+'').text();
		var memId = $('#memId_'+(i-1)+'').text();
		
		$('#dept_'+(i-1)+'').text($('#dept_'+i+'').text());
		$('#name_'+(i-1)+'').text($('#name_'+i+'').text());
		$('#rank_'+(i-1)+'').text($('#rank_'+i+'').text());
		$('#memId_'+(i-1)+'').text($('#memId_'+i+'').text());
		
		$('#dept_'+i+'').text(dept);
		$('#name_'+i+'').text(name);
		$('#rank_'+i+'').text(rank);
		$('#memId_'+i+'').text(memId);
		 
	 } //upBtn() end
	 
	 function dnBtn(i){

			if(i == MAX_NUM){
				return;
			}
			 
			var dept = $('#dept_'+(i+1)+'').text();
			var name = $('#name_'+(i+1)+'').text();
			var rank = $('#rank_'+(i+1)+'').text();
			var memId = $('#memId_'+(i+1)+'').text();
			
			$('#dept_'+(i+1)+'').text($('#dept_'+i+'').text());
			$('#name_'+(i+1)+'').text($('#name_'+i+'').text());
			$('#rank_'+(i+1)+'').text($('#rank_'+i+'').text());
			$('#memId_'+(i+1)+'').text($('#memId_'+i+'').text());
			
			$('#dept_'+i+'').text(dept);
			$('#name_'+i+'').text(name);
			$('#rank_'+i+'').text(rank);
			$('#memId_'+i+'').text(memId);

	 } 
    
    </script>

    <style>
    
    .hovBg:hover {
    
    background-color: lightgray;
    
    }
    
    .xBtn:hover, .upBtn:hover, .dnBtn:hover {

    cursor: pointer;
    color: green;
    font-weight: bold;
    
    }
    
    </style>

</body>
</html>
