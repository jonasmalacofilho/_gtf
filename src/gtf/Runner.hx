package gtf;

class Runner {
	
	var suites:Array<Test>;

	public function new( _suites:Iterable<Test> ) {
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
				case _: throw Type.typeof( suite ); null;
			}
			// trace( Type.getClassName( cl ) );

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
			suite.took = function ( s, ?p ) {
				trace( '${p.className}:${p.methodName}:${p.lineNumber}  took ${1e3*s} ms', p );
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
				if ( Reflect.isFunction( x ) && ( hasMeta( f, 'test' ) ) ) {
					for ( s in setup )
						Reflect.callMethod( suite, s, [] );

					Reflect.callMethod( suite, x, [] );
					
					for ( t in teardown )
						Reflect.callMethod( suite, t, [] );
				}
			}

		}

		return new Result( ares, null );
	}

}
