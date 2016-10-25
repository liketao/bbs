<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%@ page import="java.sql.*"%>

<%
	String admin = (String) session.getAttribute("admin");
	if (admin != null && admin.equals("true")) {
		login = true;
	}
%>

<%!String str = "";
	boolean login = false;

	private void tree(Connection conn, int id, int level) {
		Statement stmt = null;
		ResultSet rs = null;
		String preString = "";
		for (int i = 0; i < level; i++) {

			preString += "----";

		}
		try {
			stmt = conn.createStatement();
			String sql = "select * from article where pid = " + id;
			rs = stmt.executeQuery(sql);
			String strLogin = "";
			while (rs.next()) {
				if (login) {
					strLogin = "<td><a href='Delete.jsp?id=" + rs.getInt("id")
							+ "&pid=" + rs.getInt("pid") + "'>É¾³ý</a>";
				}
				str += "<tr><td>" + rs.getInt("id") + "</td><td>" + preString
						+ "<a href='ShowArticleDetail.jsp?id="
						+ rs.getInt("id") + "'>" + rs.getString("title")
						+ "</a></td>" + strLogin + "</td></tr>";
				if (rs.getInt("isleaf") != 0) {
					tree(conn, rs.getInt("id"), level + 1);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			try {

				if (rs != null) {

					rs.close();
					rs = null;
				}
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}

			} catch (SQLException e) {

				e.printStackTrace();

			}
		}
	}%>

<%
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost/bbs?user=root&password=zhanglihong";
	Connection conn = DriverManager.getConnection(url);

	Statement stmt = conn.createStatement();
	ResultSet rs = stmt
			.executeQuery("select * from article where pid = 0");
	String strLogin = "";
	while (rs.next()) {
		if (login) {
			strLogin = "<td><a href='Delete.jsp?id=" + rs.getInt("id")
					+ "&pid=" + rs.getInt("pid") + "'>É¾³ý</a>";
		}
		str += "<tr><td>" + rs.getInt("id") + "</td><td>"
				+ "<a href='ShowArticleDetail.jsp?id="
				+ rs.getInt("id") + "'>" + rs.getString("title")
				+ "</a></td>" + strLogin + "</td></tr>";
		if (rs.getInt("isleaf") != 0) {
			tree(conn, rs.getInt("id"), 1);
		}
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'ShowArticleTree.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>
<%
	rs.close();
	stmt.close();
	conn.close();
%>

<body>
	<a href="Post.jsp">·¢±íÐÂÌû</a>
	<table border=1>
		<%=str%>

	</table>

</body>

<%
	str = "";
%>


</html>
