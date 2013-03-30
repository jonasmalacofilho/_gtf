package gtf;

import haxe.macro.Expr;

class Test {

	public dynamic function anyException() return 'any exception';
	public dynamic function noException() return 'no exception raised';

	// the test runner must replace these functions in other to get the results
	public dynamic function passed( expected:Dynamic, ?pos:haxe.PosInfos ) {}
	public dynamic function failed( expected:Dynamic, got:Dynamic, ?pos:haxe.PosInfos ) {}
	public dynamic function error( error:Dynamic, ?pos:haxe.PosInfos ) {}
	public dynamic function took( seconds:Float, ?pos:haxe.PosInfos ) {}

	// equality comparisson, may be overriden
	// default is ==, and uses values for basic types Bool, Int, String and references for everything else
	public function equals<A>( a:A, b:A )
		return a==b;

	public macro function assertEquals<A>( ethis:Expr, expected:ExprOf<A>, x:ExprOf<A> ) {
		return exec( macro {
			var _e = $expected;
			var _x = $x;
			if ( equals( _e, _x ) )
				passed( _e );
			else
				failed( _e, _x );
		} );
	}
	public macro function assertAcceptable( ethis:Expr, expected:ExprOf<Float>, tolerance:ExprOf<Float>
	  , x:ExprOf<Float> ) {
		return exec( macro {
			var _e = $expected;
			var _t = $tolerance;
			var _x = $x;
			if ( Math.abs( _e - _x ) <= _t )
				passed( _e+'+/-'+_t );
			else
				failed( _e+'+/-'+_t, _x );
		} );
	}
	public macro function assertTrue( ethis:Expr, x:ExprOf<Bool> ) {
		return exec( macro {
			var _x = $x;
			if ( equals( true, _x ) )
				passed( true );
			else
				failed( true, _x );
		} );
	}
	public macro function assertFalse( ethis:Expr, x:ExprOf<Bool> ) {
		return exec( macro {
			var _x = $x;
			if ( equals( false, _x ) )
				passed( false );
			else
				failed( false, _x );
		} );
	}
	public macro function assertRaises<A>( ethis:Expr, expected:ExprOf<A>, x:ExprOf<A> ) {
		return macro {
			var raised = false;
			var excp = null;
			var _e = try { $expected; } catch ( n:Dynamic ) { cast null; };
			try { $x; }
			catch ( n:Dynamic ) { raised = true; excp = n; }
			if ( !raised )
				failed( _e, noException() );
			else if ( !equals( _e, excp ) )
				failed( _e, excp );
			else
				passed( _e );
		};
	}
	public macro function assertThrows<A>( ethis:Expr, x:ExprOf<A> ) {
		return macro {
			var raised = false;
			try { $x; }
			catch ( n:Dynamic ) { raised = true; }
			if ( !raised )
				failed( anyException(), noException() );
			else
				passed( anyException() );
		};
	}
	public macro function time<A>( ethis:Expr, x:ExprOf<A> ) {
		return macro {
			var t = 0.;
			var k = 0;
			while ( t < .1 ) {
				k = k!=0? k*2: 1;
				t = 0.;
				for ( i in 0...2 ) {
					var t1 = haxe.Timer.stamp();
					for ( j in 0...k )
						$x;
					var t2 = haxe.Timer.stamp();
					t += t2 - t1;
				}
			}
			// trace( k*2 );
			took( t/k/2 );
		};
	}

#if macro
	public static function exec<A>( a:ExprOf<A> ) {
		return macro
			try { $a; }
			catch (e:Dynamic) { error( e ); };
	}
#end
}
