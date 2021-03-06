<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style>
.emp-profile{
    padding: 3%;
    margin-top: 3%;
    margin-bottom: 3%;
    border-radius: 0.5rem;
    background: #fff;
}
.profile-img-div{
	text-align:center;
	display:table;
	width: 200px;
	height: 200px;
}
.profile-img{
    display: table-cell;
    vertical-align: middle;
}
.profile-img img{
    max-width: 200px;
    max-height: 200px;
}
.profile-img .file, .file {
    position: relative;
    overflow: hidden;
/*     margin-top: -20%; */
    width: 70%;
    border: none;
    border-radius: 0;
    font-size: 15px;
    background: #212529b8;
}
.profile-img .file input, .file input {
    position: absolute;
    opacity: 0;
    right: 0;
    top: 0;
}
.profile-head h5{
    color: #333;
}
.profile-head h6{
    color: #0062cc;
}
.profile-edit-btn{
    border: none;
    border-radius: 1.5rem;
    width: 70%;
    padding: 2%;
    font-weight: 600;
    color: #6c757d;
    cursor: pointer;
}
.proile-rating{
    font-size: 12px;
    color: #818182;
    margin-top: 5%;
}
.proile-rating span{
    color: #495057;
    font-size: 15px;
    font-weight: 600;
}
.profile-head .nav-tabs{
    margin-bottom:5%;
}
.profile-head .nav-tabs .nav-link{
    font-weight:600;
    border: none;
}
.profile-head .nav-tabs .nav-link.active{
    border: none;
    border-bottom:2px solid #0062cc;
}
.profile-work{
    padding: 14%;
    margin-top: -15%;
}
.profile-work p{
    font-size: 12px;
    color: #818182;
    font-weight: 600;
    margin-top: 10%;
}
.profile-work a, .profile-work span{
    text-decoration: none;
    color: #495057;
    font-weight: 600;
    font-size: 14px;
}
.profile-work ul{
    list-style: none;
}
.profile-tab label{
    font-weight: 600;
}
.profile-tab a{
    font-weight: 600;
    color: #0062cc;
}
</style>

