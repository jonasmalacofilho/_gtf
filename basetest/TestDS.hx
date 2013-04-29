class AssertMap extends gtf.Test {

	public function new() {}

	@test public function testNullKey() {
		var x = new Map<Null<Int>,Int>();
		try { x.set( null, -10 ); } catch( e:Dynamic ) { trace( e ); }
		assertTrue( x.exists( null ) );
		assertEquals( -10, x.get( null ) );
		assertEquals( [-10].toString(), [ for ( y in x ) y ].toString() );
		try { x.set( null, -11 ); } catch( e:Dynamic ) { trace( e ); }
		assertEquals( [-11].toString(), [ for ( y in x ) y ].toString() );

		var x = new Map<Null<String>,Int>();
		try { x.set( null, -10 ); } catch( e:Dynamic ) { trace( e ); } // raises exception on neko
		assertTrue( x.exists( null ) );
		assertEquals( -10, x.get( null ) );
		assertEquals( [-10].toString(), [ for ( y in x ) y ].toString() );
		try { x.set( null, -11 ); } catch( e:Dynamic ) { trace( e ); } // raises exception on neko
		assertEquals( [-11].toString(), [ for ( y in x ) y ].toString() );
	}

	@test public function testNullValue() {
		var x = new Map<Int,Null<Int>>();
		try { x.set( -10, null ); } catch( e:Dynamic ) { trace( e ); }
		assertTrue( x.exists( -10 ) );
		assertEquals( null, x.get( -10 ) );
		assertEquals( [null].toString(), [ for ( y in x ) y ].toString() );

		var x = new Map<Int,Null<String>>();
		try { x.set( -10, null ); } catch( e:Dynamic ) { trace( e ); }
		assertTrue( x.exists( -10 ) );
		assertEquals( null, x.get( -10 ) );
		assertEquals( [null].toString(), [ for ( y in x ) y ].toString() );

		var x = new Map<String,Null<Int>>();
		try { x.set( '-10', null ); } catch( e:Dynamic ) { trace( e ); }
		assertTrue( x.exists( '-10' ) );
		assertEquals( null, x.get( '-10' ) );
		assertEquals( [null].toString(), [ for ( y in x ) y ].toString() );

		var x = new Map<String,Null<String>>();
		try { x.set( '-10', null ); } catch( e:Dynamic ) { trace( e ); }
		assertTrue( x.exists( '-10' ) );
		assertEquals( null, x.get( '-10' ) );
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
