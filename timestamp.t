#charset "us-ascii"
//
// timestamp.t
//
//	A TADS3/adv3 module implementing a timestamp mechanism.
//
//	The basic timestamp is the turn number, which is extended by
//	a counter which can be used to disambiguate in cases where
//	actions take zero turns (like system actions), or in cases where
//	seriality of multiple actions in a single turn need to be tracked.
//
//
// USAGE
//
//	Usage is straighforward.  To get the current timestamp:
//
//		local ts = gTimestamp;
//
//	To bump the timestamp without changing the turn number:
//
//		gBumpTimestamp;
//
//	To compare a given timestamp to the current timestamp, returning
//	boolean true if they're equal, nil otherwise:
//
//		local ts = new Timestamp();
//		gCheckTimestamp(ts);
//
//	To get the duration between the current timestamp and the given
//	timestamp (values will be positive if the current timestamp is later
//	than the given timestamp, negative otherwise):
//
//		gDuration(ts);
//
//
// THE TIMESTAMP CLASS
//
//	The Timestamp class has a number of methods for working with
//	timestamps.
//
//		clone()		returns a copy of the timestamp
//		isEqual(v)	boolean true if the timestamp is the same as v
//		isBefore(v)	boolean true if the timestamp is before v
//		isAfter(v)	boolean true if the timestamp is after v
//		difference(v)	returns a timestamp instance containing the
//				difference between the timestamp and v
//		add(v)		adds v to the timestamp
//		subtract(v)	subtracts v from the timestamp
//
//
#include <adv3.h>
#include <en_us.h>

#include "timestamp.h"

// Module ID for the library
timestampModuleID: ModuleID {
        name = 'Timestamp Library'
        byline = 'Diegesis & Mimesis'
        version = '1.0'
        listingOrder = 99
}

class Timestamp: object
	turn = 0
	fraction = 0
	construct(t, f?) {
		if(t != nil)
			turn = t;
		if(f != nil)
			fraction = f;
	}
	clone() { return(new Timestamp(turn, fraction)); }
	isEqual(v) { return((v.turn == turn) && (v.fraction == fraction)); }
	isBefore(v) {
		return((turn < v.turn) || (fraction < v.fraction));
	}
	isAfter(v) {
		return((turn > v.turn) || (fraction > v.fraction));
	}
	difference(v) {
		return(new Timestamp(turn - v.turn, fraction - v.fraction));
	}
	add(v) {
		turn += v.turn;
		fraction += v.fraction;
		return(self);
	}
	subtract(v) {
		turn -= v.turn;
		fraction -= v.fraction;
		return(self);
	}
	set(t, f?) {
		turn = t;
		fraction = ((f != nil) ? f : 0);
	}
	printable() {
		return('<<toString(turn)>>/<<toString(fraction)>>');
	}
;

timestampService: object
	_ts = nil

	timestamp() {
		local t;

		t = libGlobal.totalTurns;
		if(_ts == nil)
			_ts = new Timestamp(t);
		if(_ts.turn != t)
			_ts.set(t, 0);
		
		return(_ts);
	}
	bump(v?) {
		if(v == nil)
			v = 1;
		timestamp();
		_ts.fraction += v;
		return(_ts);
	}
	check(v?) {
		if((v == nil) || !v.ofKind(Timestamp))
			return(nil);
		return(v.isEqual(timestamp()));
	}
	duration(v?) {
		if((v == nil) || !v.ofKind(Timestamp))
		return(timestamp().difference(v));
			return(nil);
	}
;
