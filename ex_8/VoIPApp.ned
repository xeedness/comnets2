package ex_8;

import inet.applications.udpapp.UDPBasicApp;

simple VoIPApp extends UDPBasicApp
{
 	parameters:
        double maxDelay @unit(s) = default(1s); //If the interarrival time between packets is great that this, they are discarded
 		@signal[VoIPPacketDelay](type="simtime_t");      // when receive a frame
 		@statistic[endToEndDelay](title="VoIP Packet End-to-End Delay"; unit="s"; source="VoIPPacketDelay"; record=stats,vector);
 	@class(VoIPApp); 	   
}
