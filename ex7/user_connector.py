#!/usr/bin/python3

import argparse
import random

str_connection = "**.user[{}].udpApp[0].destAddresses = \"user[{}]\"\n"

parser = argparse.ArgumentParser(description='Generates a user connection file to be included in an omnet.ini\nTakes care of connecting users over the farthest distance, i.e. the internet gateway (therefore a different backbone), to accumulate worst case propagation delays.')

parser.add_argument('-voip', action='store_true', help='configure connections for Config VoiceTest')
parser.add_argument('-b', dest='num_bb', type=int, default=2, help='Backbone routers (default: 2)')
parser.add_argument('-a', dest='num_access_per_bb', type=int, default=1, help='Access routers per backbone router (default: 1)')
parser.add_argument('-u', dest='num_user_per_access', type=int, default=2, help='Users per access router (default: 2)')


args = parser.parse_args()

print("Arguments:", args.num_bb, args.num_access_per_bb, args.num_user_per_access)

num_access_total = args.num_access_per_bb * args.num_bb
users_per_backbone = args.num_access_per_bb * args.num_user_per_access
total_users = args.num_bb * users_per_backbone

num_bb = args.num_bb
num_access_per_bb = args.num_access_per_bb
num_user_per_access = args.num_user_per_access

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

if args.voip:
	# we're creating a voip config, not the worst case config
	str_fname = "user_connections_voicetest.ini"
else:
	# worst case config file (this is the default)
	str_fname = "user_connections.ini"


def create_connection_file():
	str_con_file = "# This file includes worst case user connections for omnet++/exercise7\n"

	for u in range(0, total_users): #i.e.: total_users-1
		str_con_file += str_connection.format(u, (u + users_per_backbone) % total_users )

	print("The connection file looks like this:\n\n" + str_con_file)

	return str_con_file

def create_connection_file_voip():
	'''
	Based on the network structure we were given, we’re assuming the network
	we have is an internal company network. Thus, we can assume that all calls
	happen within work hours, so during 8 hours of a day. Let’s say all users
	spend 50 minutes on the phone on average, and each call takes 10 minutes.
	For the sake of simplicity, we’ll entertain the very naive notion that
	those calls are equally distributed across the day and that they’re
	slotted into 10 minute time slots.
	This leads us to (625*5)/2 = 1562.5 connections a day spread over 48 time
	slots. Thus, during each time slot, 1562.5/48 + 32.55 calls take place at
	the same time.

	To summarize:
	active users at the time of the simulation: 66
	=> active calls at the time of the simulation: 33

	Now we need to distribute these calls across the network. according to
	[1], local connections are more likely (i.e. more connections go just via
	access router and less go all the way up through the internet). Thus, we're
	creating around 1/2 of the connections as local to the access point, 1/3
	of all connections only go up to the back bones and 1/6 of all connections
	are routed all the way up to the gateway.

	[1] Structure and tie strengths in mobile communication networks
	https://www.hks.harvard.edu/davidlazer/files/papers/Lazer_PNAS_2007.pdf
	'''

	str_con_file = "# This file includes regular voip user connections for omnet++/exercise7\n"
	# just make sure we always get the same connections
	random.seed(23)


	# users not in a call (yet)
	available_users = list(range(0, total_users))

	# create connections that use the gateway
	str_con_file += "# connections that use the gateway\n"
	for c in range(0, 6):

		# search for 2 random users to connect
		users = random.sample(available_users, 2)

		# connect them
		str_con_file += str_connection.format(users[0], users[1])
		str_con_file += str_connection.format(users[1], users[0])
		str_con_file += "\n"

		# remove users from available pool
		available_users.remove(users[0])
		available_users.remove(users[1])

	# create connections that use a backbone router
	str_con_file += "# connections that use use a backbone router\n"
	for c in range (0, 11):
		# pick a backbone
		bb_no = random.randint(0, num_bb-1)

		# pick 2 different access points connected to backbone
		access_nos = random.sample(range(0, num_access_per_bb), 2)

		# connect 2 users
		users = []
		for i in range (0,2):
			user_found = False

			while (not user_found):
				# pick a user (number is local to the access points)
				user_no = random.randint(0, num_user_per_access-1)
				# locate user's position in whole tree
				user_pos = ((5*bb_no + access_nos[i]) * num_user_per_access) + user_no
				if (user_pos in available_users):
					users.append(user_pos)
					# remove user from available pool
					available_users.remove(user_pos)
					user_found = True

		# connect them
		str_con_file += str_connection.format(users[0], users[1])
		str_con_file += str_connection.format(users[1], users[0])
		str_con_file += "\n"

		# TODO: if there are no connections left for this router, move on


	# create connections that use only an access router
	str_con_file += "# connections that use only an access router\n"

	for c in range (0, 16):
		# pick a router
		access_no = random.randint(0, num_access_total-1)

		# connect 2 users at access_no
		users = []
		for i in range (0,2):
			user_found = False

			while (not user_found):
				# pick a user (number is local to the access points)
				user_no = random.randint(0, num_user_per_access-1)
				# locate user's position in whole tree
				user_pos = (access_no * num_user_per_access) + user_no
				if (user_pos in available_users):
					users.append(user_pos)
					# remove user from available pool
					available_users.remove(user_pos)
					user_found = True

		# connect them
		str_con_file += str_connection.format(users[0], users[1])
		str_con_file += str_connection.format(users[1], users[0])
		str_con_file += "\n"


	#print("The connection file looks like this:\n\n" + str_con_file)

	return str_con_file

def main():
	if (str_fname == "user_connections_voicetest.ini"):
		str_con_file = create_connection_file_voip()
	else:
		str_con_file = create_connection_file()

	# write connections crested with create_connection_file()
	# or create_connection_file_voip() to file
	f_omnet_include = open(str_fname, "w")
	f_omnet_include.write(str_con_file)
	f_omnet_include.close()

	print("Written",str_fname,"successfully")

main()
