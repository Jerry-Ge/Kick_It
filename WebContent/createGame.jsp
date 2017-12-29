<!--
Team Member:
Natalie Monger, Yifei Xavier Liu, Jason Woodruff, Yuzhou Jerry Ge, Bradley Nguyen
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="data.DBConnection" %>
<html>
	<head>
	<title>Kick it!2</title>
	<link rel="stylesheet" type="text/css" href="assets/css/createGame.css">
	
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
    
		function validateCreateGame() {
			var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "validateCreateGame.jsp?gameName=" + document.createGameForm.gameName.value +
					"&sportType=" + document.createGameForm.sportType.value +
					"&gameTime=" + document.createGameForm.gameTime.value +
					"&maxPlayers=" + document.createGameForm.maxPlayers.value +
					"&comment=" + document.createGameForm.comment.value +
					"&gameLoc=" + document.createGameForm.location.value +
					"&ageRange=" + document.createGameForm.ageRange.value +
					"&gender=" + document.createGameForm.gender.value +
					"&skillLevel=" + document.createGameForm.skillLevel.value
					, false);
			xhttp.send();
			// response text is whatever the server sends back
			// if something comes back, we assume it's an error message
			if(xhttp.responseText.trim().length > 0) {
				document.getElementById("invalidCreateGame").innerHTML = xhttp.responseText;
				return false;
			}
			sendMessageGameCreated();
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
				<h1>Create a new game</h1><br>
				<div id="invalidCreateGame"></div>
				<form action="gameLobby.jsp" method="POST" name="createGameForm" onsubmit="return validateCreateGame();">
					<label>Game Name: </label><br>
					<input type="text" name="gameName" id="gameName"> <br><br><br>
					<label>Sport Type: </label><br>
					<select name="sportType" id="sportType">
						<option value="Basketball">Basketball</option>
						<option value="Soccer">Soccer</option>
						<option value="Tennis">Tennis</option>
						<option value="Football">Football</option>
						<option value="Baseball">Baseball</option>
						<option value="Golf">Golf</option>
						<option value="Icehockey">Icehockey</option>
						<option value="Badminton">Badminton</option>
						<option value="Tabletennis">Tabletennis</option>
						<option value="Volleyball">Volleyball</option>
						
					</select><br><br><br>
					
					<label>Game Date/Time:</label><br>
					<input type="datetime-local" name="gameTime" id="gameTime">
					<br><br><br>

					<label>Max Players:</label><br>
					<select name="maxPlayers" id="maxPlayers">
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
						<option>6</option>
						<option>7</option>
						<option>8</option>
						<option>9</option>
						<option>10</option>
						<option>11</option>
						<option>12</option>
						<option>13</option>
						<option>14</option>
						<option>15</option>
						<option>16</option>
						<option>17</option>
						<option>12</option>
						<option>18</option>
						<option>19</option>
						<option>20</option>
						<option>21</option>
						<option>22</option>
						<option>Unlimited</option>
					</select><br><br><br>
					
					<label>Game Description: </label><br>
					<input type="text" name="comment" id="comment"> <br><br><br>
					
					<br><br><br>
					
					<!-- <label>Game Location:</label><br>
					<input type="text" name="gameLoc" id="gameLoc"> 
					<input type="submit" value="Show" id="submit-buttom3"><br><br> 
					<img src="https://maps.googleapis.com/maps/api/staticmap?center=USC,Los+Angeles,CA&zoom=13&size=400x250&maptype=roadmap
					&markers=color:red%7Clabel:C%7C34.022370, -118.284902
					&key=AIzaSyBKCkA4IdNOEyXmDAGe7Q5p7rlBZfbiTgY" id="googlemap">
					<br><br><br>
					<script type="text/javascript">
						String map = document.getElementById("gameLoc").value;
					</script> -->


					
					<label for="pass" class="label">Game Location:</label>
					<select name="location">
						<option value="USC">USC</option>
						<option value="UCLA">UCLA</option>
						<option value="CalTech">CalTech</option>
						<option value="Pomona">Pomona</option>
						<option value="Any">Any</option>
					</select>
					<br><br>
					
					
					<input type="submit" value="Show" id="submit-buttom3"><br><br> 
					<!-- <script type="text/javascript">
						function getLocation() {
							var location = document.getElementById("textfield-id").value;
							var googleQuery = "https://maps.googleapis.com/maps/api/staticmap?center=" + location + ",Los+Angeles,CA&zoom=13&size=400x250&maptype=roadmap&markers=color:red%7Clabel:C%7C34.022370, -118.284902&key=AIzaSyBKCkA4IdNOEyXmDAGe7Q5p7rlBZfbiTgY";
							return googleQuery;
						}
			
					</script> -->
					<img src="https://maps.googleapis.com/maps/api/staticmap?center=USC,Los+Angeles,CA&zoom=13&size=400x250&maptype=roadmap&markers=color:red%7Clabel:C%7C34.022370, -118.284902&key=AIzaSyBKCkA4IdNOEyXmDAGe7Q5p7rlBZfbiTgY" id="googlemap">
					<br><br><br>

				



					<label>Age Range:</label>
					<select name="ageRange" id="ageRange">
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
					</select><br><br><br>
					
					<label>Gender: &nbsp&nbsp&nbsp&nbsp&nbsp</label>
					<select name="gender" id="gender">
						<option>Male</option>
						<option>Female</option>
						<option>Any</option>
					</select><br><br><br>

					<label>Skill Level: &nbsp</label>
					<select name="skillLevel" id="skillLevel">
						<option>Beginner</option>
						<option>Intermediate</option>
						<option>Advanced</option>
						<option>Any</option>
					</select><br><br><br>

					
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