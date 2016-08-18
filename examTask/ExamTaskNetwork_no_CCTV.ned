package examTask;

import inet.nodes.inet.WirelessHost;
import inet.nodes.inet.StandardHost;
import inet.nodes.inet.Router;

import inet.nodes.wireless.AccessPoint;
import inet.nodes.ethernet.EtherSwitch;

import inet.networklayer.autorouting.ipv4.FlatNetworkConfigurator;
import inet.util.ThruputMeteringChannel;
import inet.world.radio.ChannelControl;

// TODO: correct wifi, ethernet version?
// TODO: vdsl und fats ethernet komplett gleiche bedingungen?

network ExamTaskNetwork_no_CCTV
{
    parameters:
        @display("bgb=600,397");
        // TODO pick sensible value
		int num_laptops = default(5);
    types:
        channel fastEthernet extends ThruputMeteringChannel
        {
            datarate = 100Mbps;
        }
        channel pppLink extends ThruputMeteringChannel
        {
            datarate = 12Mbps;
            delay = 10ms;
        }
        channel dfnLink extends ThruputMeteringChannel
        {
            datarate = 100Mbps;
            delay = 5ms;
        }
        channel vdslInternetLink extends ThruputMeteringChannel
        {
            datarate = 100Mbps;
            delay = 30ms;
        }

	submodules:
        ConferenceLaptop: WirelessHost {
            @display("r=,,#707070;p=35,276");
        }
        FTPLaptop: WirelessHost {
            @display("r=,,#707070;p=68,332");
        }
        BrowsingLaptop[num_laptops]: WirelessHost {
            @display("r=,,#707070;p=86,158");
        }
        ProfessorsLaptop: StandardHost {
            @display("r=,,#707070;p=404,148;i=device/laptop");
            gates:
                ethg[1];
        }
        RemoteAccessPoint: AccessPoint {
            @display("r=,,#707070");
            gates:
                ethg[1];
        }
        RemoteRouter: Router {
            @display("p=240,249;i=device/router");
            gates:
                ethg[1];
                pppg[1];
        }
        MainRouter: Router {
            @display("p=417,249;i=device/router");
            gates:
                ethg[2];
                pppg[1];
        }
        Internet: StandardHost {
            @display("p=538,227");
            gates:
                ethg[1];
        }
        // set up IP addresses, routing tables etc
        configurator: FlatNetworkConfigurator {
            parameters:
                @display("p=174,50");
        }
        // set up wireless channel
        channelControl: ChannelControl {
            parameters:
                @display("p=50,50");
        }
    connections:
        RemoteAccessPoint.ethg[0] <--> fastEthernet <--> RemoteRouter.ethg[0];
        RemoteRouter.pppg[0] <--> pppLink <--> MainRouter.pppg[0];
        Internet.ethg[0] <--> vdslInternetLink <--> MainRouter.ethg[0];
        ProfessorsLaptop.ethg[0] <--> dfnLink <--> MainRouter.ethg[1];
}
