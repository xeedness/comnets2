#!/usr/bin/python3

import argparse


parser = argparse.ArgumentParser(description='Generates a user connection file to be included in an omnet.ini\nTakes care of connecting users over the farthest distance, i.e. the internet gateway (therefore a different backbone), to accumulate worst case propagation delays.')

parser.add_argument('-b', dest='num_bb', type=int, default=2, help='Backbone routers (default: 2)')
parser.add_argument('-a', dest='num_access_per_bb', type=int, default=1, help='Access routers per backbone router (default: 1)')
parser.add_argument('-u', dest='num_user_per_access', type=int, default=2, help='Users per access router (default: 2)')


args = parser.parse_args()

print("Arguments:", args.num_bb, args.num_access_per_bb, args.num_user_per_access)

users_per_backbone = args.num_access_per_bb * args.num_user_per_access
total_users = args.num_bb * users_per_backbone

if args.num_bb <= 0 or args.num_access_per_bb <= 0:
	print("Invalid arguments: Less or equal to zero.\nExiting...")
	exit()

if args.num_bb == 1:
	print("Not sensible to have one backbone (Gateway won't be used / No inter-backbone connection).\nExiting...")
	exit()

if total_users == 1:
	print("No connection peer for a single user network.\nExiting...")
	exit()

print('Total users:', total_users, "\n")

def create_connection_file():
	str_connection = "**.user[{}].udpApp[0].destAddresses = \"user[{}]\"\n"

	str_con_file = "# This file includes worst case user connections for omnet++/exercise7\n"

	for u in range(0, total_users): #i.e.: total_users-1
		str_con_file += str_connection.format(u, (u + users_per_backbone) % total_users )

	print("The connection file looks like this:\n\n" + str_con_file)

	return str_con_file


def main():
	
	str_con_file = create_connection_file()
	str_fname = "user_connections.ini"
	
	f_omnet_include = open(str_fname, "w")
	f_omnet_include.write(str_con_file)
	f_omnet_include.close()

	print("Written",str_fname,"successfully")

main()