<script>
$(function(){
	// ???????????? ??????
	$("#basicModify").on("click",function(){
		$(".basic-info").prop("hidden",true);
		$(".basic-info-input").prop("hidden",false);
		var mails = "${empVO.empMail}".split('@');
		$("#email").val(mails[0]);
		$("#email2").val("@" + mails[1]);
		var empHp = "${empVO.empHp}".replace(/-/gi,"");
		$("#empHp").val(empHp);
	});
	
	$(".actionBtn").on("click",function(){
		var name = this.name;
		
		if(name=="cancel"){
			$(".basic-info").prop("hidden",false);
			$(".basic-info-input").prop("hidden",true);
		}else if(name=="pwCancel"){
			$(".pwSwitch").prop("hidden",false);
			$(".pwModify-input").prop("hidden",true);
		}else if(name=="doPwModify"){
			var regExpPw = /^(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$/;
			
			var empPw = $("#passwordF").val();
			var empPw2 = $("#passwordF2").val();
			
			if(empPw == ""){
				alert("??????????????? ??????????????????");
				//?????? ?????? ????????? ????????? ??????
				$("#passwordF").select();
				return false;
			}else if(empPw!=empPw2){
				alert("??????????????? ???????????? ????????????.");
				$("#passwordF").select();
				return false;
			}else if(!regExpPw.test(empPw)){
				alert("????????? ????????????,??????,??????????????? 1????????? ???????????? 8??? ?????? ??????????????????.");
				$("#passwordF").select();
				return false;
			}
			
// 			$("#modifyEmpPw").val(empPw);
			$("#pwFrm").submit();
			
			$(".pwSwitch").prop("hidden",false);
			$(".pwModify-input").prop("hidden",true);
		}else if(name="doModify"){
			var regExpPh = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
			var regExpMail  = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			
			var addr = $('#zipCode').val() + " " + $('#addr1').val() + " " + $('#addr2').val();
			var empHp = $("#empHp").val();
			
			if(empHp.length > 10){
				var a = empHp.slice(0,3);
				var b = empHp.slice(3,7);
				var c = empHp.slice(-4);
				var d = "-"
				empHp = [a, d, b, d, c].join('');
			}else{
				var a = empHp.slice(0,3);
				var b = empHp.slice(3,6);
				var c = empHp.slice(-4);
				var d = "-"
				empHp = [a, d, b, d, c].join('');
			}
			var mail1 = $("#email").val();
			var mail2 = $("#email2").val();
			var empMail = $("#email").val() + $("#email2").val();
			$("#empMail").val(empMail);
			
			if(empHp == ""){
				alert("??????????????? ??????????????????");
				//?????? ?????? ????????? ????????? ??????
				$("#empHp").select();
				return false;
			}else if(!regExpPh.test(empHp)){
				alert("???????????? ????????? ?????? ????????????.");
				$("#empHp").focus();
				return false;
			}
			$("#empHp").val(empHp);
			
			if(mail1 == ""){
				alert("???????????? ??????????????????");
				//?????? ?????? ????????? ????????? ??????
				$("#email").select();
				return false;
			}else if(mail1 == ""){
				alert("???????????? ??????????????????");
				$("#email").select();
				return false;
			}else if(!regExpMail.test(empMail)){
				alert("????????? ????????? ?????? ????????????.");
				$("#email").focus();
				return false;
			}
			
			if(addr.trim()!=''){
				$("#empAddr").val(addr);
			}
			$("#basicFrm").submit();
		}
		return false;
	})
	
	
	//???????????? ??? ??????
	$("#home-tab").on("show.bs.tab",function(){
		$("#profile-tab").prop('hidden',true);
		$("#fake-profile-tab").prop('hidden',false);
	})
	
	$("#pwModify").on("click",function(){
		$(".pwSwitch").prop("hidden",true);
		$(".pwModify-input").prop("hidden",false);
	});
	
	$("#input_img").on("change", handleImgFileSelect);
	
	function handleImgFileSelect(e){
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f){
			if(!f.type.match("image.*")){
				alert("???????????? ???????????????");
				return;
			}
			
			//????????? ???????????? ?????? ??????
			var reader = new FileReader();
			reader.onload = function(e){
 				$("#empPic").attr("src",e.target.result);
//  				var img = $(".profile_info").children()[0];
//  				$(img).attr('src', e.target.result);
//  				console.log(img);
			}
			reader.readAsDataURL(f);
		});
	}
	
	//??????????????? ???????????? exe, sh, zip, alz ?????? ???????????? ??????
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	//?????? 5MB????????? ????????? ??????
	var maxSize = 5242880;
	//????????? ??????
	function checkExtension(fileName, fileSize){
		if(regex.test(fileName)){
			alert("?????? ????????? ????????? ???????????? ??? ????????????.");
			return false;
		}
		
		if(fileSize >= maxSize){
			alert("?????? ????????? ??????");
			return false;
		}
		
		return true;
	}
	
	// ?????????
	$('#feInputState').change(function(){
	   $("#feInputState option:selected").each(function () {
			
			if($(this).val()== '1'){ //??????????????? ??????
				 $("#email2").val('@');                //??? ?????????
				 $("#email2").attr("disabled",false); //?????????
			}else{ //??????????????? ????????????
				 $("#email2").val($(this).val());   //????????? ??????
				 $("#email2").attr("disabled",true); //????????????
			}
	   });
	});
		
});

