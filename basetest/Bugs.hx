class Bugs extends gtf.Test {

	public function new() {}

	#if neko
	@test public function neko() {
		// TestFloat.AssertFloat.testInfNaN
		// Reported: https://code.google.com/p/nekovm/issues/detail?id=38
		assertFalse( Math.POSITIVE_INFINITY > Math.NaN ); // Math.NaN is unordered
		assertFalse( Math.NEGATIVE_INFINITY > Math.NaN ); // Math.NaN is unordered
		// TestFloat.AssertFloat.testNaNEqNeq
		// Reported: https://code.google.com/p/nekovm/issues/detail?id=38
		assertFalse( Math.NaN > Math.NaN ); // Math.NaN is unordered
		// TestDS.AssertMap.testNullKey
		// Reported: https://code.google.com/p/nekovm/issues/detail?id=38
		assertEquals( -10, { var x = new Map<Null<String>,Int>(); x.set( null, -10 ); x.get( null ); } );
	}
	#end

	#if cpp
	@test public function cpp() {
		// TestDynamic.AssertDynamic.testComparisson
		assertTrue( TestDynamic.AssertDynamic.convert( Math.POSITIVE_INFINITY ) == TestDynamic.AssertDynamic.convert( Math.POSITIVE_INFINITY ) );
		assertTrue( TestDynamic.AssertDynamic.convert( Math.NEGATIVE_INFINITY ) == TestDynamic.AssertDynamic.convert( Math.NEGATIVE_INFINITY ) );
	}
	#end

}
