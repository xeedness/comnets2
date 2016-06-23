#
# OMNeT++/OMNEST Makefile for ex7
#
# This file was generated with the command:
#  opp_makemake -f --deep -O out -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/linklayer/ieee80211/radio -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/networklayer/routing/aodv -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/networklayer/common -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/networklayer/icmpv6 -IC:/Users/xeedn/Documents/workspaces/uni/inet/src -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/world/obstacles -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/networklayer/xmipv6 -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/networklayer/contract -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/networklayer/autorouting/ipv4 -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/util -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/linklayer/common -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/transport/contract -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/status -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/linklayer/radio/propagation -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/linklayer/ieee80211/radio/errormodel -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/linklayer/radio -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/applications/udpapp -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/util/headerserializers/tcp -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/networklayer/ipv4 -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/mobility/contract -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/util/headerserializers/ipv4 -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/applications/common -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/base -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/util/headerserializers -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/world/radio -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/linklayer/ieee80211/mac -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/transport/sctp -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/networklayer/ipv6 -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/util/headerserializers/udp -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/networklayer/ipv6tunneling -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/applications/pingapp -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/battery/models -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/util/headerserializers/ipv6 -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/util/headerserializers/sctp -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/linklayer/contract -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/networklayer/arp -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/transport/tcp_common -IC:/Users/xeedn/Documents/workspaces/uni/inet/src/transport/udp -LC:/Users/xeedn/Documents/workspaces/uni/inet/out/$$\(CONFIGNAME\)/src -linet -DINET_IMPORT -KINET_PROJ=C:/Users/xeedn/Documents/workspaces/uni/inet
#

# Name of target to be created (-o option)
TARGET = ex7$(EXE_SUFFIX)

# User interface (uncomment one) (-u option)
USERIF_LIBS = $(ALL_ENV_LIBS) # that is, $(TKENV_LIBS) $(CMDENV_LIBS)
#USERIF_LIBS = $(CMDENV_LIBS)
#USERIF_LIBS = $(TKENV_LIBS)

# C++ include paths (with -I)
INCLUDE_PATH = \
    -I$(INET_PROJ)/src/linklayer/ieee80211/radio \
    -I$(INET_PROJ)/src/networklayer/routing/aodv \
    -I$(INET_PROJ)/src/networklayer/common \
    -I$(INET_PROJ)/src/networklayer/icmpv6 \
    -I$(INET_PROJ)/src \
    -I$(INET_PROJ)/src/world/obstacles \
    -I$(INET_PROJ)/src/networklayer/xmipv6 \
    -I$(INET_PROJ)/src/networklayer/contract \
    -I$(INET_PROJ)/src/networklayer/autorouting/ipv4 \
    -I$(INET_PROJ)/src/util \
    -I$(INET_PROJ)/src/linklayer/common \
    -I$(INET_PROJ)/src/transport/contract \
    -I$(INET_PROJ)/src/status \
    -I$(INET_PROJ)/src/linklayer/radio/propagation \
    -I$(INET_PROJ)/src/linklayer/ieee80211/radio/errormodel \
    -I$(INET_PROJ)/src/linklayer/radio \
    -I$(INET_PROJ)/src/applications/udpapp \
    -I$(INET_PROJ)/src/util/headerserializers/tcp \
    -I$(INET_PROJ)/src/networklayer/ipv4 \
    -I$(INET_PROJ)/src/mobility/contract \
    -I$(INET_PROJ)/src/util/headerserializers/ipv4 \
    -I$(INET_PROJ)/src/applications/common \
    -I$(INET_PROJ)/src/base \
    -I$(INET_PROJ)/src/util/headerserializers \
    -I$(INET_PROJ)/src/world/radio \
    -I$(INET_PROJ)/src/linklayer/ieee80211/mac \
    -I$(INET_PROJ)/src/transport/sctp \
    -I$(INET_PROJ)/src/networklayer/ipv6 \
    -I$(INET_PROJ)/src/util/headerserializers/udp \
    -I$(INET_PROJ)/src/networklayer/ipv6tunneling \
    -I$(INET_PROJ)/src/applications/pingapp \
    -I$(INET_PROJ)/src/battery/models \
    -I$(INET_PROJ)/src/util/headerserializers/ipv6 \
    -I$(INET_PROJ)/src/util/headerserializers/sctp \
    -I$(INET_PROJ)/src/linklayer/contract \
    -I$(INET_PROJ)/src/networklayer/arp \
    -I$(INET_PROJ)/src/transport/tcp_common \
    -I$(INET_PROJ)/src/transport/udp \
    -I. \
    -Iresults

# Additional object and library files to link with
EXTRA_OBJS =

# Additional libraries (-L, -l options)
LIBS = -L$(INET_PROJ)/out/$(CONFIGNAME)/src  -linet
LIBS += -Wl,-rpath,`abspath $(INET_PROJ)/out/$(CONFIGNAME)/src`

# Output directory
PROJECT_OUTPUT_DIR = out
PROJECTRELATIVE_PATH =
O = $(PROJECT_OUTPUT_DIR)/$(CONFIGNAME)/$(PROJECTRELATIVE_PATH)

