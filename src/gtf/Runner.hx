package gtf;

class Runner {

	var suites:Array<Test>;

	public function new( _suites:Iterable<Test> ) {
		suites = Lambda.array( _suites );
	}

	public function run() {
		var ares = new AssertResult();
		var tres = new TimingResult();

		for ( suite in suites ) {

			// ...
			var cl;
			switch ( Type.typeof( suite ) ) {
				case TClass( c ): cl = c;
				case _: throw Type.typeof( suite ); null;
			}
			// trace( Type.getClassName( cl ) );

			suite.gtf_passed = function ( e, expr, ?p ) {
				ares.assertions++;
				ares.passed.push( { expected:e, expr:expr, pos:p } );
				// haxe.Log.trace( 'passed $e', p );
			}
			suite.gtf_failed = function ( e, g, expr, ?p ) {
				ares.assertions++;
				ares.failed.push( { expected:e, got:g, expr:expr, pos:p } );
				// haxe.Log.trace( '\x1b[1mFAILED\x1b[0m $e, got $g', p );
			}
			suite.gtf_error = function ( e, expr, ?p ) {
				ares.assertions++;
				ares.errors.push( { error:e, expr:expr, pos:p } );
				// haxe.Log.trace( '\x1b[1;4mERROR\x1b[0m $e', p );
			}
			suite.gtf_took = function ( s, expr, ?p ) {
				tres.tests++;
				tres.results.push( { seconds:s, expr:expr, pos:p } );
				// haxe.Log.trace( 'took ${1e-3*s} ms', p );
			}
			suite.gtf_took_error = function ( e, expr, ?p ) {
				tres.tests++;
				tres.errors.push( { error:e, expr:expr, pos:p } );
				// haxe.Log.trace( '\x1b[1;4mERROR\x1b[0m $e', p );
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

		return new Result( ares, tres );
	}

}
