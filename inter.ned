//
// This file is part of an OMNeT++/OMNEST simulation example.
//
// Copyright (C) 2003 Ahmet Sekercioglu
// Copyright (C) 2003-2008 Andras Varga
//
// This file is distributed WITHOUT ANY WARRANTY. See the file
// `license' for details on this and other legal matters.
//


simple Txc
{
	parameters:
		volatile double timeoutTime @unit(s);
    gates:
        output outlcg;
        output outexp;
        output outdef;
}

simple Rxc
{
    gates:
        input in;
}
network Inter
{
    submodules:
        sender: Txc;
        receiverLCG: Rxc;
        receiverEXP: Rxc;
        receiverDEF: Rxc;
    connections:
        sender.outlcg --> {  delay = 100ms; } --> receiverLCG.in;
        sender.outexp --> {  delay = 100ms; } --> receiverEXP.in;
        sender.outdef --> {  delay = 100ms; } --> receiverDEF.in;
}