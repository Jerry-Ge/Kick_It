<!--
Team Member:
Natalie Monger, Yifei Xavier Liu, Jason Woodruff, Yuzhou Jerry Ge, Bradley Nguyen
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="data.DBConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashSet" %>

<%
	DBConnection db = new DBConnection();
	int userID = Integer.parseInt(request.getParameter("userID"));
	int gameID = Integer.parseInt(request.getParameter("gameID"));
	String type = request.getParameter("type");
	int currPlayer = db.getGameCurrPlayer(gameID);
	if (type.equals("join")) {
		db.addGameJoined(userID, gameID);
		currPlayer++;
		db.updateCurrPlayer(gameID, currPlayer);
	} else if (type.equals("exit")) {
		db.removeGamesJoined(userID, gameID);
		currPlayer--;
		db.updateCurrPlayer(gameID, currPlayer);
	}
	
%>




<h3><span id="game-title">Game Name:  </span><%= db.getGameName(gameID) %></h3>
<h3><span id="game-title">Sport Type:  </span><%= db.getGameSportType(gameID) %></h3>
<h3><span id="game-title">Max Player:  </span><%= db.getGameMaxPlayer(gameID) %></h3>
<h3><span id="game-title">Current Player Number:  </span><%= currPlayer %></h3>
<h3><span id="game-title">Age Range:  </span><%= db.getGameAge(gameID) %></h3>
<h3><span id="game-title">Gender:  </span><%= db.getGameGender(gameID) %></h3>
<h3><span id="game-title">Skill Level:  </span><%= db.getGameSkillLevel(gameID) %></h3>
<h3><span id="game-title">Date and Time:  </span><%= db.getGameTime(gameID) %></h3>
<h3><span id="game-title">Location:  </span> <%= db.getGameLocation(gameID) %></h3>
<h3><span id="game-title">Joined Users:  </span>  </h3>

<br>
<%
HashSet<Integer> userIDs = db.getUserJoinedByGame(gameID);
for (Integer ID : userIDs) {
	String userName2 = db.getUserName(ID);
%>
	&nbsp&nbsp&nbsp&nbsp&nbsp
	<div id="user-name">
		<%= userName2 %>
	</div>
	<br>
<% 		
}
%>