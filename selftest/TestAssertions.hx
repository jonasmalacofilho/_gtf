class TestAssertions extends gtf.Test {
	public function new() {}

	@test function _assertEquals() {
		assertEquals( 10, 10 );
		assertEquals( 1, 10 );
		assertEquals( 10, { throw 'An error!'; } );
	}

	@test function _assertAcceptable() {
		assertAcceptable( 11, 1, 10 );
		assertAcceptable( 11, .1, 10 );
		assertAcceptable( 10, .1, { throw 'An error!'; } );
	}

	@test function _assertTrue() {
		assertTrue( 10<=20 );
		assertTrue( 10>=20 );
		assertTrue( { throw 'An error!'; } );
	}

	@test function _assertFalse() {
		assertFalse( 10>=20 );
		assertFalse( 10<=20 );
		assertFalse( { throw 'An error!'; } );
	}

	@test function _assertThrows() {
		assertThrows( throw 'An error!' );
		assertThrows( 10 );
	}

	@test function _assertRaises() {
		assertRaises( '!', throw 'An error!' );
		assertRaises( '!', throw 'Another error#' );
		assertRaises( '!', 10 );
	}
	
}
