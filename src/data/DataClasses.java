/*
Team Member:
Natalie Monger, Yifei Xavier Liu, Jason Woodruff, Yuzhou Jerry Ge, Bradley Nguyen
*/

package data;

import java.util.*;

public class DataClasses {
	public int playerId = 0;
	public int gameGroupId = 0;
	
	public HashMap<String, String> image = new HashMap<>();
	
	DataClasses() {
		image.put("soccer", "soccer.jpg");
		image.put("basketball", "basketball.jpg");
		image.put("football", "football.jpg");
		image.put("tennis", "tennis.jpg");
		image.put("any", "any.jpg");
	}
}
