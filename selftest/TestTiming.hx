class TestTiming extends gtf.Test {
	public function new() {}

	@test public function testMath() {
		time( Math.abs( 1. ) );
		time( Math.random() );
		time( Math.isFinite( 1. ) );
		time( Math.isNaN( 1. ) );
	}

	@test public function testComparisson() {
		time( 2 <= 2 );
		time( 1 < 2 );
		time( 1 == 1 );
		time( true );
		time( !true );
		time( false );
		time( !false );
	}

	@test public function testArray() {
		time( {
			var x = [];
			for ( i in 0...1000 )
				arrayAddHead( x, i );
			for ( i in 0...1000 )
				arrayRemoveHead( x );
			for ( i in 0...1000 )
				arrayAddTailEnd( x, i );
			for ( i in 0...1000 )
				arrayRemoveTailEnd( x );
		} );
	}

	@test public function testList() {
		time( {
			var x = new List();
			for ( i in 0...1000 )
				listAddHead( x, i );
			for ( i in 0...1000 )
				listRemoveHead( x );
			for ( i in 0...1000 )
				listAddTailEnd( x, i );
			for ( i in 0...1000 )
				listRemoveTailEnd( x );
		} );
	}

	static inline function arrayAddHead<A>( a:Array<A>, x:A ) {
		for ( i in 0...a.length )
			a[i+1] = a[i];
		a[0] = x;
	}
	static inline function arrayRemoveHead<A>( a:Array<A> ) {
		for ( i in 1...a.length )
			a[i-1] = a[i];
		a.pop();
	}
	static inline function arrayAddTailEnd<A>( a:Array<A>, x:A )
		a.push( x );
	static inline function arrayRemoveTailEnd<A>( a:Array<A> )
		a.pop();

	static inline function listAddHead<A>( a:List<A>, x:A )
		a.push( x );
	static inline function listRemoveHead<A>( a:List<A> )
		a.pop();
	static inline function listAddTailEnd<A>( a:List<A>, x:A )
		a.add( x );
	static inline function listRemoveTailEnd<A>( a:List<A> ) {
		var t = Lambda.array( a );
		a.clear();
		for ( i in 0...t.length-1 )
			a.add( t[i] );
	}
	
}
