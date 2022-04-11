<%@ page contentType="text/html; charset=EUC-KR" %>

<%@page import="com.model2.mvc.service.domain.Purchase"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<%-- <%
	Purchase purchase = (Purchase)request.getAttribute("purchase");
%> --%>

<html>
<head>
<title>Insert title here</title>
<script type="text/javascript">
<!--
function fncupdatePurchase() {
	document.updatePurchase.submit();
}
-->
</script>
</head>

<body>

<form name="updatePurchase" action="/updatePurchaseView.do?tranNo=${purchase.tranNo}" method="post">

다음과 같이 구매가 되었습니다.

<table border=1 cellspacing="5">
	<tr>
		<td width="200" height="50">물품번호</td>
		<td>${purchase.purchaseProd.prodNo}</td>
		<%-- <td><%=purchase.getPurchaseProd().getProdNo() %></td> --%>
		
	</tr>
	<tr>
		<td width="200" height="50">구매자아이디</td>
		<td>${purchase.buyer.userId}</td>

	</tr>
	<tr>
		<td width="200" height="50">구매방법</td>
		<td>		
		<%-- <%if(purchase.getPaymentOption().trim().equals("1")){%>
			현금구매
		<%}else{%>
			신용구매
		<%} %> --%>
		<c:choose>
			<c:when test="${ (fn:trim(purchase.paymentOption)) == '1'}"> 
				현금구매
			</c:when>
			<c:otherwise>
				신용구매
			</c:otherwise>
		</c:choose>
		
		</td>
	
	</tr>
	<tr>
		<td width="200" height="50">구매자이름</td>
		<td>${purchase.receiverName}</td>

	</tr>
	<tr>
		<td width="200" height="50">구매자연락처</td>
		<td>${purchase.receiverPhone}</td>

	</tr>
	<tr>
		<td width="200" height="50">구매자주소</td>
		<td width="500" >${purchase.divyAddr}</td>

	</tr>
		<tr>
		<td width="200" height="50">구매요청사항</td>
		<td>${purchase.divyRequest}</td>

	</tr>
	<tr>
		<td width="200" height="50">배송희망일자</td>
		<td>${purchase.divyDate}</td>
	</tr>
</table>


</form>

</body>
</html>