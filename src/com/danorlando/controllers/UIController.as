package com.danorlando.controllers
{
	import com.danorlando.events.UIEvent;
	import com.danorlando.remoting.ServiceRunner;
	import com.danorlando.valueObjects.UserVO;
	
	import flash.events.EventDispatcher;
	
	/**
	 * This is the controller class for the view in our modified MVC pattern.
	 * It acts as a central access point for data and events.
	 * 
	 * @author Dan Orlando
	 * 
	 */	
	public class UIController
	{
		public static var instance:UIController;
		private static var _svcFactory:ServiceRunner;
		private static var _dispatcher:EventDispatcher = new EventDispatcher();
		
		/**
		 * Checks to see if there is already an instance of the UIController and
		 * creates a new one if there is not, otherwise it returns the currently
		 * running insance of the UIController; much like a Singleton design pattern.
		 *  
		 * @return Returns the current instance of the UIController
		 * 
		 */		
		public static function getInstance():UIController {
			if (UIController.instance == null) {
				UIController.instance = new UIController();
			}
			return UIController.instance;
		}
//-----------------------------------
//
//  PROPERTIES	
//	
//------------------------------------
		private var _currentUserId:String;
		private var _user:UserVO;
		
		public function get user():UserVO { return _user }
		public function get currentUserId():String { return _currentUserId }
		public function get dispatcher():EventDispatcher { return _dispatcher }
		
		/**
		 * When the <code>UIController.user</code> property is set, a UIEvent.USER_PROFILE
		 * event must be dispatched to notify the view layer that we have a UserVO object 
		 * ready to be populated into the respective fields in the display.
		 *  
		 * @param userDetails UserVO 
		 * 
		 */		
		public function set user(userDetails:UserVO):void { 
			_user = userDetails;
			var evt:UIEvent = new UIEvent(UIEvent.USER_PROFILE);
			_dispatcher.dispatchEvent(evt);
		}
		
		/**
		 * When the <code>UIController.currentUserId</code> property is set, a
		 * UIEvent.CREDENTIALS_VALIDATED event is fired, notifying the display
		 * layer accordingly so the service can be called to get the respective 
		 * user's details.
		 *  
		 * @param userId String
		 * 
		 */				
		public function set currentUserId(userId:String):void { 
			_currentUserId = userId;
			var evt:UIEvent = new UIEvent(UIEvent.CREDENTIALS_VALIDATED);
			_dispatcher.dispatchEvent(evt);
		}
		
//-------------------------------------
//
//  METHODS
//
//------------------------------------
		
		/**
		 * Makes the call to <code>ServiceRunner.submitCredentials</code>.
		 *  
		 * @param username String value entered into the username field of the login form
		 * @param password String value entered into the password field of the login form
		 * @see com.danorlando.remoting.ServiceRunner
		 */		
		public function submitCredentials(username:String, password:String):void {
			_svcFactory = new ServiceRunner();
			_svcFactory.submitCredentials(username,password);
		}
		
		/**
		 * Makes the call to <code>ServiceRunner.getUserDetails</code>.
		 *  
		 * @param event UIEvent - Default is null
		 * @see com.danorlando.remoting.ServiceRunner
		 */		
		public function getUserDetails(event:UIEvent=null):void {
			_svcFactory.getUserDetails(_currentUserId);
		}
		
		/**
		 * Dispatches the <code>UIEvent.INVALID_CREDENTIALS</code> event when 
		 * we get the respective response from the server. 
		 * 
		 */		
		public function invalidCredentials():void {
			var evt:UIEvent = new UIEvent(UIEvent.INVALID_CREDENTIALS);
			_dispatcher.dispatchEvent(evt);
		}
		
		

	}
}