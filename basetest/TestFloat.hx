class AssertFloat extends gtf.Test {

	public function new() {}

	@test function testInfGtLt() {
		// basic ordering
		assertTrue( 0. < Math.POSITIVE_INFINITY );
		assertTrue( 0. > Math.NEGATIVE_INFINITY );
		assertTrue( Math.NEGATIVE_INFINITY < Math.POSITIVE_INFINITY );
		assertTrue( Math.POSITIVE_INFINITY > Math.NEGATIVE_INFINITY );
		// +/-inf is NOT great/less than itself
		assertFalse( Math.POSITIVE_INFINITY > Math.POSITIVE_INFINITY );
		assertFalse( Math.NEGATIVE_INFINITY < Math.NEGATIVE_INFINITY );
	}

	@test function testInfEqNeq() {
		// inf == inf
		assertEquals( Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY );
		assertEquals( Math.NEGATIVE_INFINITY, Math.NEGATIVE_INFINITY );
	}

	@test function testInfNaN() {
		// NaN != inf
		assertFalse( Math.isNaN( Math.POSITIVE_INFINITY ) );
		assertFalse( Math.isNaN( Math.NEGATIVE_INFINITY ) );
		assertFalse( Math.isFinite( Math.NaN ) );
		// +/-inf is NOT great/less than NaN
		assertFalse( Math.POSITIVE_INFINITY > Math.NaN ); // fails on neko
		assertFalse( Math.POSITIVE_INFINITY < Math.NaN );
		assertFalse( Math.NEGATIVE_INFINITY > Math.NaN ); // fails on neko
		assertFalse( Math.NEGATIVE_INFINITY < Math.NaN );
	}

	@test function testNaNEqNeq() {
		// NaN is NaN
		assertTrue( Math.isNaN( Math.NaN ) );
		// NaN != NaN && NaN !> NaN && NaN !< NaN
		assertDifferent( Math.NaN, Math.NaN );
		assertFalse( Math.NaN < Math.NaN );
		assertFalse( Math.NaN > Math.NaN ); // fails on neko
	}

	@test function testExceptions() {
		// sqrt( -1 ) is NaN
		assertTrue( Math.isNaN( Math.sqrt( -1. ) ) );
		// 1./0. is signed inf
		assertTrue( !Math.isFinite( 1./0. ) );
		assertEquals( Math.POSITIVE_INFINITY, 1./0. );
		assertTrue( !Math.isFinite( (-1.)/0. ) );
		assertEquals( Math.NEGATIVE_INFINITY, (-1.)/0. );
	}

	@test function testInfSumSubs() {
		// +inf +- any number is +inf
		assertEquals( Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY + 1. );
		assertEquals( Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY - 1. );
		assertEquals( Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY + Math.POSITIVE_INFINITY );
		// -inf +- any number is -inf
		assertEquals( Math.NEGATIVE_INFINITY, Math.NEGATIVE_INFINITY + 1. );
		assertEquals( Math.NEGATIVE_INFINITY, Math.NEGATIVE_INFINITY - 1. );
		assertEquals( Math.NEGATIVE_INFINITY, Math.NEGATIVE_INFINITY + Math.NEGATIVE_INFINITY );
		// +inf - (-inf) is still +inf (inf+inf)
		assertEquals( Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY - Math.NEGATIVE_INFINITY );
		// -inf - (+inf) is still -inf (-inf-inf)
		assertEquals( Math.NEGATIVE_INFINITY, Math.NEGATIVE_INFINITY - Math.POSITIVE_INFINITY );
		// +inf + (-inf) is NaN
		assertTrue( Math.isNaN( Math.POSITIVE_INFINITY + Math.NEGATIVE_INFINITY ) );
	}

}
