package com.danorlando.remoting
{
	import com.danorlando.controllers.UIController;
	import com.danorlando.valueObjects.UserVO;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ArrayUtil;
	import mx.managers.CursorManager;
	
	/**
	 * Holds the method calls to the server and the result and fault handlers.
	 * 
	 * @author Dan Orlando
	 * 
	 */	
	public class ServiceRunner
	{
		
		private var _svc:RemoteService;
		private var _uiController:UIController;
		
		/**
		 * The constructor creates a new RemoteService object and gets
		 * the current instance of the UIController. 
		 */		
		public function ServiceRunner() {
			_svc = new  RemoteService();
			_uiController = UIController.getInstance();
		}
		
		/**
		 * Handler function for the RemoteObject's FaultEvent;
		 * traces the fault information to the console for debugging. 
		 *  
		 * @param fault
		 * 
		 */		
		private function faultHandler(fault:FaultEvent):void  { 
			CursorManager.removeBusyCursor();
			trace("code:\n" + fault.fault.faultCode + "\n\nMessage:\n" + fault.fault.faultString + "\n\nDetail:\n" + fault.fault.faultDetail); 
		}
		
		/**
		 * Makes the call to the <code>User.getUserDetails</code> PHP service through the ZendAMF server side portal.
		 *  
		 * @param userId Takes the userId parameter as a String. This is the value that was returned from the
		 * <code>checkCredentials</code> service.
		 * 
		 */		
		public function getUserDetails(userId:String):void {
			_svc.call("User", "getUserDetails", getUserDetailsHandler, faultHandler, userId, true);
		}
		
		/**
		 * Makes the call to the <code>User.checkCredentials</code> PHP service through the ZendAMF server side portal.
		 * Sends the username and password values for validation by the server side code. The service will return a user id
		 * value if the credentials are validated, or it will return a 'false' String if the credentials were deemed invalid.
		 *  
		 * @param username String text value entered into the username text field on the login form.
		 * @param password String text value entered into the password text field on the login form.
		 * 
		 */		
		public function submitCredentials(username:String, password:String):void {
			_svc.call("User", "checkCredentials", submitCredentialsHandler, faultHandler, [username,password], true);
		}
		
		/**
		 * Handler function for the <code>User.getUserDetails</code> ResultEvent;
		 * forms an ArrayCollection object from the <code>event.result</code> object
		 * and creates a UserVO value object from it.
		 *  
		 * @param event ResultEvent 
		 * @see com.danorlando.valueObjects.UserVO
		 * 
		 */		
		private function getUserDetailsHandler(event:ResultEvent):void {
			var result:ArrayCollection = new ArrayCollection(ArrayUtil.toArray(event.result));
			var user:UserVO = new UserVO;
			user.full_name = result.getItemAt(0) as String;
			user.user_address = result.getItemAt(1) as String;
			user.user_city = result.getItemAt(2) as String;
			user.user_state = result.getItemAt(3) as String;
			user.user_zip = result.getItemAt(4) as String;
			user.user_phone = result.getItemAt(5) as String;
			user.user_email = result.getItemAt(6) as String;
			_uiController.user = user;
			CursorManager.removeBusyCursor();
		}
		
		/**
		 * Handler function for the <code>User.checkCredentials</code> ResultEvent;
		 * first types the <code>event.result</code> object as a String, then checks 
		 * the value to see if it says "false", in which case it calls the <code>UIController.invalidCredentials</code>
		 * method, which fires a UIEvent.INVALID_CREDENTIALS event, otherwise it simply sets the 
		 * the <code>UIController.currentUserId</code> property to the value of the result because as long as the 
		 * return value was not "false", we assume the value is the user id of the user that the 
		 * credentials were sent on for validation.
		 *  
		 * @param event ResultEvent
		 * 
		 */		
		private function submitCredentialsHandler(event:ResultEvent):void {
			var result:String = event.result as String;
			if(result == 'false') {
				_uiController.invalidCredentials();
			}
			else {
				_uiController.currentUserId = result;
			}
			CursorManager.removeBusyCursor();
		}

	}
}