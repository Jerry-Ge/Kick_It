<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="data.DBConnection" %>

<%
	DBConnection db = new DBConnection();
	String gameName = request.getParameter("gameName");
	String sportType = request.getParameter("sportType");
	String gameTime = request.getParameter("gameTime");
    int maxPlayers = Integer.parseInt(request.getParameter("maxPlayers"));
	String comment = request.getParameter("comment");
	String gameLoc = request.getParameter("gameLoc");
	String ageRange = request.getParameter("ageRange");
	String gender = request.getParameter("gender");
	String skillLevel = request.getParameter("skillLevel");
    
    String errorMessage = "";
    
    
	if(gameName == null || gameName.trim().length() == 0) {
    	errorMessage += "<font color=\"red\">Please enter a game name.</font><br/>";	
    }
	
	if(gameTime == null || gameTime.trim().length() == 0) {
    	errorMessage += "<font color=\"red\">Please enter a game time.</font><br/>";	
    }
	
    // validate if gameName exists in database
    if (db.GameNameExist(gameName)) {
    	errorMessage += "<font color=\"red\">That game name already exists.</font><br/>";
    }
    else {
    	// add game to database
    	 String username = (String)request.getSession().getAttribute("username");
    	//String username = db.getCurrUser();
    	int administratorID = db.getUserID(username);
    	db.addGame(administratorID, gameName, sportType, gameLoc, maxPlayers, 1, gameTime, gender, skillLevel, ageRange, 0, comment);
    	int gameID = db.getGameID(gameName);
    	session.setAttribute("gameID", gameID);
    	
    	// add game joned to database
    	db.addGameJoined(administratorID, gameID);
    }
%>

<%= errorMessage %>