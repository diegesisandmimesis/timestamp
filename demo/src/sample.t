#charset "us-ascii"
//
// sample.t
// Version 1.0
// Copyright 2022 Diegesis & Mimesis
//
// This is a very simple demonstration "game" for the timestamp library.
//
// It can be compiled via the included makefile with
//
//	# t3make -f makefile.t3m
//
// ...or the equivalent, depending on what TADS development environment
// you're using.
//
// This "game" is distributed under the MIT License, see LICENSE.txt
// for details.
//
#include <adv3.h>
#include <en_us.h>

#include "timestamp.h"

versionInfo: GameID
        name = 'timestamp Library Demo Game'
        byline = 'Diegesis & Mimesis'
        desc = 'Demo game for the timestamp library. '
        version = '1.0'
        IFID = '12345'
	showAbout() {
		"This is a simple test game that demonstrates the features
		of the timestamp library.
		<.p>
		Consult the README.txt document distributed with the library
		source for a quick summary of how to use the library in your
		own games.
		<.p>
		The library source is also extensively commented in a way
		intended to make it as readable as possible. ";
	}
;
gameMain: GameMainDef
	_timestamp = nil
	initialPlayerChar = me
	inlineCommand(cmd) { "<b>&gt;<<toString(cmd).toUpper()>></b>"; }
	printCommand(cmd) { "<.p>\n\t<<inlineCommand(cmd)>><.p> "; }
;

startRoom: Room 'Void' "This is a featureless void.";
+me: Person;

#ifdef __DEBUG

modify TimestampAction
	_report() {
		local t0, t1, diff;

		if(gameMain._timestamp == nil)
			gameMain._timestamp = gTimestamp;

		t0 = gameMain._timestamp;
		t1 = gTimestamp;

		"Timestamp = <<t1.printable()>>\n ";
		diff = t1.difference(t0);
		"Difference = <<diff.printable()>>\n ";
	}
	execSystemAction() {
		_report();
		gBumpTimestamp;
		_report();
	}
;

#endif // __DEBUG
