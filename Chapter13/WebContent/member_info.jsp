<%-- 관리자(admin)에게 회원 정보를 보여주는 페이지 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	String id=null;
	if ((session.getAttribute("id")==null) || 
			(!((String)session.getAttribute("id")).equals("admin"))) {
		out.println("<script>");
		out.println("location.href='loginForm'");
		out.println("</script>");
	}
	String info_id = request.getParameter("id");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn=ds.getConnection();
		
		pstmt=conn.prepareStatement("SELECT * FROM member WHERE id=?");
		pstmt.setString(1, info_id);
		rs=pstmt.executeQuery();
		rs.next();
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리 시스템 관리자모드(회원 정보 보기)</title>
<style>
	table {
		margin : auto;
		width : 400px;
		border : 1px solid gray;
		text-align : center;
	}
</style>
</head>
<body>
<table>
	<tr>
		<td>아이디 : </td>
		<td><%=rs.getString("id") %></td>
	</tr>
	<tr>
		<td>비밀번호 : </td>
		<td><%=rs.getString("password") %></td>
	</tr>
	<tr>
		<td>이름 : </td>
		<td><%=rs.getString("name") %></td>
	</tr>
	<tr>
		<td>나이 : </td>
		<td><%=rs.getString("age") %></td>
	</tr>
	<tr>
		<td>성별 : </td>
		<td><%=rs.getString("gender") %></td>
	</tr>
	<tr>
		<td>이메일 주소 : </td>
		<td><%=rs.getString("email") %></td>
	</tr>
	<tr>
		<td colspan="2"><a href="member_list.jsp">리스트로 돌아가자</a></td>
	</tr>
</table>
</body>
</html>








