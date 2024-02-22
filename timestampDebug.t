#charset "us-ascii"
//
// timestampDebug.t
//
#include <adv3.h>
#include <en_us.h>

#include "timestamp.h"

#ifdef __DEBUG

DefineSystemAction(Timestamp)
	execSystemAction() {
		defaultReport('Timestamp = <<gTimestamp.printable()>>');
	}
;
VerbRule(Timestamp) 'timestamp': TimestampAction
	verbPhrase = 'timestamp/timestamping';

#endif // __DEBUG
