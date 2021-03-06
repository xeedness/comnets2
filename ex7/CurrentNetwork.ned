//
// Copyright (C) 2000 Institut fuer Telematik, Universitaet Karlsruhe
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//
package ex7;

import inet.util.ThruputMeteringChannel;
import inet.util.NetAnimTrace;
import inet.nodes.inet.Router;
import inet.nodes.inet.StandardHost;
//import inet.networklayer.autorouting.ipv4.IPv4NetworkConfigurator;
import inet.networklayer.autorouting.ipv4.FlatNetworkConfigurator;

network CurrentNetwork
{
    parameters:
        double per = default(0);
        int num_bb = default(2);
        int num_access_per_bb = default(2);
        int num_user_per_access = default(2);
        
        int num_access = num_access_per_bb * num_bb;
        int num_users = num_user_per_access * num_access;
        
        int num_conn_gw_bb = num_bb;
        int num_conn_bb_access = num_access_per_bb * num_bb;
        int num_conn_access_users = num_user_per_access * num_access;

        

//        @display("bgb=576,407");
    types:
        channel conn_internet_gw extends ThruputMeteringChannel
        {
            datarate = num_bb*10Mbps;
            delay = 0ms;
        }
        channel conn_gw_bb extends ThruputMeteringChannel
        {
            datarate = 10Mbps;
            delay = 10ms;
        }
        channel conn_bb_access extends ThruputMeteringChannel
        {
            datarate = 2Mbps;
            delay = 10ms;
        }

        channel conn_access_users extends ThruputMeteringChannel
        {
            datarate = 64kbps;
            delay = 40ms;
        }

    submodules:
        internet: StandardHost {
//            @display("p=502,44");
            gates:
                pppg[1];
        }
        gateway: Router {
//            @display("p=294,33");
            gates:
                pppg[1+num_bb];
        }
        backbone[num_bb]: Router {
//            @display("p=396,110");
            gates:
                // 1 conn to gateway, 5 to access
                pppg[1 + num_access_per_bb];
        }
        accesspoint[num_access]: Router {
//            @display("p=203,96");
            gates:
                // 1 conn to backbone, 25 to users
                pppg[1 + num_user_per_access];
        }
        user[num_users]: StandardHost {
            parameters:
//                @display("p=53,23;i=device/pc3");
            gates:
                pppg[1];
        }
        configurator: FlatNetworkConfigurator {
            parameters:
//                @display("p=404,339");
        }
        netAnimTrace: NetAnimTrace {
//            @display("p=502,346");
        }
    connections:
        // connect gateway to internet
        internet.pppg[0] <--> conn_internet_gw <--> gateway.pppg[0];

		// note: connection #0 is always the connection to the "higher up" router

        // connect backbones to gateway
        for i=0..(num_bb-1) {
            gateway.pppg[i+1] <--> conn_gw_bb <--> backbone[i].pppg[0];
        }

        // connect backbones to access points
        for i=0..(num_access-1) {
            backbone[i/num_bb].pppg[(i % (num_conn_gw_bb))+1] <--> conn_bb_access <--> accesspoint[i].pppg[0];
        }

        // connect access points to users
        for i=0..(num_users-1) {
            accesspoint[i/num_user_per_access].pppg[(i % (num_user_per_access))+1] <--> conn_access_users <--> user[i].pppg[0];
        }
}

