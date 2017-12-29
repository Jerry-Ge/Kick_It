/*
Team Member:
Natalie Monger, Yifei Xavier Liu, Jason Woodruff, Yuzhou Jerry Ge, Bradley Nguyen
*/
package data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;

public class DBConnection {

	public Connection conn;
	public Statement st;
	
	public DBConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		    conn = DriverManager.getConnection("jdbc:mysql://localhost/finalProject?user=root&password=Abc1996926");
			st = conn.createStatement();
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		} catch (ClassNotFoundException cnfe) {
			System.out.println("cnfe " + cnfe.getMessage());
		}
	}
	
	// 1 as true, 0 as false
	public void addUser(String image, String username, String userPassword, int canJoin, int canMessage, String gender, String age, String location) {
		try {
			String sql = "INSERT INTO Users (image, username, userPassword, canJoin, canMessage, gender, age, location) " 
					+ "VALUES ('"+image+"', '"+username+"', '"+userPassword+"', '"+canJoin+"', '"+canMessage+"', '"+gender+"', '"+age+"', '"+location+"')";
			st.executeUpdate(sql);
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		} 			
	}
	
	public void updateUser(int userID, String image, String username, String userPassword, int canJoin, int canMessage, String gender, String age, String location) {
		try {
			String sql = "UPDATE Users " 
					+ "SET image = '"+image+"', username = '"+username+"', userPassword = '"+userPassword+"', canJoin = '"+canJoin+"', canMessage = '"+canMessage+"', gender = '"+gender+"', age = '"+age+"', location = '"+location + "' "
					+ "WHERE userID = " + userID;
			st.executeUpdate(sql);
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		} 			
	}
	
	
	public int getUserID(String username) {
		try {
			ResultSet rs = st.executeQuery("SELECT userID FROM Users WHERE username = '" + username + "';");	
			int id = -1;
			while (rs.next()) {
				id = rs.getInt("userID");
			}
			return id;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return -1;
	}
	
	public String getPassword(String username) {
		try {
			ResultSet rs = st.executeQuery("SELECT userPassword FROM Users WHERE username = '" + username + "';");	
			String password = null;
			while (rs.next()) {
				password = rs.getString("userPassword");
			}
			return password;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public boolean UserExist(String username) {
		int id = getUserID(username);
		if (id != -1) {
			return true;
		}
		return false;
	}
	
	public String getUserName(int userID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Users WHERE userID = '" + userID + "';");	
			String username = null;
			while (rs.next()) {
				username = rs.getString("username");
			}
			return username;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public String getUserImage(int userID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Users WHERE userID = '" + userID + "';");	
			String image = null;
			while (rs.next()) {
				image = rs.getString("image");
			}
			return image;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public String getUserGender(int userID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Users WHERE userID = '" + userID + "';");	
			String gender = null;
			while (rs.next()) {
				gender = rs.getString("gender");
			}
			return gender;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public String getUserAge(int userID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Users WHERE userID = '" + userID + "';");	
			String age = null;
			while (rs.next()) {
				age = rs.getString("age");
			}
			return age;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public String getUserLocation(int userID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Users WHERE userID = '" + userID + "';");	
			String location = null;
			while (rs.next()) {
				location = rs.getString("location");
			}
			return location;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public boolean canJoinAndMessage(int userID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Users WHERE userID = '" + userID + "';");	
			int canJoin = 0;
			while (rs.next()) {
				canJoin = rs.getInt("canJoin");
			}
			
			if (canJoin == 1) {
				return true;
			}
			return false;
			
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return false;
	}
	
	
	// create game, get game id, and query game attributes from game id
	public void addGame(int administratorID, String gameName, String sportType, String location, int maxPlayer, int currPlayer, String gameTime, String gender, String skillLevel, String age, int isReady, String description) {
		try {
			String sql = "INSERT INTO Games (administratorID, gameName, sportType, location, maxPlayer, currPlayer, gameTime, gender, skillLevel, age, isReady, description) " 
					+ "VALUES ('"+administratorID+"', '"+gameName+"', '"+sportType+"', '"+location+"', '"+maxPlayer+"', '"+currPlayer+"', '"+gameTime+"', '"+gender+"', '"+skillLevel+"', '"+age+"', '"+isReady+"', '"+description+"')";
			st.executeUpdate(sql);
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		} 			
	}
	
	public int getGameID(String gameName) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Games WHERE gameName = '" + gameName + "';");	
			int id = -1;
			while (rs.next()) {
				id = rs.getInt("gameID");
			}
			return id;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return -1;
	}
	
	public int getGameAdministratorID(int gameID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Games WHERE gameID = '" + gameID + "';");	
			int id = -1;
			while (rs.next()) {
				id = rs.getInt("adminstratorID");
			}
			return id;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return -1;
	}
	
	public String getGameName(int gameID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Games WHERE gameID = '" + gameID + "';");	
			String gameName = null;
			while (rs.next()) {
				gameName = rs.getString("gameName");
			}
			return gameName;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public String getGameSportType(int gameID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Games WHERE gameID = '" + gameID + "';");	
			String sportType = null;
			while (rs.next()) {
				sportType = rs.getString("sportType");
			}
			return sportType;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public String getGameLocation(int gameID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Games WHERE gameID = '" + gameID + "';");	
			String location = null;
			while (rs.next()) {
				location = rs.getString("location");
			}
			return location;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public int getGameMaxPlayer(int gameID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Games WHERE gameID = '" + gameID + "';");	
			int maxPlayer = -1;
			while (rs.next()) {
				maxPlayer = rs.getInt("maxPlayer");
			}
			return maxPlayer;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return -1;
	}
	
	public int getGameCurrPlayer(int gameID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Games WHERE gameID = '" + gameID + "';");	
			int currPlayer = -1;
			while (rs.next()) {
				currPlayer = rs.getInt("currPlayer");
			}
			return currPlayer;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return -1;
	}
	
	public String getGameTime(int gameID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Games WHERE gameID = '" + gameID + "';");	
			String gameTime = null;
			while (rs.next()) {
				gameTime = rs.getString("gameTime");
			}
			return gameTime;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public String getGameGender(int gameID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Games WHERE gameID = '" + gameID + "';");	
			String gender = null;
			while (rs.next()) {
				gender = rs.getString("gender");
			}
			return gender;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public String getGameSkillLevel(int gameID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Games WHERE gameID = '" + gameID + "';");	
			String skillLevel = null;
			while (rs.next()) {
				skillLevel = rs.getString("skillLevel");
			}
			return skillLevel;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public String getGameAge(int gameID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Games WHERE gameID = '" + gameID + "';");	
			String age = null;
			while (rs.next()) {
				age = rs.getString("age");
			}
			return age;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public String getGameDescription(int gameID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Games WHERE gameID = '" + gameID + "';");	
			String description = null;
			while (rs.next()) {
				description = rs.getString("description");
			}
			return description;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public void updateCurrPlayer(int gameID, int currPlayer) {
		try {
			String sql = "UPDATE Games " 
					+ "SET currPlayer = '"+currPlayer+"' "
					+ "WHERE gameID = " + gameID;
			st.executeUpdate(sql);
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		} 			
	}
	
	public boolean isGameReady(int gameID) {
		try {
			ResultSet rs = st.executeQuery("SELECT * FROM Games WHERE gameID = '" + gameID + "';");	
			int isReady = 0;
			while (rs.next()) {
				isReady = rs.getInt("isReady");
			}
			
			if (isReady == 1) {
				return true;
			}
			return false;
			
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return false;
	}
	
	public boolean GameNameExist(String gameName) {
		int id = getGameID(gameName);
		if (id != -1) {
			return true;
		}
		return false;
	}
	
	// friends table
	public void addFriend(int userID, int friendID) {
		try {
			String sql = "INSERT INTO Friends (userID, friendID) " 
					+ "VALUES ('"+userID+"', '"+friendID+"')";
			st.executeUpdate(sql);
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		} 	
	}
	
	public void removeFriend(int userID, int friendID) {
		try {
			String sql = "DELETE FROM Friends " 
					+ "WHERE userID = '" + userID + "' AND friendID = '" + friendID + "';";
			st.executeUpdate(sql);
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		} 	
	}
	
	public ArrayList<Integer> getFriends(int userID) {
		try {
			ArrayList<Integer> result = new ArrayList<>();
			ResultSet rs = st.executeQuery("SELECT * FROM Friends WHERE userID = '" + userID + "';");	
			while (rs.next()) {
				int friendID = rs.getInt("friendID");
				result.add(friendID);
			}
			return result;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	// game joined table
	public void addGameJoined(int userID, int gameID) {
		try {
			String sql = "INSERT INTO GamesJoined (userID, gameID) " 
					+ "VALUES ('"+userID+"', '"+gameID+"')";
			st.executeUpdate(sql);
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		} 	
	}
	
	public void removeGamesJoined(int userID, int gameID) {
		try {
			String sql = "DELETE FROM GamesJoined " 
					+ "WHERE userID = '" + userID + "' AND gameID = '" + gameID + "';";
			st.executeUpdate(sql);
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		} 	
	}
	
	public ArrayList<Integer> getGameJoinedByUser(int userID) {
		try {
			ArrayList<Integer> result = new ArrayList<>();
			ResultSet rs = st.executeQuery("SELECT * FROM GamesJoined WHERE userID = '" + userID + "';");	
			while (rs.next()) {
				int gameID = rs.getInt("gameID");
				result.add(gameID);
			}
			return result;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public HashSet<Integer> getUserJoinedByGame(int gameID) {
		try {
			HashSet<Integer> result = new HashSet<>();
			ResultSet rs = st.executeQuery("SELECT * FROM GamesJoined WHERE gameID = '" + gameID + "';");	
			while (rs.next()) {
				int userID = rs.getInt("userID");
				result.add(userID);
			}
			return result;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	//get image url 
		public String getImageUrl(String imageType) {
			try {
				String result = "";
				ResultSet rs = st.executeQuery("SELECT image FROM Image WHERE sportType = '" + imageType + "';");	
				while (rs.next()) {
					String imageUrl = rs.getString("image");
					result += imageUrl;
				}
				return result;
			} catch (SQLException sqle) {
				System.out.println("sqle " + sqle.getMessage());
			}
			return null;
		}
		
	// new table	
	public String getCurrUser() {
		try {
			String result = "";
			ResultSet rs = st.executeQuery("SELECT username FROM CurrUser;");	
			while (rs.next()) {
				String username = rs.getString("username");
				result = username;
			}
			return result;
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		}
		return null;
	}
	
	public void addCurrUser(String username) {
		try {
			String sql = "INSERT INTO CurrUser (username) " 
					+ "VALUES ('"+username+"')";
			st.executeUpdate(sql);
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		} 	
	}
	
	public void removeCurrUser() {
		try {
			String sql = "TRUNCATE TABLE CurrUser;";
			st.executeUpdate(sql);
		} catch (SQLException sqle) {
			System.out.println("sqle " + sqle.getMessage());
		} 	
	}
}