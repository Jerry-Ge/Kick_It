/*
Team Member:
Natalie Monger, Yifei Xavier Liu, Jason Woodruff, Yuzhou Jerry Ge, Bradley Nguyen
*/
package data;

import java.util.HashMap;

public class GameGroup {
	
	private int id;  // counter(new id) and queue(recycle id) for id in jsp file. maybe get rid of id later
	private Player administrator;
	private String sportType;
	private String location;
	private int maxPlayer;
	private int currentPlayer;
	private String time;
	private String groupName;
	private String skillLevel;
	private boolean isReady;
	private String description;
	//private List<Player> players;
	private HashMap<Integer, Player> players;
	
	public GameGroup(int id, Player administrator, String sportType, String location, int maxPlayer, 
			String time, String groupName, String skillLevel) {
		this.id = id;
		
		this.administrator = administrator;
		this.sportType = sportType;
		this.location = location;
		this.maxPlayer = maxPlayer;
		this.currentPlayer = 1;
		this.time = time;
		this.groupName = groupName;
		this.skillLevel = skillLevel;
		this.isReady = false;
	}
	
	public void ready() {
		this.isReady = true;
	}
	
	public void unready() {
		this.isReady = false;
	}
	
	public void addPlayer(Player p) {
		//players.add(p);
		players.put(p.getID(), p);
	}
	
	public void removePlayer(Player p) {
		//players.remove(p);
		players.remove(p.getID());
	}
	
	public boolean isFull() {
		return maxPlayer == players.size();
	}
	
	// set/get functions
	public void setAdministrator(Player administrator) {
		this.administrator = administrator;
	}
	
	public Player getAdministrator() {
		return this.administrator;
	}
	
	public void setSportType(String sportType) {
		this.sportType = sportType;
	}
	
	public String getSportType() {
		return this.sportType;
	}
	
	public void setLocation(String location) {
		this.location = location;
	}
	
	public String getLocation() {
		return this.location;
	}
	
	public void setMaxPlayer(int maxPlayer) {
		this.maxPlayer = maxPlayer;
	}
	
	public int getMaxPlayer() {
		return this.maxPlayer;
	}
	
	public void setCurrentPlayer(int currentPlayer) {
		this.currentPlayer =currentPlayer;
	}
	
	public int getCurrentPlayer() {
		return this.currentPlayer;
	}
	
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	public String getGroupName() {
		return this.groupName;
	}
	
	public void setTime(String time) {
		this.time = time;
	}
	
	public String getTime() {
		return this.time;
	}
	
	public void setSkillLevel(String skillLevel) {
		this.skillLevel = skillLevel;
	}
	
	public String getSkillLevel() {
		return this.skillLevel;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getDescription() {
		return this.description;
	}
	
}
