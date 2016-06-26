#include <omnetpp.h>
#include "VoIPApp.h"

Define_Module(VoIPApp);



simsignal_t VoIPApp::packetDelaySignal = registerSignal("VoIPPacketDelay");


void VoIPApp::initialize(int stage)
{
    UDPBasicApp::initialize(stage);

    if (stage == 0)
    {
        numDiscarded = 0;
        WATCH(numDiscarded);
    }
}

void VoIPApp::processPacket(cPacket *pk)
{
    emit(rcvdPkSignal, pk);
    EV << "Received packet: " << UDPSocket::getReceivedPacketInfo(pk) << endl;
	

	simtime_t endToEndDelay = pk->getArrivalTime() - pk->getCreationTime();
	emit(packetDelaySignal, endToEndDelay);
	EV << "SendTime: " << pk->getCreationTime() << endl;
	EV << "ArrivalTime: " << pk->getArrivalTime() << endl;
	EV << "CurrentTime: " << simTime() << endl;
	EV << "EndToEndDelay: " << endToEndDelay << endl;
	if(endToEndDelay > par("maxDelay")) {
		EV << "Packet discarded" << endl;
		numDiscarded++;
	}
	numReceived++;
	delete pk;
}

void VoIPApp::sendPacket()
{
    char msgName[32];
    sprintf(msgName, "UDPBasicAppData-%d", numSent);
    cPacket *payload = new cPacket(msgName);
    payload->setByteLength(par("messageLength").longValue());
    payload->setSentFrom(this, 0, simTime());
    IPvXAddress destAddr = chooseDestAddr();

    emit(sentPkSignal, payload);
    socket.sendTo(payload, destAddr, destPort);
    numSent++;
}

void VoIPApp::finish() {
    UDPBasicApp::finish();
    recordScalar("lateRatio", (float)numDiscarded/numReceived);
}
