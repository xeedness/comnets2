package ex_8;

import inet.nodes.inet.WirelessHost;
import inet.nodes.wireless.AccessPoint;
import inet.nodes.ethernet.EtherSwitch;

network WirelessNetwork_Switch
{
    parameters:
    submodules:
        Station_A: WirelessHost {
            @display("r=,,#707070;p=441,199");
        }
        Station_B: WirelessHost {
            @display("r=,,#707070;p=441,199");
        }
        AccessPoint: AccessPoint {
            @display("p=100,200;r=,,#707070");
        }
        Switch: EtherSwitch {
            @display("p=284,209;i=device/switch");
        }
}
