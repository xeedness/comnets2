package ex_8;

import inet.nodes.inet.WirelessHost;
import inet.nodes.inet.StandardHost;

import inet.nodes.wireless.AccessPoint;
import inet.nodes.ethernet.EtherSwitch;

import inet.networklayer.autorouting.ipv4.IPv4NetworkConfigurator;

network WirelessNetwork_Switch
{
    parameters:
    submodules:
        Station_A: WirelessHost {
            @display("r=,,#707070;p=123,135");
        }
        Station_B: StandardHost {
            @display("r=,,#707070;p=421,201");
            gates:
                ethg[1];
        }
        AccessPoint: AccessPoint {
            @display("p=100,200;r=,,#707070");
            gates:
                ethg[1];
        }
        Switch: EtherSwitch {
            @display("p=284,209;i=device/switch");
            gates:
                ethg[2];
        }
        // set up IP addresses, routing tables etc
        configurator: IPv4NetworkConfigurator {
            parameters:
                @display("p=404,339");
        }
    connections:
        AccessPoint.ethg[0] <--> {  delay = 100ms; } <--> Switch.ethg[0];
        Switch.ethg[1] <--> {  delay = 100ms; } <--> Station_B.ethg[0];
}
