class SelfTest {
	var tests:Array<Dynamic>;

	function new() {
		tests = [ new TestAssertions(), new TestTiming() ];
	}

	function runTests() {
		var _trace = haxe.Log.trace;
		haxe.Log.trace = function ( v, ?p ) Sys.println( v );

		var x = new gtf.Runner( tests );
		var y = x.run();

		trace( 'passed: ' + y.assert.passed );
		trace( 'Timed: ' + y.timing.results );

		trace( 'Failed: ' + y.assert.failed );
		trace( 'ERRORS: ' + y.assert.errors );
		trace( 'Timing ERRORS: ' + y.timing.errors );

		trace( '${y.assert.assertions} assertions, passed ${y.assert.passed.length}, failed ${y.assert.failed.length}'
		+ ' and ${y.assert.errors.length} errors.' );
		trace( 'EXPECTED 17, 6, 7, 4' );
		trace( '${y.timing.tests} timing tests, completed ${y.timing.results.length} and ${y.timing.errors.length} errors.' );
		trace( 'EXPECTED 13, 13, 0' );

		haxe.Log.trace = _trace;
	}

	static function main() {
		var t = new SelfTest();
		t.runTests();
	}

}
