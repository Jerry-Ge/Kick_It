package data;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;
import java.util.TreeMap;
import java.util.Vector;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/ws")
public class ServerSocket {
	private static Vector<Session> sessionVector = new Vector<Session>();
	private static TreeMap<String, Session> onlineUsers = new TreeMap<String, Session>();
	private static Set<String> keySet = onlineUsers.keySet();
	private static Iterator<String> keySetIterator = keySet.iterator();

	@OnOpen
	public void open(Session session) {
		// System.out.println("opening");
		sessionVector.add(session);
	}

	@OnMessage
	public void onMessage(String username, Session session) {
		// non-guest users only
		if(!username.equals("")) {
			String[] parts = username.split("-");
			String name = parts[0];
			String cd = parts[1];
			
			if(cd.equals("connect") || cd.equals("disconnect")) {
				// user logs in
				if(cd.equals("connect")) {
					onlineUsers.put(name, session);
				}
				// user logs out
				else if(cd.equals("disconnect")) {
					onlineUsers.remove(name);
				}
			}
			else if(cd.equals("game")) {
				System.out.println("game");
				try {
					for (Session s : sessionVector) {
						s.getBasicRemote().sendText("gameCreated");
					}
				} catch (IOException ioe) {
					System.out.println("ioe: " + ioe.getMessage());
					close(session);
				}
			}			
		}
		try {
			for (Session s : sessionVector) {
				keySet = onlineUsers.keySet();
				keySetIterator = keySet.iterator();
				
				String allKeys = "";
				while (keySetIterator.hasNext()) {
					String key = keySetIterator.next();
					allKeys += key += " ";
				}
				
				s.getBasicRemote().sendText(allKeys);
			}
		} catch (IOException ioe) {
			System.out.println("ioe: " + ioe.getMessage());
			close(session);
		}
	}

	@OnClose
	public void close(Session session) {
		System.out.println("closing");
		sessionVector.remove(session);
	}

	@OnError
	public void onError(Throwable error) {
		System.out.println("error");
	}

}