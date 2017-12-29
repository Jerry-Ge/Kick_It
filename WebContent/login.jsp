<!--
Team Member:
Natalie Monger, Yifei Xavier Liu, Jason Woodruff, Yuzhou Jerry Ge, Bradley Nguyen
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
  <meta charset="UTF-8">
  <title>Kick it LogIn/SignUp</title>
  <script>
			function validateSignUp() {
				var xhttp = new XMLHttpRequest();
				xhttp.open("GET", "validate.jsp?user=" + document.signupform.user.value +
					"&pass=" + document.signupform.pass.value + "&passRepeat=" + document.signupform.passRepeat.value
					+ "&type=signUp" , false);
				xhttp.send();
				// response text is whatever the server sends back
				// if something comes back, we assume it's an error message
				if(xhttp.responseText.trim().length > 0) {
					document.getElementById("invalidSignUp").innerHTML = xhttp.responseText;
					return false;
				}
				return true;
			}
			
			function validateSignIn() {
				var xhttp = new XMLHttpRequest();
				xhttp.open("GET", "validate.jsp?user=" + document.signinform.user.value +
					"&pass=" + document.signinform.pass.value + "&type=signIn", false);
				xhttp.send();
				// response text is whatever the server sends back
				// if something comes back, we assume it's an error message
				if(xhttp.responseText.trim().length > 0) {
					document.getElementById("invalidSignIn").innerHTML = xhttp.responseText;
					return false;
				}
				return true;
			}
		</script>
  
  
  <link rel='stylesheet prefetch' href='http://fonts.googleapis.com/css?family=Open+Sans:600'>

  <link rel="stylesheet" href="assets/css/style.css">

  
  
  
</head>

<body>
  <div class="login-wrap">
    <div class = "login-title">
    Kick it!
    </div>
	<div class="login-html">
		<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Sign In</label>
		<input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab" >Sign Up</label>
		<div class="login-form">
			<div class="sign-in-htm">
				<form action="KickitServlet" method="POST" name="signinform" onsubmit="return validateSignIn();">
					<div id="invalidSignIn">
						
					</div>
					<div class="group">
						<label for="user" class="label">Username</label>
						<input name="user" id="user" type="text" class="input">
					</div>
					<div class="group">
						<label for="pass" class="label">Password</label>
						<input name="pass" id="pass" type="password" class="input" data-type="password">
					</div>
					<div class="group">
						<input id="check" type="checkbox" class="check" checked>
						<label for="check"><span class="icon"></span> Keep me Signed in</label>
					</div>
					<div class="group">
						<input type="submit" class="button" name="submit" value="Sign In">
					</div>
					<div class="hr"></div>
					<div class="foot-lnk">
						<a href="#forgot">Forgot Password?</a>
					</div>
				</form>
			</div>
			<div class="sign-up-htm">
				<!-- this section to upload image -->
<!-- 				<div class="group">
				<label class="label">Upload your profile photo</label>
				<input type="file" name="profile">
				</div> -->
				<!-- this section to upload image -->
				<form action="KickitServlet" method="POST" name="signupform" onsubmit="return validateSignUp();" >
					<div id="invalidSignUp">
						
					</div>
					<div class="group">
						<label for="user" class="label">Username</label>
						<input name="user" id="user" type="text" class="input">
					</div>
					
					
					<div class="group">
						<label for="pass" class="label">Password</label>
						<input name="pass" id="pass" type="password" class="input" data-type="password">
					</div>
					
					
					<div class="group">
						<label for="pass" class="label">Repeat Password</label>
						<input name="passRepeat" id="passRepeat" type="password" class="input" data-type="password">
					</div>
					
					<div class="group">
						<label for="pass" class="label">Gender: </label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label for="pass" class="label" id="gender">Male</label>
						<input type="radio" name="gender" value="Male" checked="">
						&nbsp;
						<label for="pass" class="label">Female</label>
						<input type="radio" name="gender" value="Female">
					</div>
	
					<!-- this section to choose age range -->
					<div class="group">
						<label for="pass" class="label">Age Range:</label>
						<select name="age">
							<option value="10-15">10-15</option>
							<option value="16-20">16-20</option>
							<option value="21-30">21-30</option>
							<option value="31-40">31-40</option>
							<option value="41-50">41-50</option>
							<option value="50+">50+</option>
						</select>
					</div>
					
					<!-- this section to choose age range -->
					<div class="group">
						&nbsp;
						<label for="pass" class="label">Location:</label>
						<select name="location">
							<option value="USC">USC</option>
							<option value="UCLA">UCLA</option>
							<option value="CalTech">CalTech</option>
							<option value="Pomona">Pomona College</option>
							<option value="Others">Others</option>
						</select>
					</div>
					
					<!-- this section to choose location -->
					<div>
						
					</div>
					
					<div class="group">
						<input type="submit" class="button" name="submit" value="Sign Up">
					</div>
					<div class="hr"></div>
					<div class="foot-lnk">
						<label for="tab-1">Already Member?</a>
					</div>
				</form>
			</div>
		</div>
    </div>
</div>
  
</body>
</html>