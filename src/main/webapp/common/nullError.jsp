<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<html>
	<body>
	
		<h3> NullPointerException page</h3>
		<%	Exception exception = (Exception)request.getAttribute("exception");	%>
		<br/><br/><br/>  
		<%="Java Code�� �̿��� ���� Message ���� :: " +  exception.getMessage() %><br/>
		EL�� �̿��� ���� Message ���� :: ${ exception.message }<br/> 
		
		<hr/>
		<br/>
		<%=  request.getRequestURI() %>
		<br/>
		<%=  request.getRequestURL() %>
		
	</body>
</html>