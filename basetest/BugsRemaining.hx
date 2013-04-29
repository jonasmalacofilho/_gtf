class BugsRemaining {

	var tests:Array<Dynamic>;

	function new() {
		tests = [ new Bugs() ];
	}

	function runTests() {
		var _trace = haxe.Log.trace;
		haxe.Log.trace = function ( v, ?p ) Sys.println( v );

		var x = new gtf.Runner( tests );
		var y = x.run();
		
		trace( 'remaining: ' + y.assert.passed );
		// trace( 'Timed: ' + y.timing.results );

		trace( 'fixed?: ' + y.assert.failed );
		trace( 'ERRORS: ' + y.assert.errors );
		// trace( 'Timing ERRORS: ' + y.timing.errors );

		trace( '${y.assert.assertions} assertions, remaining ${y.assert.passed.length}, maybe fixed ${y.assert.failed.length}'
		+ ' and ${y.assert.errors.length} errors.' );
		// trace( '${y.timing.tests} timing tests, completed ${y.timing.results.length} and ${y.timing.errors.length} errors.' );

		haxe.Log.trace = _trace;
	}

	static function main() {
		var t = new BugsRemaining();
		t.runTests();
	}
	
}
