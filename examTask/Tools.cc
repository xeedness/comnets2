#include <omnetpp.h>
#include <fstream>
#include <string>

//Define_Function(get_trace, 1);

/* read the requested sizes (in Byte) from the trace file that we were given */
static cNEDValue ned_get_trace(cComponent *context, cNEDValue argv[], int argc)
{
    // TODO: actually read from file etc
    return cNEDValue(42.0);
}

Define_NED_Function(ned_get_trace,"int get_trace()");
