//
// timestamp.h
//

// Uncomment to enable debugging options.
//#define __DEBUG_TIMESTAMP

#define gTimestamp (timestampService.timestamp().clone())
#define gBumpTimestamp (timestampService.bump())
#define gCheckTimestamp(v) (timestampService.check(v))
#define gDuration(v) (timestampService.duration(v))
#define gDebugTS (timestampService.timestamp().printable())

#define TIMESTAMP_H
