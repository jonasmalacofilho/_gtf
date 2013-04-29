class Bugs extends gtf.Test {

	public function new() {}

	#if neko
	@test public function neko() {
		// TestFloat.AssertFloat.testInfNaN
		assertFalse( Math.POSITIVE_INFINITY > Math.NaN );
		assertFalse( Math.NEGATIVE_INFINITY > Math.NaN );
		// TestFloat.AssertFloat.testNaNEqNeq
		assertFalse( Math.NaN > Math.NaN );
		// TestDS.AssertMap.testNullKey
		assertEquals( -10, { var x = new Map<Null<String>,Int>(); x.set( null, -10 ); x.get( null ); } );
	}
	#end

	#if cpp
	@test public function cpp() {
		// TestDynamic.AssertDynamic.testFloat
		assertTrue( TestDynamic.AssertDynamic.convert( Math.POSITIVE_INFINITY ) == TestDynamic.AssertDynamic.convert( Math.POSITIVE_INFINITY ) );
		assertTrue( TestDynamic.AssertDynamic.convert( Math.NEGATIVE_INFINITY ) == TestDynamic.AssertDynamic.convert( Math.NEGATIVE_INFINITY ) );
	}
	#end

}