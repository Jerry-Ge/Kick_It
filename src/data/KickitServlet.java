/*
Team Member:
Natalie Monger, Yifei Xavier Liu, Jason Woodruff, Yuzhou Jerry Ge, Bradley Nguyen
*/
package data;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class KickitServlet
 */
@WebServlet("/KickitServlet")
public class KickitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// on startup, get all data from database (or an object that communicates with the database) and put it in a session attribute
		DBConnection db = new DBConnection();
		
		
		
		// if user chose GUEST, forward them to main page jsp
		
		
		// if user chose SIGN IN or SIGN UP, forward them to login jsp
		// if user chose SIGN UP, push inforamtion to database
		
		String next = "/mainPage.jsp";
		String type = request.getParameter("submit"); 
		String username = request.getParameter("user");
		HttpSession session = request.getSession();
		
		// a guest
		if(username == null) {
			session.setAttribute("username", null);
//			db.removeCurrUser();
//			db.addCurrUser(username);
			
			db.addUser(null, null, null, 0, 0, null, null, null);
		}
		// not a guest
		else {
			session.setAttribute("username", username);
//			db.removeCurrUser();
//			db.addCurrUser(username);
			
			if (type.equals("Sign Up")) {
				// String username = request.getParameter("user"); 
				String userPassword = request.getParameter("pass");
				String gender = request.getParameter("gender");
				String age = request.getParameter("age");
				String location = request.getParameter("location");
				next = "/login.jsp";
				 
				db.addUser(null, username, userPassword, 1, 1, gender, age, location);
			} else if (type.equals("Sign In")) {
				next = "/mainPage.jsp";
				// String username = request.getParameter("user");
			}
		}
		
		
//		if(submit.equals("GUEST")) {
//			String username = request.getParameter("user");
//			if(username == null || username.length() == 0) {
//				request.getSession().setAttribute("signUpUserInvalid", "Username cannot be empty");
//				next = "/login.jsp";
//			}
//			else {
//				request.getSession().setAttribute("signUpUserInvalid", null);
//			}
//			
//			String password = request.getParameter("pass");
//			String m = null;
//			if(password == null || password.length() == 0) {
//				m = "Password cannot be empty";
//				next = "/login.jsp";
//			}
//			request.getSession().setAttribute("signUpPassInvalid", m);
//			
//			
//		}
//		else if(submit.equals("SIGN IN") || submit.equals("SIGN UP")) {
//			next = "/login.jsp";
//		}
		
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		dispatch.forward(request,  response);
	}
}
