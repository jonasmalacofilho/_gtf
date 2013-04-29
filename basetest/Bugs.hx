class Bugs extends gtf.Test {

	public function new() {}

	#if neko
	@test public function neko() {
		// TestFloat.AssertFloat.testInfNaN
		assertTrue( Math.POSITIVE_INFINITY > Math.NaN );
		assertTrue( Math.NEGATIVE_INFINITY > Math.NaN );
		// TestFloat.AssertFloat.testNaNEqNeq
		assertTrue( Math.NaN > Math.NaN );
		// TestDS.AssertMap.testNullKey
		assertThrows( new Map<Null<String>,Int>().set( null, -10 ) );
	}
	#end

	#if cpp
	@test public function cpp() {
		// TestDynamic.AssertDynamic.testFloat
		assertFalse( TestDynamic.AssertDynamic.convert( Math.POSITIVE_INFINITY ) == TestDynamic.AssertDynamic.convert( Math.POSITIVE_INFINITY ) );
		assertFalse( TestDynamic.AssertDynamic.convert( Math.NEGATIVE_INFINITY ) == TestDynamic.AssertDynamic.convert( Math.NEGATIVE_INFINITY ) );
	}
	#end

}