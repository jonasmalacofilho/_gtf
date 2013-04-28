class BaseTest {

	var tests:Array<Dynamic>;

	function new() {
		tests = [ new TestFloat() ];
	}

	function runTests() {
		var _trace = haxe.Log.trace;
		haxe.Log.trace = function ( v, ?p ) Sys.println( v );

		var x = new gtf.Runner( tests );
		var y = x.run();
		
		// trace( 'passed: ' + y.assert.passed );
		trace( 'Failed: ' + y.assert.failed );
		trace( 'ERRORS: ' + y.assert.errors );
		// trace( 'Timed: ' + y.timing.results );
		trace( 'Timing ERRORS: ' + y.timing.errors );

		trace( '${y.assert.assertions} assertions, passed ${y.assert.passed.length}, failed ${y.assert.failed.length} and ${y.assert.errors.length} errors.' );

		haxe.Log.trace = _trace;
	}

	static function main() {
		var t = new BaseTest();
		t.runTests();
	}
	
}
