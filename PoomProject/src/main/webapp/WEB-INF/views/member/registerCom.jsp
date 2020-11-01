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
	#prof_wrap,
	#brn_img_wrap {
		width: 300px;
	}
	#prof_wrap img {
		max-width: 200px;
		margin-top: 15px;
	}
	#brn_img_wrap img {
		width: 500px;
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
var sel_filesB = [];
//유효성 기능 활성화
$().ready(function(){

	// 업로드 이미지 미리보기
	$('#prof').on('change', handleImgFilesSelect);
	$('#brn_img').on('change', handleImgFilesSelectB);

	

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

function handleImgFilesSelectB(e) {

	// 기존에 고른 사진 지우기
	$('#brn_img_wrap').empty();
	
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);

	filesArr.forEach( function(f) {
		
		if (!f.type.match('image.*')) {
			alret("이미지 파일만 업로드 가능합니다.");
			return;
		}

		sel_filesB.push(f);

		var reader = new FileReader();
		reader.onload = function(e) {
			var img_html = "<img src='"+e.target.result + "' />";
			$('#brn_img_wrap').append(img_html);
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


// //--------------정규식 var모음----------------------



// //아이디 정규식-8~12자의 영문 소문자, 숫자만 사용 가능합니다.
// var idR=/^[a-z0-9]{8,12}$/;
// //비밀번호 정규식-7~15자의 영문 대소문자, 숫자와 특수기호~!@\#$%<>^&*로만 사용 가능합니다.
// var pwdR=/.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*/;
// //이메일 검사 정규식-이메일 양식을 확인해주세요 
// var emailR=/^[a-zA-Z0-9._-]+@[a-zA-z0-9.-]+\.[a-zA-Z]{2,4}$/

// // /^[a-zA-Z0-9!#$%^&*_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+){1,2}$/;


// //휴대폰 번호 정규식-'-'없이 번호만 입력해주세요
// var phoneR=/^01([0|1|?)?([0-9]{8,9})$/;


		
// //-----------------------------------------------------------------

//   //ID 중복체크 및 정규식 실행문 
//   function checkId(){
// 	 var regExIdResult = regExId(); //정규식 실행문
// 	 //alert("regExIdResult",regExIdResult);
// 	 //console.log("regExIdResult",regExIdResult)
	 
// 	 if (regExIdResult == true ) {
// 	 	//console.log("")
// 		//alert("유효성체크확인 들어옴")
// 		var idDupChk = $('#idDupChk').val();
// 		//alert ("idDupChk = " + idDupChk);

// 		$.ajax({
// 				url : '/poom/register/idDupChk',
// 				data : {
// 					id : idDupChk
// 				},
// 					dataType : 'text' , // html, text, json, xml, script
// 					method : 'post',
// 					success : function(data) {
// 						//alert("idDupChk ajax 성공");
// 					if ( data == 0 ) {
// 							alert ("중복되지 않은 ID입니다.");
// 							$('#idDupChkRet').text('사용가능한 ID입니다.');
// 						    $('#idDupChkRet').css('color', 'green');

// 						} else if ( data == 1 ) {
// 							//alert("중복된 ID입니다.")
// 							$('#idDupChkRet').text('사용 불가능한 ID입니다');
// 						    $('#idDupChkRet').css('color', 'green');

// 						} else {
// 							//alert("에러");
// 							$("#idDupChkRet").text("관리자에게 문의하세요.");
// 						}
// 					},
// 					error : function() {
// 						alert("idDupChk ajax 에러")
// 					}
// 		});
//   	   }
// 	}

//  //클릭하면 바로 텍스트 보여줌 활성화 하자
//  $(document).ready(function(){
// 	   $('#idDupChk').focus(function() {
// 		   regExId();
// 	   });

// 	   $('#pwd').focus(function() {
// 		      checkPwd();
// 	   });
// 	});
	
//  function regExId(){
// 	    //아이디 유효성 검사(정규식)
// 	    if($('#idDupChk').val() == ''){
// 	       $('#idDupChkRet').text('아이디를 입력해주세요');
// 	       $('#idDupChkRet').css('color', 'red');
// 	   } else if(idR.test( $('#idDupChk').val() ) != true){
// 	      $('#idDupChkRet').text('8~12자의 영문 소문자, 숫자만 사용 가능합니다.');
// 	      $('#idDupChkRet').css('color', 'red');
// 	      return false;
// 	   } else {
// 	       return true;
// 	   }
// 	 }


 
// //-----------------------------------------------------------------
//  //비번 유효성 검사 
//   //클릭하면 바로 텍스트 보여줌 활성화 하자

 
//  function checkPwd(){
// 	 if(pwdR.test( $("#pwd").val()) == true) {
// 		 $("#pwdRet").text("사용가능한 비밀번호 입니다.");
// 		 $("#pwdRet").css("color",'green');
// 		 return true;
// 	 } else {
// 		 $("#pwdRet").text("특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내의 암호 정규식로만 사용 가능합니다.");
// 		 $("#pwdRet").css("color","red");
// 		 return false;
// 	 }
// }
 
//  //비번 재입력 일치 확인
//  //클릭하면 바로 텍스트 보여줌 활성화 하자
//  $(document).ready(function(){
// 	   $('#pwdMatChk').focus(function(){
// 		   reCheckPwd();
// 	   });
// 	})
//  function reCheckPwd() {
// 	 if($("#pwdMatChk").val() == '') {
// 		 $("#pwdMatChkRet").text("비밀번호를 재입력 해주세요");
// 		 $("#pwdMatChkRet").css("color","red");
// 	 } else if($("#pwd").val() !=$("#pwdMatChk").val() ) {
// 		 $("#pwdMatChkRet").text("비밀번호가 일치하지 않습니다.");
// 		 $("#pwdMatChkRet").css("color","red");

// 	 } else {
// 		 $("#pwdMatChkRet").text("비밀번호가 일치합니다.");
// 		 $("#pwdMatChkRet").css("color","green");
// 	 }

// }


// //-----------------------------------------------------------------

// //Email 중복체크 및 정규식 실행문 
// function chcekEmail(){
// 	var regExEmailResult = regExEmail();

// 	if(regExEmailResult == true ) {
// 		var emailDupChk = $("#emailDupChk").val();

// 		$.ajax({
			
// 			url : '/poom/register/emailDupChk',
// 			data : {
// 				id : emailDupChk
// 			},
// 				dataType : 'text',
// 				method : 'post',
// 				success : function(data) {
// 					console.log("에이작스 성공  들어옴");

// 				if ( data == 0 ){
// 					console.log("데이터 0");
// 					$("emailDupChkRet").text('사용가능한 Email입니다.')
// 					$("emailDupChkRet").css('color','green')
// 				} else if( data == 1 ){
// 					console.log("데이터 1");
// 					$("emailDupChkRet").text('중복된 Email입니다.')
// 					$("emailDupChkRet").css('color','red')
// 				} else {
// 					$("#emailDupChkRet").text("관리자에게 문의하세요.");
// 				}	
// 			},
// 			error : function() {
// 				console.log("에이작스 에러 왜!!");
// 				//alert("emailDupChk ajax 에러")
// 			}
// 	});
// 	}
// }


// //클릭하면 바로 텍스트 보여줌 활성화 하자
// $(document).ready(function(){
// 	   $('#emailDupChk').focus(function(){
// 		   regExEmail();
// 	   });
// })
 
//  function regExEmail(){
// 	//이메일 유효성 검사(정규식)
// 	if($("#emailDupChk").val() ==''){
// 		console.log("정규식 시험 1")
// 	   $("#emailDupChkRet").text("Email를 입력해주세요.");
// 	   $("#emailDupChkRet").css("color","red");
// 	} else if (emailR.test( $("#emailDupChk").val() ) != true){
// 		console.log("정규식 시험 2")
// 		$("#emailDupChkRet").text("이메일 양식에 맞춰서 확인해주세요.")
// 		$("#emailDupChkRet").css("color","red")
// 		return false;
// 	} else {
// 		return true;
// 		console.log("정규식 시험 3확인")
// 	}
	
// }


// //-----------------------------------------------------------------
//     function sample6_execDaumPostcode() {
//         new daum.Postcode({
//             oncomplete: function(data) {
//                 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

//                 // 각 주소의 노출 규칙에 따라 주소를 조합한다.
//                 // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
//                 var addr = ''; // 주소 변수
//                 var extraAddr = ''; // 참고항목 변수

//                 //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
//                 if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
//                     addr = data.roadAddress;
//                 } else { // 사용자가 지번 주소를 선택했을 경우(J)
//                     addr = data.jibunAddress;
//                 }

//                 // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
//                 if(data.userSelectedType === 'R'){
//                     // 법정동명이 있을 경우 추가한다. (법정리는 제외)
//                     // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
//                     if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
//                         extraAddr += data.bname;
//                     }
//                     // 건물명이 있고, 공동주택일 경우 추가한다.
//                     if(data.buildingName !== '' && data.apartment === 'Y'){
//                         extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
//                     }
//                     // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
//                     if(extraAddr !== ''){
//                         extraAddr = ' (' + extraAddr + ')';
//                     }
//                     // 조합된 참고항목을 해당 필드에 넣는다.
//                     document.getElementById("sample6_extraAddress").value = extraAddr;
                
//                 } else {
//                     document.getElementById("sample6_extraAddress").value = '';
//                 }

//                 // 우편번호와 주소 정보를 해당 필드에 넣는다.
//                 document.getElementById('sample6_postcode').value = data.zonecode;
//                 document.getElementById("sample6_address").value = addr;
//                 // 커서를 상세주소 필드로 이동한다.
//                 document.getElementById("sample6_detailAddress").focus();
//             }
//         }).open();
//     }

// //-----------------------------------------------------------------

</script>
  
</head>
<jsp:include page="../include/header.jsp"></jsp:include>
<!--####### 상단 시작 #######-->
<!-- <div id="header"> -->
<!-- 	<h1 style="width: 795px !important;"> -->
<!-- 		<a href="http://www.compuzone.co.kr/main/main.htm"> -->
<!-- 		<img src="/resources/img/poom_logo5.png" alt="POOM" style="width:140px; height:auto; border-radius:30px"/> -->
<!-- 		</a> -->
<!-- 		<img src="/resources/img/poom_logo5.png" alt="회원가입" /> -->
<!-- 	</h1> -->
<!-- </div> -->


<form action="com" method="post"  enctype="multipart/form-data">
	<div id="container">

	<!-- 딜러회원가입시 노출 영역 -->
	<div class="contents">
		<div class="tit">업체회원가입!!!</div>
		<div class="contentsBOX"></div>
	</div>
	<div class="contents">
		<!--시작---------------------------------------------------------------------------------------------------->
		<table cellpadding="0" cellspacing="0" class="member_form" style="position:relative;z-index:1;">
			<tbody>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="id" id="idDupChk"
						placeholder="아이디" oninput="checkId()" required>
						<div class="validation" id="idDupChkRet" style="font-size: 15px;"></div>
						<span class="subtxt" style="margin-left: 5px;">※ 영문자/숫자
							6~12자 (한글과 여백은 사용하실 수 없습니다.)</span></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" id="pwd" placeholder="비밀번호"
						oninput="checkPwd()" required>
						<div class="validation" id="pwdRet" style="font-size: 15px;"></div>

					</td>
				</tr>
				<tr>
					<th>비밀번호 재확인</th>
					<td><input type="password" name="pwd" id="pwdMatChk"
						placeholder="비밀번호 재입력" oninput="reCheckPwd()" required>
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
	  <div class="tit2">사업자등록증 입력</div>
	    <table cellpadding="0" cellspacing="0" class="member_form">
	      <tbody>
	        <tr>
	          <th>사업자 번호</th>
	          <td>
	            <input type="text" name="brn" placeholder="사업자 번호"required>
	          </td>
	        </tr>
          <tr>
	          <th>사본 업로드</th>
	          <td>
	          	<input type="file" name='brn_img' value="" id="brn_img" required>
	            <i style="color:#000; font-size:13px; font-style:normal;" id="TaxAccountCopyFileName"></i>
	            <div id="brn_img_wrap"></div><br/>
              <span class="subtxt" style=" color:#f24638; padding-top:5px;">※ 사업자등록증 사본을 업로드 하지 않은 경우 세금계산서 발급이 되지 않습니다.</span>
	          </td>
	        </tr>
	        <tr>
	          <th>상호(매장명)</th>
	          <td>
	            <input type="text" name="name" placeholder="매장명" required />
	          </td>
	        </tr>
	        
	        <tr>
	          <th>전화번호</th>
	          <td>
	          	<input type="tel" name="tel" id="tel"placeholder="전화번호 입력" required>
				<div class="validation" id="telRet" style="font-size: 15px;"></div>
              </td>
	        </tr>
	        
	        <tr>
	          <th>사업장주소</th>
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
	         <th>매장 사이트</th>
	          <td>
	            <input type="text" name="url_c"
							style="width: 200px; float: left; margin-right: 15px;" value="" />
	          </td>
	        </tr>
	        
	        
	        
	        
	      </tbody>
	    </table>
	</div>
	<div class="contents">
			<div class="tit2">소개 멘트</div>
			<br><textarea rows="5" cols="85" name="ment"></textarea>
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