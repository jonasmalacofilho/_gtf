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
		trace( [ y.assert.assertions, y.assert.passed.length, y.assert.failed.length, y.assert.errors.length ] );
		trace( 'passed: ' + y.assert.passed );
		trace( 'Failed: ' + y.assert.failed );
		trace( 'ERRORS: ' + y.assert.errors );
		trace( 'Timed: ' + y.timing.results );
		trace( 'Timing ERRORS: ' + y.timing.errors );

		haxe.Log.trace = _trace;
	}

	static function main() {
		var t = new SelfTest();
		t.runTests();
	}

}
