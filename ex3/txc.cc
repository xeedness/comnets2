//
// This file is part of an OMNeT++/OMNEST simulation example.
//
// Copyright (C) 2003 Ahmet Sekercioglu
// Copyright (C) 2003-2008 Andras Varga
//
// This file is distributed WITHOUT ANY WARRANTY. See the file
// `license' for details on this and other legal matters.
//

#include <string.h>
#include <omnetpp.h>


class Txc : public cSimpleModule
{
private:
    int counterLCG;
    int counterEXP;
    int counterDEF;

    cMessage *timeoutEventLCG;
    cMessage *timeoutEventEXP;
    cMessage *timeoutEventDEF;

    unsigned long lastLCGNumber;
    unsigned long getLCG();
    double getExp();
  protected:
    // The following redefined virtual function holds the algorithm.
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
};

Define_Module(Txc);
unsigned long Txc::getLCG() {
    //unsigned long l = 0;
    //l -= 1;
    unsigned long k;
    for(int i=0; i < 16807; i++) {
        k = (k + lastLCGNumber) % 2147483647;
    }
    lastLCGNumber = k;
    //lastLCGNumber = (16807 * lastLCGNumber) % 2147483647;
    return lastLCGNumber;
}

double Txc::getExp() {

    double rn = (float)getLCG()/ 2147483647;
    return -1 * log(1-rn);


}

void Txc::initialize()
{
    simtime_t timeout;
    lastLCGNumber = 100;
    int counter = 1000;
    counterLCG = counter;
    counterEXP = counter;
    counterDEF = counter;




    timeoutEventLCG = new cMessage("timeoutEventLCG");
    timeout = ((float)getLCG()/2147483647) * 2;
    scheduleAt(simTime()+timeout, timeoutEventLCG);

    timeoutEventEXP = new cMessage("timeoutEventEXP");
    //timeout = par("timeoutTime");
    timeout = getExp();
    scheduleAt(simTime()+timeout, timeoutEventEXP);

    timeoutEventDEF = new cMessage("timeoutEventDEF");
    timeout = cModule::getRNG(0)->doubleRand()*2;
    scheduleAt(simTime()+timeout, timeoutEventDEF);
}

void Txc::handleMessage(cMessage *msg)
{
    if(msg == timeoutEventLCG) {
        if(counterLCG > 0) {
            counterLCG--;


            send(new cMessage("doesnt matter"), "outlcg");

            simtime_t timeout = ((float)getLCG()/2147483647) * 2;
            scheduleAt(simTime()+timeout, timeoutEventLCG);
        } else {
            delete msg;
        }
    } else if(msg == timeoutEventEXP) {
        if(counterEXP > 0) {
            counterEXP--;

            send(new cMessage("doesnt matter"), "outexp");
            //simtime_t timeout = par("timeoutTime");
            simtime_t timeout = getExp();
            EV << "Exp Timeout: " << timeout << "\n";
            scheduleAt(simTime()+timeout, timeoutEventEXP);
        } else {
            delete msg;
        }
    } else if(msg == timeoutEventDEF) {
        if(counterDEF > 0) {
            counterDEF--;

            send(new cMessage("doesnt matter"), "outdef");

            simtime_t timeout = cModule::getRNG(0)->doubleRand()*2;
            scheduleAt(simTime()+timeout, timeoutEventDEF);
        } else {
            delete msg;
        }
    }
}
