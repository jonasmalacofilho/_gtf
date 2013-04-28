class TestFloat extends gtf.Test {

	public function new() {}

	@test function testInfGtLt() {
		assertTrue( Math.NEGATIVE_INFINITY < Math.POSITIVE_INFINITY );
		assertTrue( Math.POSITIVE_INFINITY > Math.NEGATIVE_INFINITY );
		assertTrue( 0. < Math.POSITIVE_INFINITY );
		assertTrue( 0. > Math.NEGATIVE_INFINITY );
	}

	@test function behaveInfEqNeq() {
		assertTrue( Math.POSITIVE_INFINITY == Math.POSITIVE_INFINITY );
		assertTrue( Math.NEGATIVE_INFINITY == Math.NEGATIVE_INFINITY );
		assertFalse( Math.POSITIVE_INFINITY != Math.POSITIVE_INFINITY );
		assertFalse( Math.NEGATIVE_INFINITY != Math.NEGATIVE_INFINITY );
	}

	@test function testInfNaN() {
		assertFalse( Math.isNaN( Math.POSITIVE_INFINITY ) );
		assertFalse( Math.isNaN( Math.NEGATIVE_INFINITY ) );
		assertFalse( Math.isFinite( Math.NaN ) );
	}

	@test function testNaNEqNeq() {
		assertTrue( Math.isNaN( Math.NaN ) );
		assertFalse( Math.NaN == Math.NaN );
		assertTrue( Math.NaN != Math.NaN );
	}

	@test function testExceptions() {
		assertTrue( Math.isNaN( Math.sqrt( -1. ) ) );
		assertTrue( !Math.isFinite( 1./0. ) );
		assertEquals( Math.POSITIVE_INFINITY, 1./0. );
		assertTrue( !Math.isFinite( (-1.)/0. ) );
		assertEquals( Math.NEGATIVE_INFINITY, (-1.)/0. );
	}

}
