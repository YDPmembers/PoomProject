<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Rehome Read</title>
<jsp:include page="../include/inHead.jsp"></jsp:include>
</head>
<jsp:include page="../include/header.jsp"></jsp:include>

    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Begin Page Content -->
        <div class="container-fluid">

          
          <!-- DataTales Example -->
          <div class="card shadow mb-4" >

            <div class="card-body"  align='center' >
              <div class="table-responsive" style=" width:80%;" align='left'>


						<div style="height:100%;">
							<div style="display:none;">게시판 번호: ${rehomeRead.bno}</div>
							<h1 style="font-size:3em;"><strong> ${rehomeRead.title}</strong></h1><br>
							<div align='right'><strong><a href="#" onClick="window.open('report?bno=${rehomeRead.bno}','window_name','width=430,height=500,location=no,status=no,scrollbars=yes');">신고</a>&nbsp;&nbsp;&nbsp;<a href='update?bno=${rehomeRead.bno}'>수정</a>&nbsp;&nbsp;&nbsp;<a href='delete?bno=${rehomeRead.bno}'>삭제</a></strong></div>
							<div style="font-size:1.5em;"> 작성자:<strong> ${rehomeRead.id_writer}</strong></div>							
							<ul>
							<li> 종 분류:<strong> ${rehomeRead.cateName}</strong></li>
							 <li>나이:<strong> ${rehomeRead.age}</strong></li>
							<li> 분양가: <strong>${rehomeRead.cost}</strong></li></ul><br>
							
							<div>
								<div><img src="/resources/img/rehome/${rehomeRead.img_r1 }" onerror="this.style.display='/recources/img/none.png'" width="450" height="450" /> &nbsp;&nbsp;&nbsp;
									 <img src="/resources/img/rehome/${rehomeRead.img_r2 }" onerror="this.style.display='none'" width="450" height="450" />&nbsp;&nbsp;&nbsp;
									 <img src="/resources/img/rehome/${rehomeRead.img_r3 }" onerror="this.style.display='none'" width="450" height="450" /></div><br>
								<div><img src="/resources/img/rehome/${rehomeRead.img_r4 }" onerror="this.style.display='none'" width="450" height="450" />&nbsp;&nbsp;&nbsp;	 
									 <img src="/resources/img/rehome/${rehomeRead.img_r5 }" onerror="this.style.display='none'" width="450" height="450" /></div><br>	 
							</div>				
							
							<br><div style="min-height:500px;"> ${rehomeRead.cont_b}</div><br><br>							
   						</div>
              </div>
              	<div align="center">
								<div><button type="button" class="btn btn-sm btn-outline-secondary" style="color:black; cursor: pointer;" onclick="location.href='pay?bno=${rehomeRead.bno}&id_writer=${rehomeRead.id_writer}&id_reader=${loginMember.id}&cost=${rehomeRead.cost}'">분양받기</button></div><br>
								
							</div>

              
            </div>
          </div>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

<jsp:include page="../include/footer.jsp"></jsp:include>