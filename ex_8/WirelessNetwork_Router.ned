package ex_8;

import inet.nodes.inet.WirelessHost;
import inet.nodes.inet.StandardHost;
import inet.nodes.inet.Router;

import inet.nodes.wireless.AccessPoint;

import inet.networklayer.autorouting.ipv4.IPv4NetworkConfigurator;
import inet.util.ThruputMeteringChannel;
import inet.world.radio.ChannelControl;

network WirelessNetwork_Router
{
    parameters:

    types:
        channel conn_ap_router extends ThruputMeteringChannel
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
            @display("r=,,#707070;p=327,213");
            gates:
                pppg[1];
        }
        AccessPoint: AccessPoint {
            @display("p=100,200;r=,,#707070");
            gates:
                ethg[1];
        }
        Router: Router {
            @display("p=221,228;i=device/router");
            gates:
                ethg[1];
                pppg[1];
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
        AccessPoint.ethg[0] <--> conn_ap_router <--> Router.ethg[0];
        Router.pppg[0] <--> conn_ap_router <--> Station_B.pppg[0];
}