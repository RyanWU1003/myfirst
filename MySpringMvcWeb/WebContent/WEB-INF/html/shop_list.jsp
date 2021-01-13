<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Furniture</title>
<link rel="stylesheet" href="<c:url value="/css/work.css"/>">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<script src="${path }/css/javascripts/jquery-3.5.1.min.js"/></script>
<script type="text/javascript">
	$(function() {


		$(".update").hide();

		$(".show-update").click(function() {
			$(".insert").hide();
			$(".update").show();

		})

		$("#button").click(function() {
			$(".update").hide();
			$(".insert").show();
		})

		$("#redo").click(function() {
			$(".update").hide();
			$(".insert").show();

		})
        $(".pri").hide();
        $(".ctg").hide();
        
		$("#show-search").click(function() {
			$(".pri").show();
			 $(".ctg").hide();
			 $("#show-search").addClass("clicked");
			 $("#ctg-search").removeClass("clicked");
		})
		
		$("#ctg-search").click(function() {
			$(".ctg").show();
			$("#ctg-search").addClass("clicked");
			$(".pri").hide();
			$("#show-search").removeClass("clicked");
		})
		$("#button0").click(function(){
			$("#show-search").removeClass("clicked");
			$("#ctg-search").removeClass("clicked");
			})
		
	})
</script>
</head>
<body>

	<div class="title">
		<span>My Furniture</span>
	</div>
	<div class="workarea">
		<div class="table">
			<div class="search-container">
				<form method="post"
					action="selectAll">
					<button id="button0" name="option" value="5">檢視全部</button>
					<input type="button" id="show-search" value="價格查詢" />
					<input type="button" id="ctg-search" value="種類查詢 " />
				</form>
				<form action="selectClass" method="post">
					<div class="search-con ctg">
				     <select name="Classification">
						<option selected>請選擇</option>
						<option value="Appliance">Appliance</option>
						<option value="living_room">living_room</option>
						<option value="bedroom">bedroom</option>
						<option value="kitchen">kitchen</option>
						<option value="study">study</option>
					</select>
					    <button id="button7" type="submit">
							<i class="fa fa-search" id="search-icon"></i></button>
					</div>
				</form>
				<form action="selectPrice" method="post">
					<div class="search-con pri">
						<label for="max">最高價格:</label><input type="text" name="max"
							id="max" class="searchbox" value="50000"> <label for="min">最低價格:</label><input
							type="text" name="min" id="min" class="searchbox" value="0">
						<button id="button5" type="submit">
							<i class="fa fa-search" id="search-icon"></i>
						</button>
					</div>
				</form>
			</div>


			<c:choose>
				<c:when test="${selection == 'all' or empty selection}">
					<p class="count">
						共 ${count}筆資料
					</p>
					<div class="inside">
						<table>
							<thead>
								<tr>
									<th>產品ID</th>
									<th>產品名稱</th>
									<th>產品價格</th>
									<th>產品種類</th>
									<th>編輯</th>
								</tr>
							</thead>
							<tbody>
								
								<c:forEach var="product" items="${productList }">
                                   <tr>
									<td class="id">${product.productID }</td>
									<td class="name">${product.productName }</td>
									<td class="price">${product.price }</td>
									<td class="Classification">${product.classification }</td>
									<td><a href="select?id=${product.productID }" class="show-update">更改</a> 
									 <a class="del" href="delAction?id=${product.productID }">刪除</a>
									</td>
									</tr>
								</c:forEach>
								
								
							</tbody>
						</table>
					</div>


				</c:when>

				<c:when test="${selection == 'selectClass' }">
					<p class="count">
						共 ${count}筆資料
					</p>
					<div class="inside">
						<table>
							<thead>
								<tr>
									<th>產品ID</th>
									<th>產品名稱</th>
									<th>產品價格</th>
									<th>產品種類</th>
									<th>編輯</th>
								</tr>
							</thead>
							<tbody>
								
								
								<c:forEach var="product" items="${productList }">
                                 <tr>
									<td class="id">${product.productID }</td>
									<td class="name">${product.productName }</td>
									<td class="price">${product.price }</td>
									<td class="Classification">${product.classification }</td>
									<td><a href="select?id=${product.productID }" class="show-update">更改</a> 
									 <a class="del" href="delAction?id=${product.productID }">刪除</a>
									</td>
									</tr>
								</c:forEach>
								
								
							</tbody>
						</table>
					</div>


				</c:when>



				<c:when test="${selection == 'limitPrice'}">
					<p class="count">
						共 ${count}筆資料
					</p>
					<div class="inside">
						<table>
							<thead>
								<tr>
									<th>產品ID</th>
									<th>產品名稱</th>
									<th>產品價格</th>
									<th>產品種類</th>
									<th>編輯</th>
								</tr>
							</thead>
							<tbody>
								
								
								<c:forEach var="product" items="${productList }">
<tr>
									<td class="id">${product.productID }</td>
									<td class="name">${product.productName }</td>
									<td class="price">${product.price }</td>
									<td class="Classification">${product.classification }</td>
									<td><a href="select?id=${product.productID }" class="show-update">更改</a> 
									 <a class="del" href="delAction?id=${product.productID }">刪除</a>
									</td>
									</tr>
								</c:forEach>
								
								
							</tbody>
						</table>
					</div>


				</c:when>

			</c:choose>



			<div class="editarea insert">
				<form method="post"
					action="addAction">
					<span class="insert-title">Create<br />new Furniture
					</span> <input type="text" name="name" id="name"
						placeholder="product name" class="insertbox" autocomplete="off">
					<input type="text" name="price" id="price" placeholder="price"
						class="insertbox">
					 <select name="classification" class="menu">
						<option disabled="true">請選擇</option>
						<option value="Appliance" selected>Appliance</option>
						<option value="living_room">living_room</option>
						<option value="bedroom">bedroom</option>
						<option value="kitchen">kitchen</option>
						<option value="study">study</option>
					</select>
					<div class="btn-area">
						<button id="button1" type="submit">送出</button>
					</div>
				</form>
			</div>
			


			</div>
		</div>

	</div>

</body>
</html>