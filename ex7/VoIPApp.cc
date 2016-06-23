#include "VoIPApp.h"

Define_Module(VoIPApp);

void VoIPApp::processPacket(cPacket *pk)
{
    emit(rcvdPkSignal, pk);
    EV << "Received packet: " << UDPSocket::getReceivedPacketInfo(pk) << endl;
	
	delete pk;
	simtime_t time = simTime();
	if(timeSinceLast-time > par("maxDelay")) {
		EV << "Packet discarded" << endl;
		numDiscarded++;
	}
	numReceived++;
	timeSinceLast = time;
}

void VoIPApp::sendPacket()
{
    char msgName[32];
    sprintf(msgName, "UDPBasicAppData-%d", numSent);
    cPacket *payload = new cPacket(msgName);
    payload->setByteLength(par("messageLength").longValue());

    IPvXAddress destAddr = chooseDestAddr();

    emit(sentPkSignal, payload);
    socket.sendTo(payload, destAddr, destPort);
    numSent++;
}

void VoIPApp::finish() {
    UDPBasicApp::finish();
    recordScalar("lateRatio", (float)numDiscarded/numReceived);
}
