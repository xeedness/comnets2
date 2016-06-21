import inet.applications.udpapp.UDPBasicApp;
simple VoIPApp extends UDPBasicApp
{
	@class(VoIPApp); // this means that we want to use our VoIPApp C++ class,
	// otherwise UDPBasicApp class would be used by default
	simtime_t timeSinceLast;
	void processPacket(cPacket *pk) override;
	void sendPacket() override;
}

