class BugsRemaining {

	var tests:Array<Dynamic>;

	function new() {
		tests = [ new Bugs() ];
	}

	function runTests() {
		// var _trace = haxe.Log.trace;
		// haxe.Log.trace = function ( v, ?p ) Sys.println( v );

		var x = new gtf.Runner( tests );
		var y = x.run();
		
		// trace( 'fixed: ' + y.assert.passed );
		// trace( 'Timed: ' + y.timing.results );

		// trace( 'remaining: ' + y.assert.failed );
		// trace( 'ERRORS: ' + y.assert.errors );
		// trace( 'Timing ERRORS: ' + y.timing.errors );

		// trace( '${y.assert.assertions} assertions, fixed ${y.assert.passed.length}, remaining/failed/errors ${y.assert.failed.length+y.assert.errors.length}' );
		// trace( '${y.timing.tests} timing tests, completed ${y.timing.results.length} and ${y.timing.errors.length} errors.' );

		// haxe.Log.trace = _trace;

		var hrep = new gtf.HTMLReport( haxe.Resource.getString( 'report' ) );
		Sys.print( hrep.execute( 'BugsRemaining report', y ) );
	}

	static function main() {
		var t = new BugsRemaining();
		t.runTests();
	}
	
}
