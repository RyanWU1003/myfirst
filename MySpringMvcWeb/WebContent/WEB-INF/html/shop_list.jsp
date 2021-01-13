<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Furniture</title>
<link rel="stylesheet" href="work.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src=https://code.jquery.com/jquery-3.5.1.min.js></script>
<script type="text/javascript">
	$(function() {

		
		
		$(".update").hide();
		
		$(".show-update").click(function() {
			$(".insert").hide();
			$(".update").show();
			var index=($(this).parent().parent()).index();
            
			$("#ID3").val($(`tbody tr:eq(${index}) td:eq(0)`).text());
			$("#name3").val($(`tbody tr:eq(${index}) td:eq(1)`).text());
			$("#price3").val($(`tbody tr:eq(${index}) td:eq(2)`).text());
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
<%
List<Product> productList = dao.selectAll();
Object count = dao.count();

boolean Cla = false;
boolean betw = false;
betw = Boolean.parseBoolean(String.valueOf(userSession.getAttribute("betw")));
Cla = Boolean.parseBoolean(String.valueOf(userSession.getAttribute("Cla")));
%>
</head>
<body>

	<div class="title">
		<span>My Furniture</span>
	</div>
	<div class="workarea">
		<div class="table">
			<div class="search-container">
				<form method="post"
					action="<%=request.getContextPath()%>/HibernateServlet">
					<button id="button0" name="option" value="5">檢視全部</button>
					<input type="button" id="show-search" value="價格查詢" />
					<input type="button" id="ctg-search" value="種類查詢 " />
					<div class="search-con ctg">
				     <select name="Classification">
						<option selected>請選擇</option>
						<option value="Appliance">Appliance</option>
						<option value="living_room">living_room</option>
						<option value="bedroom">bedroom</option>
						<option value="kitchen">kitchen</option>
						<option value="study">study</option>
					</select>
					    <button id="button7" name="option" value="7">
							<i class="fa fa-search" id="search-icon"></i></button>
					</div>
					<div class="search-con pri">
						<label for="max">最高價格:</label><input type="text" name="max"
							id="max" class="searchbox" value="50000"> <label for="min">最低價格:</label><input
							type="text" name="min" id="min" class="searchbox" value="0">
						<button id="button5" name="option" value="4">
							<i class="fa fa-search" id="search-icon"></i>
						</button>
					</div>
				</form>
			</div>


			<c:choose>
				<c:when test="<%=betw == false && Cla == false%>">
					<p class="count">
						共<%=count%>筆資料
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
								<%
								for (Product p : productList) {
								%>
								<tr>

									<td class="id"><%=p.getProductID()%></td>
									<td class="name"><%=p.getProductName()%></td>
									<td class="price"><%=p.getPrice()%></td>
									<td class="Classification"><%=p.getClassification()%></td>
									<td><a href="#" class="show-update">更改</a> 
									 <a class="del" href="<%=request.getContextPath()%>/HibernateServlet?option=2&ID=<%=p.getProductID()%>">刪除</a>
									</td>

								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>


				</c:when>

				<c:when test="<%= Cla==true %>">
					<%
					String ccc = String.valueOf(userSession.getAttribute("Classv"));
					List<Product> productList3 = dao.selectclass(ccc);
					Object count3 = dao.countclass(ccc);
					%>
					<p class="count">
						共<%=count3%>筆資料
					</p>

					<div class="inside">
						<form method="post"
							action="<%=request.getContextPath()%>/HibernateServlet">
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
									<%
									for (Product p : productList3) {
									%>
									<tr>

										<td><%=p.getProductID()%></td>
										<td><%=p.getProductName()%></td>
										<td><%=p.getPrice()%></td>
										<td><%=p.getClassification()%></td>
										<td><a href="#" class="show-update">更改</a> 
										<a class="del"href="<%=request.getContextPath()%>/HibernateServlet?option=2&ID=<%=p.getProductID()%>">刪除</a></td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</form>
					</div>
					<%
					userSession.setAttribute("Cla", false);
					%>
				</c:when>


				<c:when test="<%=betw==true %>">
					<%
					int max = Integer.parseInt(String.valueOf(userSession.getAttribute("max")));
					int min = Integer.parseInt(String.valueOf(userSession.getAttribute("min")));
					List<Product> productList2 = dao.selectwhere(max, min);
					Object count2 = dao.countwhere(max, min);
					%>
					<p class="count">
						共<%=count2%>筆資料
					</p>
					<div class="inside">
						<form method="post"
							action="<%=request.getContextPath()%>/HibernateServlet">
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
									<%
									for (Product p : productList2) {
									%>
									<tr>

										<td><%=p.getProductID()%></td>
										<td><%=p.getProductName()%></td>
										<td><%=p.getPrice()%></td>
										<td><%=p.getClassification()%></td>
										<td><a href="#" class="show-update">更改</a> 
										<a class="del" href="<%=request.getContextPath()%>/HibernateServlet?option=2&ID=<%=p.getProductID()%>">刪除</a></td>
										<td></td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</form>

					</div>
					<%
					userSession.setAttribute("betw", false);
					%>
				</c:when>
			</c:choose>



			<div class="editarea insert">
				<form method="post"
					action="<%=request.getContextPath()%>/HibernateServlet">
					<span class="insert-title">Create<br />new Furniture
					</span> <input type="text" name="name" id="name"
						placeholder="product name" class="insertbox" autocomplete="off">
					<input type="text" name="price" id="price" placeholder="price"
						class="insertbox">
					 <select name="Classification" class="menu">
						<option disabled="true">請選擇</option>
						<option value="Appliance" selected>Appliance</option>
						<option value="living_room">living_room</option>
						<option value="bedroom">bedroom</option>
						<option value="kitchen">kitchen</option>
						<option value="study">study</option>
					</select>
					<div class="btn-area">
						<button id="button1" name="option" value="1">送出</button>
					</div>
				</form>
			</div>
			<%-- int id= Integer.parseInt(String.valueOf(userSession.getAttribute("ID")));
	   String name=String.valueOf(userSession.getAttribute("name"));
	   int price= Integer.parseInt(String.valueOf(userSession.getAttribute("price")));
	--%>
			<div class="editarea update">
				<form method="post"
					action="<%=request.getContextPath()%>/HibernateServlet">
					    <span id="updateid">ID:</span><input type="text" name="ID" id="ID3" readonly> 
						<input type="text" name="name" id="name3" class="insertbox"> 
						<input type="text" name="price" id="price3"  class="insertbox">
				     <select name="Classification" class="menu">
						<option disabled="true">請選擇</option>
						<option value="Appliance" selected>Appliance</option>
						<option value="living_room">living_room</option>
						<option value="bedroom">bedroom</option>
						<option value="kitchen">kitchen</option>
						<option value="study">study</option>
					</select>
					<div class="btn-area" id="update-btnarea">
						<input id="redo" type="button" value="取消">
						<button id="button3" name="option" value="3">確認修改</button>
					</div>
				</form>


			</div>
		</div>

	</div>

</body>
</html>