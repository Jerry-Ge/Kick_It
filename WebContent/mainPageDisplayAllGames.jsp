<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="data.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	try {
		DBConnection db = new DBConnection();
		ResultSet rs = db.st.executeQuery("SELECT * FROM Games");
		if(!rs.isBeforeFirst()) {
			%>
				<p><font size="+2" color="yellow"><center>Sorry, there are no games available with these filter settings</center></font></p>
			<%
		}
		while (rs.next()) {
			String sportType = rs.getString("sportType");
			int gameId = Integer.parseInt(rs.getString("gameID"));
			String imageUrl = "";
			DBConnection db1 = new DBConnection();
			imageUrl = db1.getImageUrl(sportType);
			String imageUrlTrim = imageUrl.trim();
			%>
			<form id="single-game-form" name="single-game-form" action="gameLobby.jsp" method="GET" onsubmit="return gotogamelobby();">
				<input style="display:none;" type="text" value="<%=gameId%>" name="gameId"></input>
				<button id="single-room-button">
				<div class="single-room" style="background-image:url(<%=imageUrlTrim%>);">
					<p id="p1"><%= rs.getString("gameName") %><br>
					<%= rs.getString("gameTime") %><br>
					<%= rs.getString("location") %><br>
					<%= rs.getString("description") %>
					</p>
				</div>
				</button>
			</form>
			<%
		}
	} catch (SQLException sqle) {
		System.out.println("sqle " + sqle.getMessage());
	}
	%>
</body>
</html>