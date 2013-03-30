class Test {
	var tests:Array<Dynamic>;

	function new() {
		tests = [ new TestAssertions(), new TestTiming() ];
	}

	function runTests() {
		// var _trace = haxe.Log.trace;
		// var log = function ( v, p:haxe.PosInfos ) Sys.println( p.className+':'+p.methodName+' (LN '+p.lineNumber+')   '+Std.string( v ) );
		// haxe.Log.trace = function ( v, ?p ) log( v, p );

		var x = new gtf.Runner( tests );
		var y = x.run();
		trace( [ y.assert.assertions, y.assert.passed.length, y.assert.failed.length, y.assert.errors.length ] );

		// haxe.Log.trace = _trace;
	}

	static function main() {
		var t = new Test();
		t.runTests();
	}

}