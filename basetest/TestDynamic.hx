class AssertDynamic extends gtf.Test {
	
	public function new() {}

	public static function convert<A>( x:A ):Dynamic {
		var y:Dynamic = x;
		return y;
	}

	@test public function testComparisson() {
		// not using assertEquals because the 2 last failed assertions on hxcpp
		// cause a potencial bug there, since the gtf_equals<A> method has its A
		// parameter typed as Dynamic on that target

		// 1 conversion
		// null
		assertTrue( null == convert( null ) );
		// Bool
		assertTrue( true == convert( true ) );
		assertTrue( false == convert( false ) );
		// Int
		assertTrue( 0 == convert( 0 ) );
		// Float
		assertTrue( 0. == convert( 0. ) );
		assertTrue( 0. == convert( 0 ) );
		assertTrue( Math.isNaN( convert( Math.NaN ) ) );
		assertTrue( Math.POSITIVE_INFINITY == convert( Math.POSITIVE_INFINITY ) );
		assertTrue( Math.NEGATIVE_INFINITY == convert( Math.NEGATIVE_INFINITY ) );
		// String
		assertTrue( 'abc' == convert( 'abc' ) );

		// 2 conversions
		// null
		assertTrue( convert( null ) == convert( null ) );
		// Bool
		assertTrue( convert( true ) == convert( true ) );
		assertTrue( convert( false ) == convert( false ) );
		// Int
		assertTrue( convert( 0 ) == convert( 0 ) );
		// Float
		assertTrue( convert( 0. ) == convert( 0. ) );
		assertTrue( convert( 0. ) == convert( 0 ) );
		assertTrue( convert( Math.POSITIVE_INFINITY ) == convert( Math.POSITIVE_INFINITY ) ); // fails on Hxcpp
		assertTrue( convert( Math.NEGATIVE_INFINITY ) == convert( Math.NEGATIVE_INFINITY ) ); // fails on Hxcpp
		// String
		assertTrue( convert( 'abc' ) == convert( 'abc' ) );
	}

}