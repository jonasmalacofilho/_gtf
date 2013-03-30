class TestAssertions extends gtf.Assert {
	public function new() {}

	@assert @time function _assertEquals() {
		assertEquals( 10, 10 );
		assertEquals( 1, 10 );
		assertEquals( 10, { throw '!'; } );
	}

	@assert @time function _assertAcceptable() {
		assertAcceptable( 11, 1, 10 );
		assertAcceptable( 11, .1, 10 );
		assertAcceptable( 10, .1, { throw '!'; } );
	}

	@assert @time function _assertTrue() {
		assertTrue( 10<=20 );
		assertTrue( 10>=20 );
		assertTrue( { throw '!'; } );
	}

	@assert @time function _assertFalse() {
		assertFalse( 10>=20 );
		assertFalse( 10<=20 );
		assertFalse( { throw '!'; } );
	}

	@assert @time function _assertThrows() {
		assertThrows( throw '!' );
		assertThrows( 10 );
	}

	@assert @time function _assertRaises() {
		assertRaises( '!', throw '!' );
		assertRaises( '!', throw '#' );
		assertRaises( '!', 10 );
	}
	
}

