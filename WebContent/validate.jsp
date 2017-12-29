<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="data.DBConnection" %>

<%
	DBConnection db = new DBConnection();
	String type = request.getParameter("type");
    String user = request.getParameter("user");
    String pass = request.getParameter("pass");
    
    String errorMessage = "";
    
    if (type.equals("signUp")) {
    	String passRepeat = request.getParameter("passRepeat");
   	    
   	    if(user == null || user.trim().length() == 0) {
   	    	errorMessage += "<font color=\"red\">Please enter a username.</font><br/>";	
   	    }
   	    if(pass == null || pass.trim().length() == 0) {
   	    	errorMessage += "<font color=\"red\">Please enter a password.</font><br/>";
   	    } else if (!pass.equals(passRepeat)) {
   	    	errorMessage += "<font color=\"red\">The passwords do not match.</font><br/>";
   	    } 
   	    
   	    // validate if user exists in database
   	    if (db.UserExist(user)) { 
   	    	errorMessage += "<font color=\"red\">The username has already existed.</font><br/>";
   	    }
    }
    else if (type.equals("signIn")) {
	   	 if(user == null || user.trim().length() == 0) {
   	    	errorMessage += "<font color=\"red\">Please enter a username.</font><br/>";	
   	      }
   	      if(pass == null || pass.trim().length() == 0) {
   	    	errorMessage += "<font color=\"red\">Please enter a password.</font><br/>";
   	      }
   	      
   	      // validate if user exists in database
   	      if (!db.UserExist(user)) {
   	    	errorMessage += "<font color=\"red\">The username does not exist.</font><br/>";
   	       } else if(!db.getPassword(user).equals(pass)) {
   	    	// validate if user matches with password
   	    	errorMessage += "<font color=\"red\">The password is not correct.</font><br/>";
   	       }
   	      
	}
    
%>

<%= errorMessage %>