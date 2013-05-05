class AssertMap extends gtf.Test {

	public function new() {}

	@test public function testNullKey() {
		var x = new Map<Null<Int>,Int>();
		assertNoThrow( x.set( null, -10 ) );
		assertTrue( x.exists( null ) );
		assertEquals( -10, x.get( null ) );
		assertEquals( [-10].toString(), [ for ( y in x ) y ].toString() );
		assertNoThrow( x.set( null, -11 ) );
		assertEquals( [-11].toString(), [ for ( y in x ) y ].toString() );

		var x = new Map<Null<String>,Int>();
		assertNoThrow( x.set( null, -20 ) ); // fails on neko and java
		assertTrue( x.exists( null ) ); // raises exception on neko and java
		assertEquals( -20, x.get( null ) ); // raises exception on neko and java
		assertEquals( [-20].toString(), [ for ( y in x ) y ].toString() ); // fails on neko and java
		assertNoThrow( x.set( null, -21 ) ); // fails on neko and java
		assertEquals( [-21].toString(), [ for ( y in x ) y ].toString() ); // fails on neko and java
	}

	@test public function testNullValue() {
		var x = new Map<Int,Null<Int>>();
		assertNoThrow( x.set( -10, null ) );
		assertTrue( x.exists( -10 ) );
		assertEquals( null, x.get( -10 ) );
		assertEquals( [null].toString(), [ for ( y in x ) y ].toString() );

		var x = new Map<Int,Null<String>>();
		assertNoThrow( x.set( -20, null ) );
		assertTrue( x.exists( -20 ) );
		assertEquals( null, x.get( -20 ) );
		assertEquals( [null].toString(), [ for ( y in x ) y ].toString() );

		var x = new Map<String,Null<Int>>();
		assertNoThrow( x.set( '-30', null ) );
		assertTrue( x.exists( '-30' ) );
		assertEquals( null, x.get( '-30' ) );
		assertEquals( [null].toString(), [ for ( y in x ) y ].toString() );

		var x = new Map<String,Null<String>>();
		assertNoThrow( x.set( '-40', null ) );
		assertTrue( x.exists( '-40' ) );
		assertEquals( null, x.get( '-0' ) );
		assertEquals( [null].toString(), [ for ( y in x ) y ].toString() );
	}

}

class TimeDS extends gtf.Test {

	var a:Array<Int>;
	var l:List<Int>;
	var im:Map<Int,Int>;
	var sm:Map<String,Int>;

	public function new() {}

	@setup public function setup() {
		if ( a != null )
			return;
		a = [ for ( x in 0...1000 ) x ];
		l = new List();
		im = new Map();
		sm = new Map();
		for ( x in a ) {
			l.add( x );
			im.set( x, x );
			sm.set( Std.string( x ), x );
		}
	}

	@test public function timeIteration() {
		time( for ( x in a ) x );
		time( for ( x in l ) x );
		time( for ( x in im ) x );
		time( for ( x in sm ) x );
	}

	@test public function randomAccess() {
		var access = [ for ( x in a ) Std.random( a.length ) ];
		var saccess = [ for ( x in access ) Std.string( x ) ];
		time( for ( x in access ) a[x] );
		time( for ( x in access ) { var i = 0; for ( y in l ) if ( i++ == x ) { y; break; } } );
		time( for ( x in access ) im[x] );
		time( for ( x in saccess ) sm[x] );
	}

}
