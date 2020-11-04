<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<link rel="shortcut icon" type="image/x-icon" href="../compuzone_web.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="google-site-verification" content="dnxhxrTfQxPmuoSYtosbrrQ-g02ONxebL1NiCsW-cn8" />
<meta name="naver-site-verification" content="177d7a5975da608bac153b237fd0cf36708423e2"/>
<meta charset="UTF-8">
<title>신규 회원가입</title>
<jsp:include page="../include/inHead.jsp"></jsp:include>

<!-- 업로드 이미지 미리보기 -->
<style type="text/css">
	#prof_wrap {
		width: 600px;
	}
	#prof_wrap img {
		max-width: 200px;
		margin-top: 15px;
	}
</style>

<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<!-- 다음 주소찾기 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- CSS관련자료 -->
<script type="text/javascript" src='https://www.compuzone.co.kr/script/common.js?utime=20170525'></script>
<script type="text/javascript" src="https://www.compuzone.co.kr/script/jquery-1.8.3.min.js"></script><link href="https://www.compuzone.co.kr//css/member.css?id=180718" rel="stylesheet" type="text/css">
<link href="../css/2013main.css" rel="stylesheet" type="text/css">
<link href="https://www.compuzone.co.kr/css/bsk2015.css" rel="stylesheet" type="text/css">
<link href="https://www.compuzone.co.kr/css/common_style.css?utime=20181010" rel="stylesheet" type="text/css">
<script language="JavaScript" src="https://www.compuzone.co.kr/script/common_div.js"></script>
<style type="text/css">
	#mask, #mask2 { position:absolute; left:0; top:0; z-index:100; background-color:#000; display:none; }
	#tax_dim {display:none; position:absolute; left:0; top:0; z-index:100; width: 100%;height: 100%; background-color:#000; filter:alpha(opacity=60);-moz-opacity: 0.6;opacity: 0.6; }
	/*.error{color: rgb(242, 70, 56);cursor: pointer;margin: 10px 0px 0px;float: none;}*/
	#TaxCheck>div {margin-left:220px !important;}
	#jqIdOAuthNaverLyr, #jqIdOAuthKakaoLyr, #showPN{left:767px !important;top:520px !important;}
</style>



<script>
var sel_files = [];
// 유효성 기능 활성화
$().ready(function(){

	// 업로드 이미지 미리보기
	$('#prof').on('change', handleImgFilesSelect);
	

	// 아이디 유효성
	$('#idDupChk').focus(function() {
		regExId();
	});

	// 비밀번호 유효성
	$('#pwd').focus(function() {
		regExPwd();
	});

	// 이메일 유효성
	$('#emailDupChk').focus(function(){
		regExEmail();
	});

	// 연락처 유효성
	$('#tel').focus(function() {
		regExPwd();
	});
	
});

//업로드 이미지 미리보기
function handleImgFilesSelect(e) {

	// 기존에 고른 사진 지우기
	$('#prof_wrap').empty();
	
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);

	filesArr.forEach( function(f) {
		
		if (!f.type.match('image.*')) {
			alret("이미지 파일만 업로드 가능합니다.");
			return;
		}

		sel_files.push(f);

		var reader = new FileReader();
		reader.onload = function(e) {
			var img_html = "<img src='"+e.target.result + "' />";
			$('#prof_wrap').append(img_html);
		}

		reader.readAsDataURL(f);
	})
}


//----------------------[ 정규식 ]----------------------

//아이디 : 영소문자로 시작하는 6~12자의 영소문자 또는 숫자
var idR = /^[a-z]+[a-z0-9]{5,11}$/;
//비밀번호 : 8~15자의 영대문자 또는 영소문자, 숫자, 특수문자(#?!@$%^&*-)
var pwdR = /^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,15}$/;
// * 특수문자 ()도 가능하다고 뜸...
//이메일 : https://blog.managr.us/entry/email-%EA%B2%80%EC%A6%9D-%EC%A0%95%EA%B7%9C%EC%8B%9D%EA%B3%BC-%ED%85%8C%EC%8A%A4%ED%8A%B8-%EB%B0%A9%EB%B2%95
var emailR = /^[A-Za-z0-9][A-Za-z0-9\_\-\.\+]+[0-9a-zA-Z]@[A-Za-z0-9][A-Za-z0-9\_\-]*[A-Za-z0-9]\.[A-Za-z]{2,6}$/;
// * 안됨
//var emailR = /^[a-zA-Z0-9._-]+@[a-zA-z0-9.-]+\.[a-zA-Z]{2,4}$/
//연락처 : '-'없이 번호만 입력해주세요
var telR=/^\d{2,3}-\d{3,4}-\d{4}$/;


