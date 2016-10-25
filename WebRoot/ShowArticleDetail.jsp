<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ page import="java.sql.*"%>

<%
	String strId = request.getParameter("id");
	int id = Integer.parseInt(strId);
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost/bbs?user=root&password=zhanglihong";
	Connection conn = DriverManager.getConnection(url);

	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from article where id = " + id);

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ShowArticleDetail.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
	<%
		if(rs.next()) {
	%>

	<table border="1">
		<tr>
			<td>ID</td>
			<td><%=rs.getInt("id") %></td>
		</tr>
		<tr>
			<td>Title</td>
			<td><%=rs.getString("title") %></td>
		</tr>
		<tr>
			<td>Content</td>
			<td><%=rs.getString("cont") %></td>
		</tr>
	</table>

  
	<a href="Reply.jsp?id=<%= rs.getInt("id")%>&rootid=<%=rs.getInt("rootid") %>">»Ø¸´</a>  
<%	
}
rs.close();
stmt.close();
conn.close();
%>
    
  </body>
</html>
