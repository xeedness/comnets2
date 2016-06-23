#include "UDPBasicApp.h";
class VoIPApp : public UDPBasicApp
{
    int numDiscarded;
	simtime_t timeSinceLast;
	void processPacket(cPacket *pk) override;
	void sendPacket() override;
	void finish() override;
};

