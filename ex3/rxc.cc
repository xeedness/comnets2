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


class Rxc : public cSimpleModule
{
private:
    simtime_t lastTime;
    cDoubleHistogram interArrivalTimes;
  protected:
    // The following redefined virtual function holds the algorithm.
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
    virtual void finish();
};

// The module class needs to be registered with OMNeT++
Define_Module(Rxc);

void Rxc::initialize()
{
    lastTime = simTime();
}

void Rxc::handleMessage(cMessage *msg)
{
    simtime_t newTime = simTime();
    EV << " Message received. Difference is." << (newTime-lastTime) << " \n";

    interArrivalTimes.collect(newTime-lastTime);

    lastTime = newTime;
    delete msg;
}

void Rxc::finish() {
    interArrivalTimes.recordAs("inter arrival times");

}