function fn_checkPwTab(){
	if("${loginUser.empCd}" != "${empVO.empCd}"){
		swal('','?????? ????????? ????????? ??? ????????????.','error')
		return false;
	}
	var flag = swal({
		title: '?????? ??????',
		text: '??????????????? ??????????????????!',
		icon: 'warning',
		content: {
			element: 'input',
			attributes: {
				placeholder: '?????? ??????',
				type: 'password'
			}
		},
		buttons: {
			cancle: {
				text: '??????',
				value: false,
				className: 'btn btn-danger'
			},
			confirm: {
				text: '??????',
				value: false,
				className: 'btn btn-success'
			}
		}
	}).then((result) => {
		if(result==null){
			swal('????????? ??????','??????????????? ?????? ???????????? ????????????','warning');
		}else if(result==''){
			swal('????????? ??????','??????????????? ?????? ???????????? ????????????','warning');
		}else{
			$.ajax({
				url:'/profile/pwMatches',
				data:{"empPw":result, "empCd":"${loginUser.empCd}"},
				type: 'post',
				beforeSend: function (jqXHR, settings) {
					// ajax ????????? ????????? ????????????????????? ?????? ??????
					var token = '${_csrf.token}'
					var header = '${_csrf.headerName}'
					jqXHR.setRequestHeader(header, token);
				},
				success:function(res){
					if(res){
						$("#home-tab").attr('aria-selected',false);
			 			$("#home-tab").attr('class','nav-link');
			 			$("#home").attr('class','tab-pane fade');
			 			$("#profile-tab").attr('aria-selected',true);
			 			$("#profile-tab").prop('hidden',false);
			 			$("#fake-profile-tab").prop('hidden',true);
			 			$("#profile-tab").attr('class','nav-link active');
			 			$("#profile").attr('class','tab-pane fade show active');
					}else{
						swal('??????????????? ???????????? ????????????.','??????????????? ?????? ???????????? ????????????','warning');
					}
				}
			})
		}
// 		}else if(result!='${empVO.empPw}'){
// 			swal('??????????????? ???????????? ????????????.','??????????????? ?????? ???????????? ????????????','warning');
// 		}else{
// 			$("#home-tab").attr('aria-selected',false);
// 			$("#home-tab").attr('class','nav-link');
// 			$("#home").attr('class','tab-pane fade');
// 			$("#profile-tab").attr('aria-selected',true);
// 			$("#profile-tab").prop('hidden',false);
// 			$("#fake-profile-tab").prop('hidden',true);
// 			$("#profile-tab").attr('class','nav-link active');
// 			$("#profile").attr('class','tab-pane fade show active');
// 		}
	});
	
}
</script>

<h2>&nbsp;</h2>

<div class="container emp-profile">
        <div class="row">
            <div class="col-md-4 profile-img-div">
                <div class="profile-img">
                    <img id="empPic" src="${empVO.empPic}" alt=""/>
                </div>
            </div>
            <div class="col-md-6">
                <div class="profile-head">
                            <h5>
                                ${empVO.empNm}
                            </h5>
                            <h6>
                                ${empVO.secNm}
                            </h6>
                            <p class="proile-rating">
                            	?????? : <span>${empVO.position}</span>
                            </p>
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">????????????</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false" hidden="true">????????????</a>
                            <a class="nav-link" id="fake-profile-tab" href="javascript:fn_checkPwTab()">????????????</a>
                        </li>
                    </ul>
                </div>
            </div>
            <c:if test='${empVO.empCd eq loginUser.empCd}'>
            <div class="col-md-2">
                <button id="basicModify" type="button" class="profile-edit-btn basic-info">??????</button>
            </div>
            </c:if>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="profile-work">
                    <p>??????</p>
                    <a href="/schedule/main">??????</a><br/>
                    <p>?????????</p>
                    <span>${empVO.hireDate}</span>
                    <br/>
                </div>
            </div>
            <div class="col-md-8">
                <div class="tab-content profile-tab" id="myTabContent">
                    <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                <form:form id="basicFrm" modelAttribute="empVO" method="post"
                                	 action="/profile/basicModify" enctype="multipart/form-data">
        						<sec:csrfInput/>
        						<div class="file btn btn-lg btn-primary basic-info-input" hidden="true">
			                        	?????? ?????????
			                        <input id="input_img" type="file" name="uploadFile"/>
			                    </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <label>?????? ??????</label>
                                    </div>
                                    <div class="col-md-6">
                                        <p>
                                        	${empVO.empCd}
                                        	<form:hidden path="empCd"/>
                                        </p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <label>?????????</label>
                                    </div>
                                    <div class="col-md-6">
                                        <p>
                                        	<span class="basic-info">${empVO.empHp}</span>
                                        	<form:input path="empHp" class="basic-info-input" hidden="true"/>
                                        </p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <label>?????? ??????</label>
                                    </div>
                                    <div class="col-md-6">
