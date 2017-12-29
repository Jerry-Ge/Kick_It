<!--
Team Member:
Natalie Monger, Yifei Xavier Liu, Jason Woodruff, Yuzhou Jerry Ge, Bradley Nguyen
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
	<title>Kick it!2</title>
	<link rel="stylesheet" type="text/css" href="assets/css/mainPage.css">

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
	    
	    function connectToServer() {
	  	socket = new WebSocket("ws://localhost:8080/Kickit/ws");
			socket.onopen = function (event) {
				sendMessageConnect();
			}
			socket.onmessage = function (event) {
				var message = event.data;
				if(message == "gameCreated") {
					filterGames();
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
	    
		function filterGames() {
			var xhttp = new XMLHttpRequest();
			
			var sportTypeSelect = document.getElementById("sportTypeSelect");
			var locationSelect = document.getElementById("locationSelect");
			var ageSelect = document.getElementById("ageSelect");
			var genderSelect = document.getElementById("genderSelect");
			var skillLevelSelect = document.getElementById("skillLevelSelect");
			
			var sportTypeOption = sportTypeSelect.options[sportTypeSelect.selectedIndex].value;
			var locationOption = locationSelect.options[locationSelect.selectedIndex].value;
			var ageOption = ageSelect.options[ageSelect.selectedIndex].value;
			var genderOption = genderSelect.options[genderSelect.selectedIndex].value;
			var skillLevelOption = skillLevelSelect.options[skillLevelSelect.selectedIndex].value;
			
			var url = "mainPageFilter.jsp?sportTypeSelect=" + sportTypeOption +
				"&locationSelect=" + locationOption +
				"&ageSelect=" + ageOption +
				"&genderSelect=" + genderOption +
				"&skillLevelSelect=" + skillLevelOption;
			
			xhttp.onreadystatechange = function() {
				document.getElementById("main-room").innerHTML = xhttp.responseText;
			};
			xhttp.open("GET", url, true);
			xhttp.send();
		}
		
		function displayAllGames() {
			var xhttp = new XMLHttpRequest();
			
			var url = "mainPageDisplayAllGames.jsp";
			
			xhttp.onreadystatechange = function() {
				document.getElementById("main-room").innerHTML = xhttp.responseText;
			};
			xhttp.open("GET", url, true);
			xhttp.send();	
		}
		
		function gotogamelobby() {
			var xhttp = XMLHttpRequest();
			xhttp.open("GET", "gameLobby.jsp?gameId=" + document.single-game-form.gameId.value, false); //false meaning sychronized, wait.
				xhttp.send();
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
	<script>displayAllGames();</script>
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
	
				<div id="side-buttom">
					<p>All Events</p>
				</div>
	
				<div id="side-buttom" onclick="guestMyEvents();">
					<p>My Events</p>
				</div>
				
				<div id="side-buttom" onclick="guestViewProfile();">
					<p>View my profile</p>
				</div>
				
				<div id="side-buttom" onclick="guestUpdateProfile();">
					<p>Update my profile</p>
				</div>
	
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

			<div id="main-content-filter" class="clearfix">
				<!-- <form> -->
					<label>Sports Type</label>
					<select name="sportTypeSelect" id="sportTypeSelect">
						<option>Any</option>
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
						
					</select> 
					&nbsp&nbsp&nbsp
					<label>Location</label>
					<select name="locationSelect" id="locationSelect">
						<option>Any</option>
  						<option value="USC">USC</option>
  						<option value="UCLA">UCLA</option>
  						<option value="CalTech">CalTech</option>
  						<option value="Pomona">Pomona</option>
					</select>
					&nbsp&nbsp&nbsp
					<label>Age range</label>
					<select name="ageSelect" id="ageSelect">
						<option>Any</option>
  						<option>8-12</option>
						<option>12-15</option>
						<option>15-18</option>
						<option>18-25</option>
						<option>25-30</option>
						<option>30-35</option>
						<option>35-45</option>
						<option>45-55</option>
						<option>55+</option>
					</select>
					&nbsp&nbsp&nbsp

					<label>Gender</label>
					<select name="genderSelect" id="genderSelect">
						<option>Any</option>
  						<option>Male</option>
  						<option>Female</option>
					</select>
					&nbsp&nbsp
					<label>Skill Level: &nbsp</label>
					<select name="skillLevelSelect" id="skillLevelSelect">
						<option>Any</option>
						<option>Beginner</option>
						<option>Intermediate</option>
						<option>Advanced</option>
					</select>
					
					&nbsp&nbsp&nbsp&nbsp
					<button type="submit" id="submit-buttom1" onclick="filterGames()">Filter</button>
					&nbsp&nbsp&nbsp&nbsp
					<button type="submit" id="submit-buttom1" onclick="displayAllGames()">All Games</button>
				
			</div>

			<!--boxes-->
			<!-- <div  id="main-room-wrapper"> -->
				<div class="div-inline-block" id="main-room" class="clearfix">
				
				</div>
				
				<div id="main-room-switch" class="clearfix">
					<!-- center container -->
					<div id="main-room-switch-contain">
						<!-- left arrow -->
						<div class="div-inline-block" id="switch-left">
							
						</div>

						<!-- index -->
						<div class="div-inline-block" id="switch-middle">
							
						</div>

						<!-- right arrow -->
						<div class="div-inline-block" id="switch-right">
							
						</div>
					</div>
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