<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="data.DBConnection" %>
    
<%
	DBConnection db = new DBConnection();
	String username = request.getParameter("username");
    String userID = request.getParameter("userid");
    String oldpassword = request.getParameter("oldpassword");
    String newpassword = request.getParameter("newpassword");
    String repeatnewpassword = request.getParameter("repeatnewpassword");
    System.out.println("i am herea");
    System.out.println(username);
    System.out.println(userID);
    System.out.println(oldpassword);
    System.out.println(newpassword);
    System.out.println(repeatnewpassword);

    System.out.println("this am hereddd");
    String errorMessage = "";
/*    
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
   	    } */
%>

<%= errorMessage %>
