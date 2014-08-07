package com.danorlando.remoting
{
	
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.Operation;
	import mx.rpc.remoting.RemoteObject;
	
	public class RemoteService
	{
		public function RemoteService()	{}
		
		private static var _remoteObj:RemoteObject;
		private static var _showBusyCursor:Boolean = true;
	
		/**
		 * The <code>call</code> function is used to make a remote object service call to the ZendAMF server side gateway 
		 * 
		 * @param roSource - The amfphp service source file
		 * @param methodName - The method to be called 
		 * @param result - The result handler
		 * @param fault - The fault handler
		 * @param arguments - Used to pass data to the service
		 * @param showBusyCursor - Set to false to manage cursor manually
		 * 
		 */		
		public function call(roSource:String, methodName:String, result:Function, fault:Function, arguments:* = null, showBusyCursor:Boolean = true):void {
			if (!showBusyCursor) {
				_showBusyCursor = false;
			}
			else {
				CursorManager.setBusyCursor();
			}
			
			startRemoteObject();
			
			_remoteObj.addEventListener(FaultEvent.FAULT, fault);
			// set the source property of the RemoteObject
			_remoteObj.source = roSource;
			
			var op:Operation = new Operation(_remoteObj);
			// set the String value for the name of the service we are calling
			op.name = methodName;
			
			var svc:Operation = _remoteObj.getOperation(methodName) as Operation;
			svc.addEventListener(ResultEvent.RESULT, result);
			// if we got any arguments, make sure they are passed to the service through the send() method of the Operation object
		//	trace(svc.send(arguments));
			svc.send(arguments);
		//	trace(msg);
		}
		
		/**
		 * Instantiates a new remote object 
		 * 
		 */		
		private static function startRemoteObject():void {
			_remoteObj = new RemoteObject();
			// set this value to the destination point specified in the services configuration xml file
			_remoteObj.destination = 'zend';
			_remoteObj.requestTimeout = -1;
		
		}

	}
}