//-----------------[ 아이디 function ]-----------------

// 유효성 검사 (정규식)
function regExId(){
	var idDupChk = $('#idDupChk').val(); 
	if ( idDupChk=='' ){	// 아이디 미입력
		$('#idDupChkRet').text('아이디를 입력해주세요.');
		$('#idDupChkRet').css('color', 'red');
	} else if( idR.test(idDupChk)!=true ){	// 유효성 검사 실패
		$('#idDupChkRet').text('6~12자의 영소문자 또는 숫자만 사용 가능하며, 영소문자로 시작해야 합니다.');
		$('#idDupChkRet').css('color', 'red');
		return false;
	} else {	// 유효성 검사 통과
		return true;
	}
}

// 중복 체크
function checkId(){
	var regExIdResult = regExId();	// 유효성 검사 실행
	//alert('regExIdResult = ' + regExIdResult);
	
	if ( regExIdResult==true ) {	// 유효성 검사 통과
		//alert("유효성 검사 통과함")
		var idDupChk = $('#idDupChk').val();
		//alert ("idDupChk = " + idDupChk);

		$.ajax({
			url : '/poom/register/idDupChk',
			data : {
				id : idDupChk
			},
			dataType : 'text' , // html, text, json, xml, script
			method : 'post',
			success : function(data) {
				//alert("idDupChk ajax 성공");
				if ( data==0 ) {
					//alert ("중복되지 않은 아이디");
					$('#idDupChkRet').text('사용가능한 아이디입니다.');
					$('#idDupChkRet').css('color', 'green');
				} else if ( data==1 ) {
					//alert("중복된 아이디")
					$('#idDupChkRet').text('이미 사용중인 아이디입니다.');
					$('#idDupChkRet').css('color', 'red');
				} else {
					//alert("에러");
					$('#idDupChkRet').text('관리자에게 문의하세요.');
					$('#idDupChkRet').css('color', 'red');
				}
			},
			error : function() {
				alert('idDupChk ajax 에러')
			}
		});
	}
	// 유효성 검사가 실패했을때, 회원가입 버튼이 안 눌리게 하는 조건 추가해야됨!
	
}


//----------------[ 비밀번호 function ]----------------

// 유효성 검사 (정규식)
function regExPwd(){
	var pwd = $('#pwd').val(); 
	if ( pwd=='' ){	// 비밀번호 미입력
		$('#pwdRet').text('비밀번호를 입력해주세요.');
		$('#pwdRet').css('color', 'red');
	} else if( pwdR.test(pwd)!=true ){	// 유효성 검사 실패
		$('#pwdRet').text('8~15자의 영대문자 또는 영소문자, 숫자, 특수문자(#?!@$%^&*-)를 혼합해서 사용해야 합니다.');
		$('#pwdRet').css('color', 'red');
		return false;
	} else {	// 유효성 검사 통과
		$('#pwdRet').text('사용가능한 비밀번호입니다.');
		$('#pwdRet').css('color', 'green');
		return true;
	}
}


// 일치 확인
function reCheckPwd() {
	var pwd = $('#pwd').val();
	var pwdMatChk = $('#pwdMatChk').val();
	//alert("pwd = " + pwd);
	//alert("pwdMatChk = " + pwdMatChk);
	
	if ( pwd==pwdMatChk ) {
		//alert("비밀번호 일치");
		$('#pwdMatChkRet').text('비밀번호가 일치합니다.');
		$('#pwdMatChkRet').css('color', 'green');
	} else {
		//alert("비밀번호 불일치");
		$('#pwdMatChkRet').text('비밀번호가 일치하지 않습니다.');
		$('#pwdMatChkRet').css('color', 'red');
	}
	
}


//-----------------[ 이메일 function ]-----------------

//유효성 검사 (정규식)
function regExEmail(){
	var emailDupChk = $('#emailDupChk').val(); 
	if ( emailDupChk=='' ){	// 이메일 미입력
		$('#emailDupChkRet').text('이메일을 입력해주세요.');
		$('#emailDupChkRet').css('color', 'red');
	} else if( emailR.test(emailDupChk)!=true ){	// 유효성 검사 실패
		$('#emailDupChkRet').text('이메일 양식에 맞춰서 입력해주세요. 예시) abc123@poom.com');
		$('#emailDupChkRet').css('color', 'red');
		return false;
	} else {	// 유효성 검사 통과
		return true;
	}
}

