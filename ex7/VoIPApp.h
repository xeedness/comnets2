#include "UDPBasicApp.h";

#include "IPvXAddressResolver.h"
#include "ILifecycle.h"
#include "LifecycleOperation.h"

class VoIPApp : public UDPBasicApp
{
private:
    int numDiscarded;
    static simsignal_t packetDelaySignal;
public:
    void initialize(int stage);
	void processPacket(cPacket *pk) override;
	void sendPacket() override;
	void finish() override;
};

