package gtf;

import haxe.macro.Expr;

class Test {

	public dynamic function gtf_anyException() return 'any exception';
	public dynamic function gtf_noException() return 'no exception raised';

	// the test runner must replace these functions in other to get the results
	public dynamic function gtf_passed( expected:Dynamic, expr:String, ?pos:haxe.PosInfos ) {}
	public dynamic function gtf_failed( expected:Dynamic, got:Dynamic, expr:String, ?pos:haxe.PosInfos ) {}
	public dynamic function gtf_error( error:Dynamic, expr:String, ?pos:haxe.PosInfos ) {}
	public dynamic function gtf_took( seconds:Float, expr:String, ?pos:haxe.PosInfos ) {}
	public dynamic function gtf_took_error( error:Dynamic, expr:String, ?pos:haxe.PosInfos ) {}

	// equality comparisson, may be overriden
	// default is ==, and uses values for basic types Bool, Int, String and references for everything else
	// if not inlined causes Math.POSITIVE_INFINITY!=Math.POSITIVE_INFINITY on Hxcpp and Linux
	public inline function gtf_equals<A>( a:A, b:A )
		return a==b;

	public macro function assertEquals<A>( ethis:Expr, expected:ExprOf<A>, x:ExprOf<A> ) {
		var expr = haxe.macro.Context.makeExpr( haxe.macro.ExprTools.toString( x ), x.pos );
		return exec( macro {
			var gtf__e = $expected;
			var gtf__x = $x;
			if ( gtf_equals( gtf__e, gtf__x ) )
				gtf_passed( gtf__e, $expr );
			else
				gtf_failed( gtf__e, gtf__x, $expr );
		}, expr );
	}
	public macro function assertDifferent<A>( ethis:Expr, expected:ExprOf<A>, x:ExprOf<A> ) {
		var expr = haxe.macro.Context.makeExpr( haxe.macro.ExprTools.toString( x ), x.pos );
		return exec( macro {
			var gtf__e = $expected;
			var gtf__x = $x;
			if ( !gtf_equals( gtf__e, gtf__x ) )
				gtf_passed( gtf__e, $expr );
			else
				gtf_failed( gtf__e, gtf__x, $expr );
		}, expr );
	}
	public macro function assertAcceptable( ethis:Expr, expected:ExprOf<Float>, tolerance:ExprOf<Float>
	  , x:ExprOf<Float> ) {
	  	var expr = haxe.macro.Context.makeExpr( haxe.macro.ExprTools.toString( x ), x.pos );
		return exec( macro {
			var gtf__e = $expected;
			var _t = $tolerance;
			var gtf__x = $x;
			if ( Math.abs( gtf__e - gtf__x ) <= _t )
				gtf_passed( gtf__e+'+/-'+_t, $expr );
			else
				gtf_failed( gtf__e+'+/-'+_t, gtf__x, $expr );
		}, expr );
	}
	public macro function assertTrue( ethis:Expr, x:ExprOf<Bool> ) {
		var expr = haxe.macro.Context.makeExpr( haxe.macro.ExprTools.toString( x ), x.pos );
		return exec( macro {
			var gtf__x = $x;
			if ( gtf_equals( true, gtf__x ) )
				gtf_passed( true, $expr );
			else
				gtf_failed( true, gtf__x, $expr );
		}, expr );
	}
	public macro function assertFalse( ethis:Expr, x:ExprOf<Bool> ) {
		var expr = haxe.macro.Context.makeExpr( haxe.macro.ExprTools.toString( x ), x.pos );
		return exec( macro {
			var gtf__x = $x;
			if ( gtf_equals( false, gtf__x ) )
				gtf_passed( false, $expr );
			else
				gtf_failed( false, gtf__x, $expr );
		}, expr );
	}
	public macro function assertRaises<A>( ethis:Expr, expected:ExprOf<A>, x:ExprOf<A> ) {
		var expr = haxe.macro.Context.makeExpr( haxe.macro.ExprTools.toString( x ), x.pos );
		return macro {
			var gtf_raised = false;
			var gtf_excp = null;
			var gtf__e = try { $expected; } catch ( n:Dynamic ) { cast null; };
			try { $x; }
			catch ( n:Dynamic ) { gtf_raised = true; gtf_excp = n; }
			if ( !gtf_raised )
				gtf_failed( gtf__e, gtf_noException(), $expr );
			else if ( !gtf_equals( gtf__e, gtf_excp ) )
				gtf_failed( gtf__e, gtf_excp, $expr );
			else
				gtf_passed( gtf__e, $expr );
		};
	}
	public macro function assertThrows<A>( ethis:Expr, x:ExprOf<A> ) {
		var expr = haxe.macro.Context.makeExpr( haxe.macro.ExprTools.toString( x ), x.pos );
		return macro {
			var gtf_raised = false;
			try { $x; }
			catch ( n:Dynamic ) { gtf_raised = true; }
			if ( !gtf_raised )
				gtf_failed( gtf_anyException(), gtf_noException(), $expr );
			else
				gtf_passed( gtf_anyException(), $expr );
		};
	}
	public macro function time<A>( ethis:Expr, x:ExprOf<A> ) {
		var expr = haxe.macro.Context.makeExpr( haxe.macro.ExprTools.toString( x ), x.pos );
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
			gtf_took( gtf_t/gtf_k/2, $expr );
		}, expr );
	}

#if macro
	public static function exec<A>( a:ExprOf<A>, expr:ExprOf<String> ) {
		return macro
			try { $a; }
			catch (e:Dynamic) { gtf_error( e, $expr ); };
	}
	public static function took_exec<A>( a:ExprOf<A>, expr:ExprOf<String> ) {
		return macro
			try { $a; }
			catch (e:Dynamic) { gtf_took_error( e, $expr ); };
	}
#end
}