//중복 체크
function checkEmail(){
	var regExEmailResult = regExEmail();	// 유효성 검사 실행
	//alert('regExEmailResult = ' + regExEmailResult);
	
	if ( regExEmailResult==true ) {	// 유효성 검사 통과
		//alert("유효성 검사 통과함")
		var emailDupChk = $('#emailDupChk').val();
		//alert ("emailDupChk = " + emailDupChk);

		$.ajax({
			url : '/poom/register/emailDupChk',
			data : {
				email : emailDupChk
			},
			dataType : 'text' , // html, text, json, xml, script
			method : 'post',
			success : function(data) {
				//alert("emailDupChk ajax 성공");
				if ( data==0 ) {
					//alert ("중복되지 않은 이메일");
					$('#emailDupChkRet').text('사용가능한 이메일입니다.');
					$('#emailDupChkRet').css('color', 'green');
				} else if ( data==1 ) {
					//alert("중복된 이메일")
					$('#emailDupChkRet').text('이미 등록된 이메일입니다.');
					$('#emailDupChkRet').css('color', 'red');
				} else {
					//alert("에러");
					$('#emailDupChkRet').text('관리자에게 문의하세요.');
					$('#emailDupChkRet').css('color', 'red');
				}
			},
			error : function() {
				alert('emailDupChk ajax 에러')
			}
		});
	}
	// 유효성 검사가 실패했을때, 회원가입 버튼이 안 눌리게 하는 조건 추가해야됨!
	
}
//이메일 인증 이메일 보내기
$(document).on("click", "#emailBtn", function(){
	      var userEmail = $("#emailDupChk").val();
	      $.ajax({
	         data:{email:userEmail},
	         dataType:"json",
	         method: "post",
	         url: "/poom/createEmailCheck",
	         success : function(data){
	            if(data==false){
	               alert("이메일을 입력해주세요");
	            }else{
	               alert("이메일이 발송되었습니다. 인증번호 확인 후 입력해주세요");
	            }
	               
	         },
	         error: function(data){
	               alert("에러가 발생했습니다.");
	               return false;
	         }
	      });
	   });


//이메일 인증 확인코드
	   $(document).on("click", "#codeBtn", function(){
	      var email = $("#emailDupChk").val();
	      var userCode = $("#checkCode").val();
	      console.log('userCode:',userCode)
	      $.ajax({
	         //data:{code:userCode},
	         data:{
	            email:email,            
	            checkCode:userCode
	         },
	         method: "post",
	         dataType: "json",
	         //dataType: "json",
	         url:"/poom/checkCode11",
	         success:function(data){
	            console.log("data는",data);
	            if(data==0){
	               //alert("인증이 완려되었습니다.");
	                $('#checkCodeRet').text('인증이 완료되었습니다.');
					$('#checkCodeRet').css('color', 'green');
	               isComfirm = true; // 인증완료값
	            } else {
	               //alert("인증번호를 잘못 입력하셨습니다. 인증번호를 ");
	                $('#checkCodeRet').text('인증번호를 잘못 입력하셨습니다. 다시 입력해주세요.');
					$('#checkCodeRet').css('color', 'red');

	            }
	         },
	         error:function(error){
	            alert("에러가 발생했습니다.");
	            console.log('error - email check:', error)
	         }
	      });
	   });


//-----------------[ 연락처 function ]-----------------

// 유효성 검사 (정규식)
function regExTel(){
	var tel = $('#tel').val(); 
	if ( tel=='' ){	// 연락처 미입력
		$('#telRet').text('연락처를 입력해주세요.');
		$('#telRet').css('color', 'red');
	} else if( telR.test(tel)!=true ){	// 유효성 검사 실패
		$('#telRet').text('\'-\'를 제외한 번호만 입력해주세요.');
		$('#telRet').css('color', 'red');
		return false;
	} else {	// 유효성 검사 통과
		return true;
	}
}


//------------------[ 주소 function ]------------------

