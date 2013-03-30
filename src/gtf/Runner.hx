package gtf;

class Runner {
	
	var suites:Array<Dynamic>;

	public function new( _suites:Iterable<Dynamic> ) {
		suites = Lambda.array( _suites );
	}

	public function run() {
		var ares = new AssertResult();
		// var tres = new TimerResult();

		for ( suite in suites ) {

			// ...
			var cl;
			switch ( Type.typeof( suite ) ) {
				case TClass( c ): cl = c;
				case _: throw 'Runner only accepts class intances';
			}
			// trace( Type.getClassName( cl ) );

			// if it extends gtf.Assert, configure it
			if ( Std.is( suite, Assert ) ) {
				suite.passed = function ( e, ?p ) {
					ares.assertions++;
					ares.passed.push( { expected:e, pos:p } );
					// trace( '${p.className}:${p.methodName}:${p.lineNumber}  passed $e' );
				}
				suite.failed = function ( e, g, ?p ) {
					ares.assertions++;
					ares.failed.push( { expected:e, got:g, pos:p } );
					// trace( '${p.className}:${p.methodName}:${p.lineNumber}  FAILED $e, got $g', p );
				}
				suite.error = function ( e, ?p ) {
					ares.assertions++;
					ares.errors.push( { error:e, pos:p } );
					// trace( '${p.className}:${p.methodName}:${p.lineNumber}  ERROR $e', p );
				}
			}

			// metadata and fields
			var meta = haxe.rtti.Meta.getFields( cl );
			var hasMeta = function ( f, m )
				return Reflect.hasField( Reflect.field( meta, f ), m );
			var fields = Type.getInstanceFields( cl );
			fields.sort( Reflect.compare );

			// methods
			var setup:Array<Dynamic> = [];
			var teardown:Array<Dynamic> = [];
			for ( f in fields ) {
				// trace( f );
				var x = Reflect.field( suite, f );
				if ( Reflect.isFunction( x ) ) {
					if ( hasMeta( f, 'setup' ) )
						setup.push( x );
					if ( hasMeta( f, 'teardown' ) )
						teardown.push( x );
				}
			}

			// run
			for ( f in fields ) {
				// trace( f );
				var x = Reflect.field( suite, f );
				if ( Reflect.isFunction( x ) && ( hasMeta( f, 'assert' ) || hasMeta( f, 'time' ) ) ) {
					for ( s in setup )
						Reflect.callMethod( suite, s, [] );

					var t0 = haxe.Timer.stamp();
					Reflect.callMethod( suite, x, [] );
					var t1 = haxe.Timer.stamp();
					
					for ( t in teardown )
						Reflect.callMethod( suite, t, [] );
					
					// if ( hasMeta( f, 'time' ) )
					// 	tres...
				}
			}

		}

		return new Result( ares, null );
	}

}
