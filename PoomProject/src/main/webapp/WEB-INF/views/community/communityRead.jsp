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

          <!-- Page Heading -->
         
          <p class="mb-4">
          &nbsp;&nbsp;&nbsp;
                  <section class="jumbotron text-center" style='background: linear-gradient(to top, lavender, white);'>
			<div class="container">
				<h1>
               <font color='skyblue' size='20px'>POOM</font>
				</h1>
				<p class="lead text-muted">
				</p>
				      <p>
				       <button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='add'">신규 등록</button>
				      </p>
			</div>
		</section>

          </p>
          <!-- DataTales Example -->
          <div class="card shadow mb-4">

            <div class="card-body">
              <div class="table-responsive" align="center">

<div class="container-fluid">
  <div class="row" >
    <div class="col-sm-2" style="background-color:lavenderblush;">제목</div>
    <div class="col-sm-10" align="left">${communityRead.title}</div>
    <div class="col-sm-2" style="background-color:lavenderblush; display:none;">게시판 번호</div>
    <div class="col-sm-10" style="display:none;" align="left">${communityRead.bno}</div>
   <div class="col-sm-2" style="background-color:lavenderblush;">작성자</div>
    <div class="col-sm-10" align="left"> ${communityRead.id_writer}</div>
     <div class="col-sm-2" style="background-color:lavenderblush;">작성일</div>
    <div class="col-sm-10" align="left"><fmt:formatDate pattern="yyyy-MM-dd" value="${communityRead.mod_date_b}" /></div>
    <div class="col-sm-2" style="background-color:lavenderblush; display:none;">회원번호</div>
    <div class="col-sm-10" style="display:none;" align="left">${communityRead.mno}</div>
  </div>
</div>	
							<div align="right"><a href="#" onClick="window.open('report?bno=${communityRead.bno}','window_name','width=430,height=500,location=no,status=no,scrollbars=yes');">신고</a>
							<a href='update?bno=${communityRead.bno}'>수정</a>
							<a href='delete?bno=${communityRead.bno}'>삭제</a></div><br>
							<!-- <div>작성자: ${communityRead.id_writer}</div>
							<div>제목: ${communityRead.title}</div> 
							<div>회원번호: ${communityRead.mno}</div>-->
							<img src="/resources/img/community/${communityRead.img_c1 }" onerror="this.style.display='none'" width="200" height="200" />
							<img src="/resources/img/community/${communityRead.img_c2 }" onerror="this.style.display='none'" width="200" height="200" />
							<img src="/resources/img/community/${communityRead.img_c3 }" onerror="this.style.display='none'" width="200" height="200" />
							<img src="/resources/img/community/${communityRead.img_c4 }" onerror="this.style.display='none'" width="200" height="200" />
							<img src="/resources/img/community/${communityRead.img_c5 }" onerror="this.style.display='none'" width="200" height="200" />
							<div>${communityRead.cont_b}</div>
							
							
						</div>
   
   


              
              
              </div>
            </div>
          </div>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

<jsp:include page="../include/footer.jsp"></jsp:include>