<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="data.DBConnection" %>

<%
	DBConnection db = new DBConnection();
	String oldUsername = (String)request.getSession().getAttribute("username");
	//String oldUsername = db.getCurrUser();
	String oldPassword = db.getPassword(oldUsername);
	int userID = db.getUserID(oldUsername);

	String username = request.getParameter("username");
	String oldPass = request.getParameter("oldPass");
	String newPass = request.getParameter("newPass");
	String newPassRepeat = request.getParameter("newPassRepeat");
	String age = request.getParameter("age");
	String location = request.getParameter("location");
    
    String errorMessage = "";
    
	    
    if(username == null || username.trim().length() == 0) {
    	errorMessage += "<font color=\"red\">Please enter a username.</font><br/>";	
    }
    if(oldPass == null || oldPass.trim().length() == 0) {
    	errorMessage += "<font color=\"red\">Please enter an old password.</font><br/>";
    } else if (!oldPass.equals(oldPassword)) {
    	errorMessage += "<font color=\"red\">The old passwords is not correct.</font><br/>";
    } 
    
    if(newPass == null || newPass.trim().length() == 0) {
    	errorMessage += "<font color=\"red\">Please enter a new password.</font><br/>";
    } else if (!newPass.equals(newPassRepeat)) {
    	errorMessage += "<font color=\"red\">The passwords do not match.</font><br/>";
    } 
    
    // validate if user exists in database
    if (db.UserExist(username)) { 
    	errorMessage += "<font color=\"red\">The username has already existed.</font><br/>";
    }
    
    // update user
    if (errorMessage.equals("")) {
    	String image = db.getUserImage(userID);
    	String gender = db.getUserGender(userID);
    	db.updateUser(userID, image, username, newPass, 1, 1, gender, age, location);
    }
    
%>

<%= errorMessage %>