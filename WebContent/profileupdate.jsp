<!--
Team Member:
Natalie Monger, Yifei Xavier Liu, Jason Woodruff, Yuzhou Jerry Ge, Bradley Nguyen
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="data.DBConnection" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Kick it!2</title>
	<link rel="stylesheet" type="text/css" href="assets/css/updateProfile.css">
	
	<%
		String userName = (String) request.getSession().getAttribute("username");
		DBConnection db = new DBConnection();
		//String userName = db.getCurrUser();
		int userID = db.getUserID(userName);
		String password = db.getPassword(userName);
		boolean userExist = db.UserExist(userName);
		String userImage = db.getUserImage(userID);	
	%> 
	
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
    
		function validateUpdateProfile() {
			var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "validateUpdateProfile.jsp?username=" + document.createGameForm.username.value +
					"&oldPass=" + document.createGameForm.oldPass.value +
					"&newPass=" + document.createGameForm.newPass.value +
					"&newPassRepeat=" + document.createGameForm.newPassRepeat.value +
					"&age=" + document.createGameForm.age.value +
					"&location=" + document.createGameForm.location.value
					, false);
			xhttp.send();
			// response text is whatever the server sends back
			// if something comes back, we assume it's an error message
			if(xhttp.responseText.trim().length > 0) {
				document.getElementById("invalidCreateGame").innerHTML = xhttp.responseText;
				return false;
			}

			return true;
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
		<!-- <label>Online Users</label>
	    <div id="onlineUsers"></div> -->
	    
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
				<br>
				 <label id="onlineLabel">Online Users</label>
				 <br><br>
	    		 	<div id="onlineUsers"></div>
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
				<h1>Update my profile</h1><br>
				<div id="invalidCreateGame"></div>
				<form action="myprofile.jsp" method="POST" name="createGameForm" onsubmit="return validateUpdateProfile();">
					<label>New Name: </label><br>
					<input type="text" name="username" id="userName"> <br><br><br>
					
					<label>Old Password: </label><br>
					<input type="password" name="oldPass" id="oldPass"> <br><br><br>
					<label>New Password: </label><br>
					<input type="password" name="newPass" id="newPass"> <br><br><br>
					<label>Repeat New Password: </label><br>
					<input type="password" name="newPassRepeat" id="newPassRepeat"> <br><br><br>

					<label for="pass" class="label">Age Range:</label>
						<select name="age">
							<option>8-12</option>
							<option>12-15</option>
							<option>15-18</option>
							<option>18-25</option>
							<option>25-30</option>
							<option>30-35</option>
							<option>35-45</option>
							<option>45-55</option>
							<option>55+</option>
							<option>Any</option>
						</select>
					<br><br><br>

					<label for="pass" class="label">Location:&nbsp&nbsp&nbsp&nbsp</label>
						<select name="location">
							<option value="USC">USC</option>
							<option value="UCLA">UCLA</option>
							<option value="CalTech">CalTech</option>
							<option value="Pomona">Pomona</option>
							<option value="Any">Any</option>
						</select>
					<br><br><br>
					
					<input type="submit" value="Submit" id="submit-buttom1">
					<input type="submit" value="Reset" id="submit-buttom2">
					<br><br>
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