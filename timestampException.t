#charset "us-ascii"
//
// timestampException.t
//
//
#include <adv3.h>
#include <en_us.h>

#include "timestamp.h"

modify Exception
	_skipTimestamp = nil

	construct(msg?, ...) {
		inherited(msg...);
		if(_skipTimestamp != true) {
			gBumpTimestamp;
		}
	}
;
