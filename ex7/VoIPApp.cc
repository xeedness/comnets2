


void VoIPApp::processPacket(cPacket *pk)
{
    emit(rcvdPkSignal, pk);
    EV << "Received packet: " << UDPSocket::getReceivedPacketInfo(pk) << endl;
	
	delete pk;
	if(timeSinceLast-simtime() > par("max_delay")) {
		EV << "Packet discarded" << endl;
	} else {
		numReceived++;
	}
	timeSinceLast = simtime();
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