function execDaumPostcode() {
	
	new daum.Postcode({
		
		oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if ( data.userSelectedType==='R') {	// 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else {	// 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if( data.userSelectedType === 'R' ){
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if( data.bname!=='' && /[동|로|가]$/g.test(data.bname) ){
					extraAddr += data.bname;
				}

				// 건물명이 있고, 공동주택일 경우 추가한다.
				if( data.buildingName!=='' && data.apartment==='Y' ){
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if( extraAddr!=='' ){
					extraAddr = ' (' + extraAddr + ')';
				}
				
				// 조합된 참고항목을 해당 필드에 넣는다.
				document.getElementById("extraAddress").value = extraAddr;
              
			} else {
				document.getElementById("extraAddress").value = '';
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('postcode').value = data.zonecode;
			document.getElementById('address').value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("detailAddress").focus();
		}
	
	}).open();
	
}

//------------------------맨처음 만든거-----------------------------------------


// 	$().ready(function() {
		
// 		// ID 중복체크
// 		$("#idDupChk").change(function() {
		
// 			var idDupChk = $("#idDupChk").val();
// 			//alert("idDupChk = " + idDupChk);
			
// 			$.ajax({
// 				url : '/poom/register/idDupChk',
// 				data : {
// 					id : idDupChk
// 				},
// 					dataType : 'text', /*html, text, json, xml, script*/
// 					method : 'post',
// 					success : function(data) {
// 						//alert("idDupChk ajax 성공");
					
// 						if ( data==0 ) {
// 							//alert("중복되지 않은 ID");
// 							$("#idDupChkRet").attr("type", "text");
// 							$("#idDupChkRet").attr("style", "color:green;");
// 							$("#idDupChkRet").val("사용가능한 ID입니다.");
// 						} else if ( data==1 ){
// 							//alert("중복된 ID");
// 							$("#idDupChkRet").attr("type", "text");
// 							$("#idDupChkRet").attr("style", "color:red;");
// 							$("#idDupChkRet").val("이미 사용중인 ID입니다.");
// 						} else {
// 							//alert("에러");
// 							$("#idDupChkRet").val("관리자에게 문의하세요.");
// 					}
// 				},
// 				error : function() {
// 					//alert("idDupChk ajax 에러");
// 				}
// 			});
		
// 		});

// 		// email 중복체크
// 		$("#emailDupChk").change(function() {
			
// 			var emailDupChk = $("#emailDupChk").val();
// 			//alert("emailDupChk = " + emailDupChk);
			
// 			$.ajax({
// 				url : '/poom/register/emailDupChk',
// 				data : {
// 					email : emailDupChk
// 				},
// 					dataType : 'text',
// 					method : 'post',
// 					success : function(data) {
// 						//alert("emailDupChk ajax 성공");
					
// 						if ( data==0 ) {
// 							//alert("중복되지 않은 email");
// 							$("#emailDupChkRet").attr("type", "text");
// 							$("#emailDupChkRet").attr("style", "color:green;");
// 							$("#emailDupChkRet").val("사용가능한 email입니다.");
// 						} else if ( data==1 ){
// 							//alert("중복된 eamil");
// 							$("#emailDupChkRet").attr("type", "text");
// 							$("#emailDupChkRet").attr("style", "color:red;");
// 							$("#emailDupChkRet").val("이미 사용중인 email입니다.");
// 						} else {
// 							//alert("에러");
// 							$("#emailDupChkRet").val("관리자에게 문의하세요.");
// 					}
// 				},
// 				error : function() {
// 					//alert("pwdDupChk ajax 에러");
// 				}
// 			});
		
// 		});

// 		// pwd 일치확인
// 		$("#pwdMatChk").change(function() {

// 			var pwd = $("#pwd").val();
// 			var pwdMatChk = $("#pwdMatChk").val();
// 			//alert("pwd = " + pwd);
// 			//alert("pwdMatChk = " + pwdMatChk);

// 			if ( pwd==pwdMatChk ) {
// 				//alert("pwd 일치");
// 				$("#pwdMatChkRet").attr("type", "text");
// 				$("#pwdMatChkRet").attr("style", "color:green;");
// 				$("#pwdMatChkRet").val("비밀번호가 일치합니다.");
// 			} else {
// 				//alert("pwd 불일치");
// 				$("#pwdMatChkRet").attr("type", "text");
// 				$("#pwdMatChkRet").attr("style", "color:red;");
// 				$("#pwdMatChkRet").val("비밀번호가 다릅니다.");
// 			}
			
// 		});

// 	});
</script>

</head>
<jsp:include page="../include/header.jsp"></jsp:include>

<form action="new" method="post" id="registerNewForm" enctype="multipart/form-data">
	<div id="container">

	<!-- 딜러회원가입시 노출 영역 -->
	<div class="contents">
		<div class="tit">일반회원가입!!!</div>
		<div class="contentsBOX"></div>
	</div>
	<div class="contents">
		<!--시작---------------------------------------------------------------------------------------------------->
		<table cellpadding="0" cellspacing="0" class="member_form" style="position:relative;z-index:1;">
			<tbody>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id" id="idDupChk" placeholder="아이디" oninput="checkId()" required>
						<div class="validation" id="idDupChkRet" style="font-size: 15px;"></div>
						<span class="subtxt" style="margin-left: 5px;">※ 영문자/숫자
							6~12자 (한글과 여백은 사용하실 수 없습니다.)</span></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" id="pwd" placeholder="비밀번호" oninput="checkPwd()" required>
					 	<div class="validation" id="pwdRet" style="font-size: 15px;"></div>

					</td>
				</tr>
				<tr>
					<th>비밀번호 재확인</th>
					<td><input type="password" name="pwd" id="pwdMatChk" placeholder="비밀번호 재입력" oninput="reCheckPwd()" required>
						<div class="validation" id="pwdMatChkRet" style="font-size: 15px;"></div>
					</td>
				</tr>
				<tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" name='email' id="emailDupChk"
						placeholder="이메일" oninput="chcekEmail()" required>
						<button type="button" id="emailBtn" onclick="">본인인증</button>
						<br />
						<div class="validation" id="emailDupChkRet"
							style="font-size: 15px;"></div></td>
				</tr>


				<tr>
					<th>인증코드</th>
					<td><input type="text" name="checkCode" id="checkCode"
						placeholder="인증번호" required>
						<button type="button" id="codeBtn" onclick="" tabindex="10">인증번호
							확인</button>
						<br />
						<div class="validation" id="checkCodeRet" style="font-size: 15px;"></div>
					</td>
				</tr>


			</tbody>
		</table>
		</div>

<!-- ------------------------------------------------------------------------------------------------------------------- -->
	
	
	<div class="contents">
			<table cellpadding="0" cellspacing="0" class="member_form">
	      <tbody>
	        <tr>
	          <th>이름</th>
	          <td>
	            <input type="text" name='name' placeholder="이름" required>
	          </td>
	        </tr>
	        <tr>
	         <th>연락처</th>
	          <td>
	            <input type="tel" name='tel' id='tel' placeholder="연락처" required>
				<div class="validation" id="telRet" style="font-size: 15px;"></div>
	          </td>
	        </tr>
	        
	        <tr>
	          <th>주소</th>
	          <td>
	            <input type="text" id="postcode" placeholder="우편번호"
							name="zipCode" style="width: 75px; margin-right: 1px" required>
							<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
							<input type="text" id="address" placeholder="주소" name="firstAddr"
							required><br> <input type="text" id="extraAddress"
							placeholder="참고항목" name="extraAddr" required> <input
							type="text" id="detailAddress" placeholder="상세주소 미기입 가능"
							name="secondAddr">
	          </td>
	        </tr>
	        
	        <tr>
	          <th>프로필 사진</th>
	          <td>
	            <input type="file" name="prof" value="" id="prof" />
	            <div id="prof_wrap"></div>
	            <span class="subtxt" style="color: #f24638; padding-top: 5px;">※
								프로필 사진은 필수사항이 아닙니다.</span>
	          </td>
	        </tr>
	        
	         <tr>
	          <th>관심 동물</th>
	          	<td>
	            	<select form="registerNewForm" name="fav">
        				<option value="0">선택안함</option>
        				<option value="1">강아지</option>
        				<option value="2">고양이</option>
        				<option value="3">물고기</option>
        				<option value="4">새</option>
        				<option value="5">기타</option>
   					</select>
	          	</td>
	        </tr>
	        
	        <tr>
	          <th>애완동물 유무</th>
	          	<td>
	            	<select form="registerNewForm" name="pet">
        				<option value="0">선택안함</option>
        				<option value="1">있음</option>
        				<option value="2">없음</option>
   					</select>
	          	</td>
	        </tr>
	        
	        </tbody>
	        </table>
	</div>


	<div class="contents">
			<div class="tit2">한 줄 소개</div>
			<br><textarea rows="3" cols="100" name="ment"  placeholder="한 줄 소개"></textarea>
	</div>



	<!------------------------------------------------------------------------------------------------------->

	<div>
		<p class="button_area">
			<button type="submit" style="width: 240px;" class="btnBig btnBlue"
				tabindex="14">회원가입</button>
			<button type="button" style="width: 240px;" class="btnBig btnBlue"
				onclick='location.href="/poom"' tabindex="14">돌아가기</button>
		</p>
	</div>

	</div>
	
</form>
<jsp:include page="../include/footer.jsp"></jsp:include>