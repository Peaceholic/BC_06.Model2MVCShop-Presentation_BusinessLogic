<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<% System.out.println("* [ listProduct.jsp ] "); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<%--

<%@ page import="java.util.List"%>

<%@ page import="com.model2.mvc.common.Search"%>
<%@ page import="com.model2.mvc.common.Page"%>
<%@ page import="com.model2.mvc.common.util.CommonUtil"%>

<%@ page import="com.model2.mvc.service.domain.User"%>
<%@ page import="com.model2.mvc.service.domain.Product"%>

	User user = (User) session.getAttribute("user");
	String menu = (String) request.getParameter("menu");

	List<Product> list = (List<Product>) request.getAttribute("list");
	Page resultPage = (Page) request.getAttribute("resultPage");

	Search search = (Search) request.getAttribute("search");

	//==> null 을 ""(nullString)으로 변경
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
--%>

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	function fncGetProductList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
	   	document.detailForm.submit();	
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm" action="/listProduct.do?menu=${menu}" method="post">

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37"></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
							
								<%-- if (menu == null || menu.equals("manage")) { %>
							
								<td width="93%" class="ct_ttl01">상품 관리</td>
								
								<% } else { %>
								
								<td width="93%" class="ct_ttl01">상품 목록조회</td>
								
								<% } --%>
							<c:choose>
								<c:when test="${ empty param.menu || param.menu == 'manage'}"> 
									<td width="93%" class="ct_ttl01">상품 관리</td>
								</c:when>
								<c:otherwise>
									<td width="93%" class="ct_ttl01">상품 목록조회</td>
								</c:otherwise>
							</c:choose>

							</tr>

						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37"></td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="right"><select name="searchCondition"
						class="ct_input_g" style="width: 80px">
							<option value="0" ${search.searchCondition eq '0' ? "selected" : "" }>상품번호</option>
							<option value="1" ${search.searchCondition eq '1' ? "selected" : "" }>상품명</option>
							<option value="2" ${search.searchCondition eq '2' ? "selected" : "" }>가격</option>
					</select> 
					
						<input type="text" name="searchKeyword" 
						value="${! empty search.searchKeyword ? search.searchKeyword : ''}"  
						class="ct_input_g" style="width:200px; height:20px" > 
						
					
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;"><a
									href="javascript:fncGetProductList(1);">검색</a></td>
								<td width="14" height="23"><img
									src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage }페이지
					</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="50">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="80">가격</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="100">등록일</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">현재상태</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
			
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			
			<%-- if (( user != null && user.getRole().equals("admin")) || product.getProTranCode().equals("0")) { %>
					
			<td align="left">
			<a href="/getProduct.do?prodNo=<%=product.getProdNo()%>&menu=${param.menu}"><%=product.getProdName()%></a></td>
					
			<% } else { %>
			<td align="left"><%=product.getProdName()%></td>
				
			<% } --%>
			
			<c:choose>
				<c:when test="${ !empty user && user.role == 'admin' || product.proTranCode == '0' }"> 
					<td align="left">
					<a href="/getProduct.do?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a></td>
				</c:when>
				<c:otherwise>
					<td align="left">
					<a href="/getProduct.do?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a></td>
				</c:otherwise>
			</c:choose>	
		
			<td></td>
			<td align="center">${product.price}</td>
			<td></td>
			<td align="center">${product.regDate}			
			<td></td>
			<td align="left">
			
		<%-- if (product.getProTranCode() == null || product.getProTranCode().equals("0")) { %> 
		     판매중 
		<% } else if (Integer.parseInt(product.getProTranCode()) > 0 && (user == null || user.getRole().equals("user"))) { %> 
			 재고 없음 
		<% } else if (product.getProTranCode().equals("1")) { %> 
			 구매완료 
		<%  	if (menu.equals("manage")) { %> 
		    <a href="/updateTranCodeByProd.do?prodNo=<%=product.getProdNo()%>&tranCode=2">배송하기</a>
		<%		}
			} else if (product.getProTranCode().equals("2")) { %> 
			배송중 
		<%	} else { %> 
			배송완료 
		<%	} --%>
			
			<c:choose>
				<c:when test="${ empty product.proTranCode || product.proTranCode == '0' }"> 
					판매중
				</c:when>				
				<c:when test="${ product.proTranCode == '1' }"> 
					<c:choose>
    					<c:when test="${ param.menu == 'manage' }"> 
    						구매완료 <a href="/updateTranCodeByProd.do?prodNo=${product.prodNo }&tranCode=2">배송하기</a>
    					</c:when>
    					<c:otherwise> 
    						구매완료
    					</c:otherwise>
    				</c:choose>
				</c:when>
				<c:when test="${ product.proTranCode == '2' }"> 
					배송중
				</c:when>							
				<c:otherwise>
					배송완료
				</c:otherwise>
				</c:choose>		
						
			</td>		
		</tr>
		<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
			</table>

			<!-- PageNavigation Start... -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center"><input type="hidden" id="currentPage"
						name="currentPage" value="" /> 
												
						<jsp:include page="../common/pageNavigatorProd.jsp"/>
					</td>
				</tr>
			</table>		
			<!-- PageNavigation End... -->
		</form>
	</div>

</body>
</html>