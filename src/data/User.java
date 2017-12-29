/*
Team Member:
Natalie Monger, Yifei Xavier Liu, Jason Woodruff, Yuzhou Jerry Ge, Bradley Nguyen
*/
package data;

import java.util.ArrayList;
import java.util.HashMap;

public class User {
	protected String image;
	protected String username;
	protected String password;
	protected boolean canJoin;
	protected boolean canMessage;
	
	public User() {};
	public User(String image, String username, String password, boolean canJoin, boolean canMessage) {
		this.image = image;
		this.username = username;
		this.password = password;
		this.canJoin = canJoin;
		this.canMessage = canMessage;
	}
	
	public void setImage(String image) {
		this.image = image;
	}
	
	public String getImage() {
		return this.image;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getUsername() {
		return this.username;
	}
}

class Guest extends User {
	// image : put a default image instead of null
	public Guest() {
		super(null, null, null, false, false);
	}
}

class Player extends User { 
	
	private int id;
	private ArrayList<Player> friendList;
	private ArrayList<Player> blackList;
	private HashMap<String, String> skills; // key: sport type; value: skill level
	private String gender;
	private int age;
	private String location;
	private HashMap<Integer, GameGroup> gamesJoined;   // maybe get rid of id later, and use set instead
	private HashMap<Integer, GameGroup> gamesAdministrated;

	public Player(int id, String image, String username, String password, String gender, int age, String location) {
		super(image, username, password, true, true);
		
		this.id = id;
		this.gender = gender;
		this.age = age;
		this.location = location;
		
		this.skills.put("soccer", "any");
		this.skills.put("basketball", "any");
		this.skills.put("football", "any");
		this.skills.put("tennis", "any");
		this.skills.put("any", "any");
	}
	
	
	public void changeSkill(String sportType, String skillLevel) {
		if (this.skills.containsKey(sportType))
			this.skills.put(sportType, skillLevel);
	}
	
	public void addFriend(Player p) {
		friendList.add(p);
	}
	
	public void removeFriend(Player p) {
		if (friendList.contains(p)) {
			friendList.remove(p);
		}
	}
	
	public void addBlack(Player p) {
		blackList.add(p);
	}
	
	public void removeBlack(Player p) {
		if (blackList.contains(p)) {
			blackList.remove(p);
		}
	}
	
	// set/get functions
	public void setID(int id) {
		this.id = id;
	}
	
	public int getID() {
		return this.id;
	}
	
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getGender() {
		return this.gender;
	}
	
	public void setLocation(String location) {
		this.location = location;
	}
	
	public String getLocation() {
		return this.location;
	}
	
	public void setAge(int age) {
		this.age = age;
	}
	
	public int getAge() {
		return this.age;
	}
}
