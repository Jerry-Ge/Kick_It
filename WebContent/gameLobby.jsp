<!--
Team Member:
Natalie Monger, Yifei Xavier Liu, Jason Woodruff, Yuzhou Jerry Ge, Bradley Nguyen
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="data.DBConnection" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashSet" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Kick it!2</title>
	<link rel="stylesheet" type="text/css" href="assets/css/gameLobby.css">
	<%
		String userName = (String) request.getSession().getAttribute("username");
		DBConnection db = new DBConnection();
		//String userName = db.getCurrUser();
		int userID = db.getUserID(userName);
		String password = db.getPassword(userName);
		boolean userExist = db.UserExist(userName);
		String userImage = db.getUserImage(userID);
		
		int gameID = 0;
		if (request.getSession().getAttribute("gameID") != null) {
			gameID = (int) request.getSession().getAttribute("gameID");
		}
		if (request.getParameter("gameId") != null) {
		String gameID1 = request.getParameter("gameId");
 		gameID = Integer.parseInt(gameID1);
		System.out.println(gameID);
		}
		/*
		/* int gameID = Integer.parseInt(request.getParameter("gameID")); */
		String sportType = db.getGameSportType(gameID);
		String imageURL = db.getImageUrl(sportType);
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
    
		function JoinGame() {
		    var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "joinGameButton.jsp?userID=" + '<%=userID%>' +
					"&gameID=" + '<%=gameID%>' +
					"&type=join" 
					, false);
			xhttp.send();
			document.getElementById("joined-user").innerHTML = xhttp.responseText;
		}
		function ExitGame() {
		    var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "joinGameButton.jsp?userID=" + '<%=userID%>' +
					"&gameID=" + '<%=gameID%>' +
					"&type=exit" 
					, false);
			xhttp.send();
			document.getElementById("joined-user").innerHTML = xhttp.responseText;
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
		
		function guestJoinGame() {
			alert("Only registered users may join games");
		}
	</script>
</head>
	<body onload="connectToServer();">
<!-- 		<label>Online Users</label>
	    <div id="onlineUsers"></div> -->
	    
		<div id="main-canvas">
			
			<!-- top menu bar -->
			<div id="top-menu">
				<!-- LOGO&&TITLE -->
				<div class="inline-block" id="main-logo">
					<h1>Kick it!</h1>
				</div>
				<!-- user icon -->
				<div class="inline-block" id="main-user">
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

					<!-- user click page -->
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
							
							<a href="mainPage.jsp">
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

				</div>
			</div>

				<!-- filter -->

			<div id="main-content-title">
				<h2>Game Lobby Info</h2>
				<br><br>
			</div>

			<!--boxes-->
			<!-- <div  id="main-room-wrapper"> -->
				<div class="div-inline-block" id="main-room">
					<div class="div-inline-block" id="game-img" style="background-image:url(<%=imageURL%>);" >
						
					</div>
					
					<%
					if(userName == null) {
						%>
						<button id="join-button" onclick = "guestJoinGame()">
						<h3>Join the Game</h3>
						</button>
						<br><br>
						<%
					}
					else {
						%>
						<button id="join-button" onclick = "JoinGame()">
						<h3>Join the Game</h3>
						</button>
						<br><br>
						<%
					}
					%>
					
					<button id="quit-button" onclick = "ExitGame()">			
						<h3>Leave the Game</h3>
					</button>
				
					
					<div class="div-inline-block" id="game-info">
						<div id="joined-user">
							<h3><span id="game-title">Game Name:  </span><%= db.getGameName(gameID) %></h3>
							<h3><span id="game-title">Sport Type:  </span><%= db.getGameSportType(gameID) %></h3>
							<h3><span id="game-title">Max Player:  </span><%= db.getGameMaxPlayer(gameID) %></h3>
							<h3><span id="game-title">Current Player Number:  </span><%= db.getGameCurrPlayer(gameID) %></h3>
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
						</div>

					</div>

					
				</div>



			<!-- this is a footer -->
<!-- 			<div id="footer">
			</div> -->
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