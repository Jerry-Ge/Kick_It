<!--
Team Member:
Natalie Monger, Yifei Xavier Liu, Jason Woodruff, Yuzhou Jerry Ge, Bradley Nguyen
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="data.DBConnection" %>
 
<%
	// original username
	 String userName = (String) request.getSession().getAttribute("username");
	DBConnection db = new DBConnection();
	//String userName = db.getCurrUser();
	// new username (if username changed with profile update)
	String newUserName = request.getParameter("username");	

	int userID = 0;
	String userImage = "";
	String userAge = "";
	String userLocation = "";
	
	// original username
	if(newUserName == null) {
		userID = db.getUserID(userName);
		userImage = db.getUserImage(userID);
		userAge = db.getUserAge(userID);
		userLocation = db.getUserLocation(userID);
	}
	// new username (if username changed with profile update)
	else {
		userID = db.getUserID(newUserName);
		userImage = db.getUserImage(userID);
		userAge = db.getUserAge(userID);
		userLocation = db.getUserLocation(userID);
		
		request.getSession().setAttribute("username", newUserName);
		//db.removeCurrUser();
		//db.addCurrUser(newUserName);
		userName = newUserName;
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Kick it!2</title>
	<link rel="stylesheet" type="text/css" href="assets/css/myprofile.css">
	
	<script>
		var socket;
	    function sendMessageConnect() {
	    	<% 
	    	if (userName != null) {
	    		%>
				socket.send("<%=userName%>" + "-" + "connect");
				<%
	    	}
	    	else {
	    		%>
	    		socket.send("");
	    		<%
	    	}
	    	%>
			return false;
	    }
	    
	    function sendMessageDisconnect() {
	    	<% 
	    	if (userName != null) {
	    		%>
				socket.send("<%=userName%>" + "-" + "disconnect");
				<%
	    	}
	    	else {
	    		%>
	    		socket.send("");
	    		<%
	    	}
	    	%>
			return false;
	    }
	    
	    function sendMessageGameCreated() {
	    	socket.send("create-game");
	    }
	    
	    function connectToServer() {
	  	socket = new WebSocket("ws://localhost:8080/Kickit/ws");
			socket.onopen = function (event) {
				sendMessageConnect();
			}
			socket.onmessage = function (event) {
				var message = event.data;
				if(message == "gameCreated") {
					document.getElementById("onlineUsers").innerHTML += "games";
				}
				var usernames = message.split(" ");
				document.getElementById("onlineUsers").innerHTML = "";
				for(i = 0; i < usernames.length; i++) {
					document.getElementById("onlineUsers").innerHTML += usernames[i] + "<br />";
				}
			}
			socket.onclose = function(event) {
				sendMessageDisconnect();
			}
	    }
    
		function guestCreateEvent() {
			alert("Only registered users may create events");
		}
		
		function guestMyEvents() {
			alert("Only registered users may create and join events");
		}
		
		function guestViewProfile() {
			alert("Only registered users may view their profile");
		}
		
		function guestUpdateProfile() {
			alert("Only registered users may update their profile");
		}
	</script>
</head>
	<body onload="connectToServer();">
	    
		<div id="toggle-user-info">
			<% 
			if(userName != null) {
				%>
				<a href="createGame.jsp">
				<div id="side-buttom">
					<p>Create an Event</p>
				</div>
				</a>

				<a href="mainPage.jsp">
				<div id="side-buttom">
					<p>All Events</p>
				</div>
				</a>

				<a href="myGames.jsp">
				<div id="side-buttom">
					<p>My Events</p>
				</div>
				</a>
				
				<a href="myprofile.jsp">
				<div id="side-buttom">
					<p>View my profile</p>
				</div>
				</a>
				
				
				<a href="profileupdate.jsp">
				<div id="side-buttom">
					<p>Update my profile</p>
				</div>
				</a>

				<a href="landing.jsp">
				<div id="side-buttom" onclick="sendMessageDisconnect();">
					<p>Log Out</p>
				</div>
				</a>
				<%
			}
			else {
				%>
				<div id="side-buttom" onclick="guestCreateEvent();">
					<p>Create an Event</p>
				</div>
				</a>
	
				<div id="side-buttom">
					<p>All Events</p>
				</div>
				</a>
	
				<div id="side-buttom" onclick="guestMyEvents();">
					<p>My Events</p>
				</div>
				</a>
				
				<div id="side-buttom" onclick="guestViewProfile();">
					<p>View my profile</p>
				</div>
				</a>
				
				<div id="side-buttom" onclick="guestUpdateProfile();">
					<p>Update my profile</p>
				</div>
				</a>
	
				<a href="landing.jsp">
				<div id="side-buttom">
					<p>Log Out</p>
				</div>
				</a>
				<br>
				 <label id="onlineLabel">Online Users</label>
				 <br><br>
	    			 <div id="onlineUsers"></div>
				<%
			}
			%>
		</div>



		<div id="main-canvas" class="clearfix">
			
			<!-- top menu bar -->
			<!-- top menu bar -->
			<div id="top-menu" class="clearfix">
				<!-- LOGO&&TITLE -->
				<div class="inline-block" id="main-logo">
					<h1>Kick it!</h1>
				</div>
				<!-- user icon -->
				<div class="inline-block" id="main-user" class="clearfix">
					<!-- message box -->
					<div class="div-inline-block" id="main-notification">
					</div>

					<!-- user icon -->
					<div class="div-inline-block" id="main-user-icon">
						
					</div>

					<!--user name-->
					<div class="div-inline-block" id="main-user-name">
						<% 
						if(userName != null) {
							%>
							<p style="font-size:23px;">Hello,&nbsp&nbsp&nbsp<%=userName%></p>
							<%
						}
						else {
							%>
							<p style="font-size:23px;">Hello,&nbsp&nbsp&nbspGuest</p>
							<%
						}
						%>
					</div>

					<!--toggle button-->
					<div class="div-inline-block" id="main-user-click">
						<a href="#" class="quote-button">Show less</a>
					</div>

				</div>
			</div>

			<div class="div-inline-block clearfix" id="main-room-wrapper">
				<div id="myform" class="clearfix">
				<br><br><br><br>
				<h1>My Profile</h1><br>
				<div id="invalidCreateGame"></div>
				<form action="profileupdate.jsp">
					<label style="font-style: italic;">My Name: </label><br>
					<h2><%=userName %></h2>
					<br><br>
					<label for="pass" class="label" style="font-style: italic;">My Age Range:</label>
					<h2><%=userAge %></h2>
					<br><br>

					<label for="pass" class="label" style="font-style: italic;">My Location:&nbsp&nbsp&nbsp&nbsp</label>
					<h2><%=userLocation %></h2>
					<br><br><br>
					
					<input type="submit" value="Update Profile" id="submit-buttom1">
					<br><br><br><br><br><br><br><br><br><br>
				</form>
				</div>
			</div>	

			<!-- this is a footer -->
			<div id="main-footer">
				<p>
					&copy Site Created by Kick it! Team in 2017.
				</p>
			</div>
		</div>

		<script type="text/javascript" src="jquery-3.2.1.js"></script>
		<script type="text/javascript">
	       (function(){
               	$('#toggle-user-info').hide();
                var quoteButton = $('.quote-button'),
                    blockquote = $('#toggle-user-info');
                
                
                quoteButton.on('click', function(e) {
                    e.preventDefault();
                    var quoteButtonText = quoteButton.text();
                    
                    blockquote.slideToggle(500, function(){
                        quoteButtonText == "Show less" ? quoteButton.text("Show more") : quoteButton.text("Show less");
                    });
    
                });
                
            })();
		</script>
	</body>
</html>