# Object files for local .cc and .msg files
OBJS = $O/VoIPApp.o

# Message files
MSGFILES =

# Other makefile variables (-K)
INET_PROJ=C:/Users/xeedn/Documents/workspaces/uni/inet

#------------------------------------------------------------------------------

# Pull in OMNeT++ configuration (Makefile.inc or configuser.vc)

ifneq ("$(OMNETPP_CONFIGFILE)","")
CONFIGFILE = $(OMNETPP_CONFIGFILE)
else
ifneq ("$(OMNETPP_ROOT)","")
CONFIGFILE = $(OMNETPP_ROOT)/Makefile.inc
else
CONFIGFILE = $(shell opp_configfilepath)
endif
endif

ifeq ("$(wildcard $(CONFIGFILE))","")
$(error Config file '$(CONFIGFILE)' does not exist -- add the OMNeT++ bin directory to the path so that opp_configfilepath can be found, or set the OMNETPP_CONFIGFILE variable to point to Makefile.inc)
endif

include $(CONFIGFILE)

# Simulation kernel and user interface libraries
OMNETPP_LIB_SUBDIR = $(OMNETPP_LIB_DIR)/$(TOOLCHAIN_NAME)
OMNETPP_LIBS = -L"$(OMNETPP_LIB_SUBDIR)" -L"$(OMNETPP_LIB_DIR)" -loppmain$D $(USERIF_LIBS) $(KERNEL_LIBS) $(SYS_LIBS)

COPTS = $(CFLAGS) -DINET_IMPORT $(INCLUDE_PATH) -I$(OMNETPP_INCL_DIR)
MSGCOPTS = $(INCLUDE_PATH)

# we want to recompile everything if COPTS changes,
# so we store COPTS into $COPTS_FILE and have object
# files depend on it (except when "make depend" was called)
COPTS_FILE = $O/.last-copts
ifneq ($(MAKECMDGOALS),depend)
ifneq ("$(COPTS)","$(shell cat $(COPTS_FILE) 2>/dev/null || echo '')")
$(shell $(MKPATH) "$O" && echo "$(COPTS)" >$(COPTS_FILE))
endif
endif

#------------------------------------------------------------------------------
# User-supplied makefile fragment(s)
# >>>
# <<<
#------------------------------------------------------------------------------

# Main target
all: $O/$(TARGET)
	$(Q)$(LN) $O/$(TARGET) .

$O/$(TARGET): $(OBJS)  $(wildcard $(EXTRA_OBJS)) Makefile
	@$(MKPATH) $O
	@echo Creating executable: $@
	$(Q)$(CXX) $(LDFLAGS) -o $O/$(TARGET)  $(OBJS) $(EXTRA_OBJS) $(AS_NEEDED_OFF) $(WHOLE_ARCHIVE_ON) $(LIBS) $(WHOLE_ARCHIVE_OFF) $(OMNETPP_LIBS)

.PHONY: all clean cleanall depend msgheaders

.SUFFIXES: .cc

$O/%.o: %.cc $(COPTS_FILE)
	@$(MKPATH) $(dir $@)
	$(qecho) "$<"
	$(Q)$(CXX) -c $(CXXFLAGS) $(COPTS) -o $@ $<

%_m.cc %_m.h: %.msg
	$(qecho) MSGC: $<
	$(Q)$(MSGC) -s _m.cc $(MSGCOPTS) $?

msgheaders: $(MSGFILES:.msg=_m.h)

clean:
	$(qecho) Cleaning...
	$(Q)-rm -rf $O
	$(Q)-rm -f ex7 ex7.exe libex7.so libex7.a libex7.dll libex7.dylib
	$(Q)-rm -f ./*_m.cc ./*_m.h
	$(Q)-rm -f results/*_m.cc results/*_m.h

cleanall: clean
	$(Q)-rm -rf $(PROJECT_OUTPUT_DIR)

depend:
	$(qecho) Creating dependencies...
	$(Q)$(MAKEDEPEND) $(INCLUDE_PATH) -f Makefile -P\$$O/ -- $(MSG_CC_FILES)  ./*.cc results/*.cc

# DO NOT DELETE THIS LINE -- make depend depends on it.
$O/VoIPApp.o: VoIPApp.cc \
	VoIPApp.h \
	$(INET_PROJ)/src/applications/common/ApplicationBase.h \
	$(INET_PROJ)/src/applications/udpapp/UDPBasicApp.h \
	$(INET_PROJ)/src/base/Compat.h \
	$(INET_PROJ)/src/base/ILifecycle.h \
	$(INET_PROJ)/src/base/INETDefs.h \
	$(INET_PROJ)/src/base/LifecycleOperation.h \
	$(INET_PROJ)/src/base/NodeOperations.h \
	$(INET_PROJ)/src/base/OperationalBase.h \
	$(INET_PROJ)/src/networklayer/contract/IPv4Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPv6Address.h \
	$(INET_PROJ)/src/networklayer/contract/IPvXAddress.h \
	$(INET_PROJ)/src/transport/contract/UDPSocket.h

