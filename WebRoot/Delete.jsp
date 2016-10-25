<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%!
private void del(Connection conn, int id) {
	Statement stmt = null;
	ResultSet rs = null;
	
	try {
		stmt = conn.createStatement();
		String sql = "select * from article where pid = " + id;
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			del(conn, rs.getInt("id"));
		}
		stmt.executeUpdate("delete from article where id = " + id);
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs != null) {
				rs.close();
				rs = null;
			}
			if(stmt != null) {
				stmt.close();
				stmt = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
%>

<%
String admin = (String)session.getAttribute("admin");
if(admin == null || !admin.equals("true")) {
	out.println("小贼! 别想通过我这关!");
	return;
}
%>
<%
int id = Integer.parseInt(request.getParameter("id"));
int pid = Integer.parseInt(request.getParameter("pid"));

Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost/bbs?user=root&password=zhanglihong";
Connection conn = DriverManager.getConnection(url);

conn.setAutoCommit(false);

del(conn, id);

Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("select count(*) from article where pid = " + pid);
rs.next();
int count = rs.getInt(1);
rs.close();
stmt.close();

if(count <= 0) {
	Statement stmtUpdate = conn.createStatement();
	stmtUpdate.executeUpdate("update article set isleaf = 0 where id = " + pid);
	stmtUpdate.close();
} 

conn.commit();
conn.setAutoCommit(true);
conn.close();
response.sendRedirect("ShowArticleTree.jsp");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Delete.jsp' starting page</title>
    
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
  </body>
</html>
