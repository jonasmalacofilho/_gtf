package gtf;

import haxe.macro.Expr;

class Test {

	public dynamic function gtf_anyException() return 'any exception';
	public dynamic function gtf_noException() return 'no exception raised';

	// the test runner must replace these functions in other to get the results
	public dynamic function gtf_passed( expected:Dynamic, ?pos:haxe.PosInfos ) {}
	public dynamic function gtf_failed( expected:Dynamic, got:Dynamic, ?pos:haxe.PosInfos ) {}
	public dynamic function gtf_error( error:Dynamic, ?pos:haxe.PosInfos ) {}
	public dynamic function gtf_took( seconds:Float, ?pos:haxe.PosInfos ) {}
	public dynamic function gtf_took_error( error:Dynamic, ?pos:haxe.PosInfos ) {}

	// equality comparisson, may be overriden
	// default is ==, and uses values for basic types Bool, Int, String and references for everything else
	public function gtf_equals<A>( a:A, b:A )
		return a==b;

	public macro function assertEquals<A>( ethis:Expr, expected:ExprOf<A>, x:ExprOf<A> ) {
		return exec( macro {
			var gtf__e = $expected;
			var gtf__x = $x;
			if ( gtf_equals( gtf__e, gtf__x ) )
				gtf_passed( gtf__e );
			else
				gtf_failed( gtf__e, gtf__x );
		} );
	}
	public macro function assertAcceptable( ethis:Expr, expected:ExprOf<Float>, tolerance:ExprOf<Float>
	  , x:ExprOf<Float> ) {
		return exec( macro {
			var gtf__e = $expected;
			var _t = $tolerance;
			var gtf__x = $x;
			if ( Math.abs( gtf__e - gtf__x ) <= _t )
				gtf_passed( gtf__e+'+/-'+_t );
			else
				gtf_failed( gtf__e+'+/-'+_t, gtf__x );
		} );
	}
	public macro function assertTrue( ethis:Expr, x:ExprOf<Bool> ) {
		return exec( macro {
			var gtf__x = $x;
			if ( gtf_equals( true, gtf__x ) )
				gtf_passed( true );
			else
				gtf_failed( true, gtf__x );
		} );
	}
	public macro function assertFalse( ethis:Expr, x:ExprOf<Bool> ) {
		return exec( macro {
			var gtf__x = $x;
			if ( gtf_equals( false, gtf__x ) )
				gtf_passed( false );
			else
				gtf_failed( false, gtf__x );
		} );
	}
	public macro function assertRaises<A>( ethis:Expr, expected:ExprOf<A>, x:ExprOf<A> ) {
		return macro {
			var gtf_raised = false;
			var gtf_excp = null;
			var gtf__e = try { $expected; } catch ( n:Dynamic ) { cast null; };
			try { $x; }
			catch ( n:Dynamic ) { gtf_raised = true; gtf_excp = n; }
			if ( !gtf_raised )
				gtf_failed( gtf__e, gtf_noException() );
			else if ( !gtf_equals( gtf__e, gtf_excp ) )
				gtf_failed( gtf__e, gtf_excp );
			else
				gtf_passed( gtf__e );
		};
	}
	public macro function assertThrows<A>( ethis:Expr, x:ExprOf<A> ) {
		return macro {
			var gtf_raised = false;
			try { $x; }
			catch ( n:Dynamic ) { gtf_raised = true; }
			if ( !gtf_raised )
				gtf_failed( gtf_anyException(), gtf_noException() );
			else
				gtf_passed( gtf_anyException() );
		};
	}
	public macro function time<A>( ethis:Expr, x:ExprOf<A> ) {
		return took_exec( macro {
			var gtf_t = 0.;
			var gtf_k = 0;
			while ( gtf_t < .1 && gtf_k <= 1000000 ) {
				gtf_k = gtf_k!=0? gtf_k*2: 1;
				gtf_t = 0.;
				for ( gtf_i in 0...2 ) {
					var gtf_t1 = haxe.Timer.stamp();
					for ( gtf_j in 0...gtf_k )
						$x;
					var gtf_t2 = haxe.Timer.stamp();
					gtf_t += gtf_t2 - gtf_t1;
				}
			}
			// trace( gtf_k*2 );
			gtf_took( gtf_t/gtf_k/2 );
		} );
	}

#if macro
	public static function exec<A>( a:ExprOf<A> ) {
		return macro
			try { $a; }
			catch (e:Dynamic) { gtf_error( e ); };
	}
	public static function took_exec<A>( a:ExprOf<A> ) {
		return macro
			try { $a; }
			catch (e:Dynamic) { gtf_took_error( e ); };	
	}
#end
}
