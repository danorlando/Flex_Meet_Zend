package com.danorlando.remoting
{
	import mx.rpc.AsyncToken;
	import mx.rpc.soap.WebService;
	import mx.rpc.soap.mxml.Operation;

	public class RemoteOperation extends Operation
	{
		public function RemoteOperation(webService:WebService=null, name:String=null)
		{
			super(webService, name);
		}
		
		override public function send(... args:Array):AsyncToken {
			var token:AsyncToken = super.send();
			trace(token);
			return token;
		}
		
	}
}