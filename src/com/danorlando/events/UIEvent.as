package com.danorlando.events
{
	import flash.events.Event;

	public class UIEvent extends Event
	{
		public static const INVALID_CREDENTIALS		: String = "invalidCredentialsEvent";
		public static const CREDENTIALS_VALIDATED	: String = "credentialsValidatedEvent";
		public static const USER_PROFILE			: String = "userProfileEvent";
		
		private var _resource:Object;
		
		public function UIEvent(type:String, resource:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_resource = resource;
		}
		
	}
}