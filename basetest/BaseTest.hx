class BaseTest {

	var tests:Array<Dynamic>;

	function new() {
		tests = [ new TestFloat.AssertFloat()
		, new TestDS.AssertMap(), new TestDS.TimeDS()
		, new TestDynamic.AssertDynamic() ];
	}

	function runTests() {
		// var _trace = haxe.Log.trace;
		// haxe.Log.trace = function ( v, ?p ) Sys.println( v );

		var x = new gtf.Runner( tests );
		var y = x.run();
		
		// trace( 'passed: ' + y.assert.passed );
		// trace( 'Timed: ' + y.timing.results );

		// trace( 'Failed: ' + y.assert.failed );
		// trace( 'ERRORS: ' + y.assert.errors );
		// trace( 'Timing ERRORS: ' + y.timing.errors );

		// trace( '${y.assert.assertions} assertions, passed ${y.assert.passed.length}, failed ${y.assert.failed.length}'
		// + ' and ${y.assert.errors.length} errors.' );
		// trace( '${y.timing.tests} timing tests, completed ${y.timing.results.length} and ${y.timing.errors.length} errors.' );

		// haxe.Log.trace = _trace;

		var hrep = new gtf.HTMLReport( haxe.Resource.getString( 'report' ) );
		Sys.print( hrep.execute( 'BaseTest report', y ) );
	}

	static function main() {
		var t = new BaseTest();
		t.runTests();
	}
	
}
