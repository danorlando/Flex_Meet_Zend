package com.danorlando.valueObjects
{
	[RemoteClass(alias="FlexMeetZend.php.includes.valueObjects.UserVO")]
    [Bindable]
	public class UserVO
	{
		private var _full_name:String;
	    private var _user_address:String;
	    private var _user_city:String;
	    private var _user_state:String;
	    private var _user_zip:String;
	    private var _user_phone:String;
	    private var _user_email:String;
	    
	    public function get full_name():String { return _full_name; }
	    public function get user_address():String { return _user_address; }
	    public function get user_city():String { return _user_city; }
	    public function get user_state():String { return _user_state; }
	    public function get user_zip():String { return _user_zip; }
	    public function get user_phone():String { return _user_phone; }
	    public function get user_email():String { return _user_email; }
	    
	    public function set full_name(fullName:String):void { _full_name = fullName }
	    public function set user_address(address:String):void { _user_address = address }
	    public function set user_city(city:String):void { _user_city = city }
	    public function set user_state(state:String):void { _user_state = state }
	    public function set user_zip(zip:String):void { _user_zip = zip }
	    public function set user_phone(phone:String):void { _user_phone = phone } 
	    public function set user_email(email:String):void { _user_email = email }

	}
}