<!--                                         <p> -->
                                        	<span class="basic-info">${empVO.empMail}</span>
                                        	<form:hidden path="empMail"/>
                                        	<div class="form-row basic-info-input" hidden="true">
						                        <div class="form-group col-md-4">
						                          <label for="email">&nbsp;</label>
						                          <input type="text" class="form-control" id="email" placeholder="?????????"> </div>
						                        <div class="form-group col-md-4">
						                          <label for="email2">&nbsp;</label>
						                          <input type="text" class="form-control" id="email2" disabled> </div>
						                        <div class="form-group col-md-4">
						                          <label for="feInputState">&nbsp;</label>
						                          <select id="feInputState" class="form-control">
						                            <option value="1">????????????</option>
													<option value="@naver.com" selected>naver.com</option>
													<option value="@hanmail.net">hanmail.net</option>
													<option value="@hotmail.com">hotmail.com</option>
													<option value="@nate.com">nate.com</option>
													<option value="@yahoo.co.kr">yahoo.co.kr</option>
													<option value="@gmail.com">gmail.com</option>
						                          </select>
						                        </div>
						                    </div>
<!--                                         </p> -->
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <label>??????</label>
                                    </div>
                                    <div class="col-md-6">
                                        <p>
                                        	<span class="basic-info" id="exAddr">${empVO.empAddr}</span>
                                        	<form:input path="empAddr" hidden="true"/>
                                        </p>
                                        <div class="form-row basic-info-input" hidden="true">
<!-- 									        <div class="form-group col-md-4"> -->
									            <input type="text" class="form-control" id="zipCode" readonly>
<!-- 									        </div> -->
<!-- 									        <div class="form-group col-md-4"> -->
									            <button id="searchZip" type="button" class="mb-2 btn btn-sm btn-info mr-1 basic-info-input">???????????? ??????</button>
<!-- 									        </div> -->
								        </div>
								        <div class="form-group basic-info-input" hidden="true">
								            <input type="text" class="form-control" id="addr1" readonly>
								        </div>
								        <div class="form-group basic-info-input" hidden="true">
								            <input type="text" class="form-control" id="addr2" readonly>
								        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3">
                                        <label>?????? ??????</label>
                                    </div>
                                    <div class="col-md-6">
                                        <p>
                                        	<span class="basic-info">${empVO.lcnsNo}</span>
                                        	<form:input path="lcnsNo" class="basic-info-input" hidden="true"/>
                                        </p>
                                    </div>
                                    <button name="doModify" type="button" class="btn btn-primary basic-info-input actionBtn" hidden="true">??????</button>
                                    <button name="cancel" type="button" class="btn btn-secondary basic-info-input actionBtn" hidden="true">??????</button>
                                </div>
                    	</form:form>
                    </div>
                    <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
	                    
                                <form:hidden path="empCd"/>
                                <div class="row">
                                    <div class="col-md-3">
                                        <label>??????????????????</label>
                                    </div>
                                    <div class="col-md-6">
                                        <p>${empVO.viewSecurityEmpPrno()}</p>
                                    </div>
                                </div>
                                <div class="row pwSwitch">
                                    <div class="col-md-3">
                                        <label>????????????</label>
                                    </div>
                                    <div class="col-md-6">
                                        <p>********</p>
                                    </div>
                                </div>
                        <div class="row">
					        <form id="pwFrm" method="post" action="/profile/pwModify">
		        				<sec:csrfInput/>
	                            <div class="col-md-12">
	                            <div>
					                <button id="pwModify" type="button" class="profile-edit-btn pwSwitch">???????????? ??????</button>
					            </div>
	                                <div class="form-row pwModify-input" hidden="true">
				                        <div class="form-group col-md-6">
				                        	<input type="hidden" name="empCdPw" value="${empVO.empCd}"/>
				                          <label for="password">????????????</label>
				                          <input type="password" class="form-control" id="passwordF" name="pw1" placeholder="????????????"> </div>
				                        <div class="form-group col-md-6">
					                        <label for="password-check">???????????? ??????</label>
					                        <input type="password" class="form-control" id="passwordF2" placeholder="???????????? ??????"> </div>
				                    </div>
				                    <button name="doPwModify" type="button" class="btn btn-primary pwModify-input actionBtn" hidden="true">??????</button>
	                                <button name="pwCancel" type="button" class="btn btn-secondary pwModify-input actionBtn" hidden="true">??????</button>
	                            </div>
	                    	</form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</div>



