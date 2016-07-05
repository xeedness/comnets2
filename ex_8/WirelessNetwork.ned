package ex_8;

import inet.nodes.inet.WirelessHost;
import inet.nodes.inet.StandardHost;

import inet.nodes.wireless.AccessPoint;
import inet.nodes.ethernet.EtherSwitch;

import inet.networklayer.autorouting.ipv4.IPv4NetworkConfigurator;
import inet.util.ThruputMeteringChannel;
import inet.world.radio.ChannelControl;

network WirelessNetwork_Switch
{
    parameters:

    types:
        channel conn_ap_switch extends ThruputMeteringChannel
        {
            // pick random datarate to make it work
            datarate = 10Mbps;
            delay = 0ms;
        }

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
        // set up wireless channel
        channelControl: ChannelControl {
            parameters:
                @display("p=50,50");
        }
    connections:
        AccessPoint.ethg[0] <--> conn_ap_switch <--> Switch.ethg[0];
        Switch.ethg[1] <--> conn_ap_switch <--> Station_B.ethg[0];
}
