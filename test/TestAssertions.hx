class TestAssertions extends gtf.Test {
	public function new() {}

	@test function _assertEquals() {
		assertEquals( 10, 10 );
		assertEquals( 1, 10 );
		assertEquals( 10, { throw '!'; } );
	}

	@test function _assertAcceptable() {
		assertAcceptable( 11, 1, 10 );
		assertAcceptable( 11, .1, 10 );
		assertAcceptable( 10, .1, { throw '!'; } );
	}

	@test function _assertTrue() {
		assertTrue( 10<=20 );
		assertTrue( 10>=20 );
		assertTrue( { throw '!'; } );
	}

	@test function _assertFalse() {
		assertFalse( 10>=20 );
		assertFalse( 10<=20 );
		assertFalse( { throw '!'; } );
	}

	@test function _assertThrows() {
		assertThrows( throw '!' );
		assertThrows( 10 );
	}

	@test function _assertRaises() {
		assertRaises( '!', throw '!' );
		assertRaises( '!', throw '#' );
		assertRaises( '!', 10 );
	}
	
}
