import inet.applications.udpapp.UDPBasicApp;
simple VoIPApp extends UDPBasicApp
{
 	parameters:
        double maxDelay @unit(s) = default(1s); //If the interarrival time between packets is great that this, they are discarded
 	
 	@class(VoIPApp); 	   
}