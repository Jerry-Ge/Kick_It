s<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
	
	 String username = (String) request.getSession().getAttribute("username");
	DBConnection db = new DBConnection();
	//String username = db.getCurrUser();
	int userID = db.getUserID(username);
	ArrayList<Integer> gamesJoined = db.getGameJoinedByUser(userID);
	if(gamesJoined.isEmpty()) {
		%>
			<p><font size="+2" color="yellow"><center>You have not joined any games. Go join some!</center></font></p>
		<%
	}
	for (Integer gameID : gamesJoined) {
		String gameName = db.getGameName(gameID);
		String gameSportType = db.getGameSportType(gameID);
		String gameLocation = db.getGameLocation(gameID);
		String gameTime = db.getGameTime(gameID);
		String gameDescription = db.getGameDescription(gameID);
		
		String imageUrl = "";
		DBConnection db1 = new DBConnection();
		imageUrl = db1.getImageUrl(gameSportType);
		String imageUrlTrim = imageUrl.trim();
		%>	
		<%-- <div class="single-room" style="background-image:url(<%=imageUrlTrim%>);">
			<p id="p1"><%= gameName %><br>
			<%= gameTime %><br>
			<%= gameLocation %><br>
			<%= gameDescription %>
			</p>
		</div> --%>
		
		
		<form id="single-game-form" name="single-game-form" action="gameLobby.jsp" method="GET" onsubmit="return gotogamelobby();">
				<input style="display:none;" type="text" value="<%=gameID%>" name="gameId"></input>
				<button id="single-room-button">
				<div class="single-room" style="background-image:url(<%=imageUrlTrim%>);">
					<p id="p1"><%=gameName%><br>
					<%= gameTime%><br>
					<%= gameLocation %><br>
					<%= gameDescription %>
					</p>
				</div>
				</button>
			</form>
		<%
	} 
	%>
</body>
</html>