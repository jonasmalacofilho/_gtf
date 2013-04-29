class ChooseVector2 extends gtf.Test {

	public function new() {}

	inline function vs( _x:Float, _y:Float ) return new Vector2Structure( _x, _y );
	inline function vc( _x:Float, _y:Float ) return new Vector2Class( _x, _y );
	// inline function ve( _x:Float, _y:Float ) return _Vector2Enum( _x, _y );
	inline function va( _x:Float, _y:Float ) return new Vector2Array( _x, _y );

	@test public function testProperties() {
		var v1 = vs( 1., 2. ); assertEquals( 1., v1.x ); assertEquals( 2., v1.y ); v1 = null;
		var v2 = vc( 1., 2. ); assertEquals( 1., v2.x ); assertEquals( 2., v2.y ); v2 = null;
		// var v3 = ve( 1., 2. ); assertEquals( 1., v3.x ); assertEquals( 2., v3.y ); v3 = null;
		var v4 = va( 1., 2. ); assertEquals( 1., v4.x ); assertEquals( 2., v4.y ); v4 = null;
	}

	@test public function timeBuild() {
		time( vs( 1., 2. ) );
		time( vc( 1., 2. ) );
		// time( ve( 1., 2. ) );
		time( va( 1., 2. ) );
	}

}

class ChooseVector3 extends gtf.Test {

	public function new() {}

	inline function vs( _x:Float, _y:Float, _z:Float ) return new Vector3Structure( _x, _y, _z );
	inline function vc( _x:Float, _y:Float, _z:Float ) return new Vector3Class( _x, _y, _z );
	// inline function ve( _x:Float, _y:Float, _z:Float ) return _Vector3Enum( _x, _y, _z );
	inline function va( _x:Float, _y:Float, _z:Float ) return new Vector3Array( _x, _y, _z );

	@test public function testProperties() {
		var v1 = vs( 1., 2., 3. ); assertEquals( 1., v1.x ); assertEquals( 2., v1.y ); assertEquals( 3., v1.z ); v1 = null;
		var v2 = vc( 1., 2., 3. ); assertEquals( 1., v2.x ); assertEquals( 2., v2.y ); assertEquals( 3., v2.z ); v2 = null;
		// var v3 = ve( 1., 2., 3. ); assertEquals( 1., v3.x ); assertEquals( 2., v3.y ); assertEquals( 3., v3.z ); v3 = null;
		var v4 = va( 1., 2., 3. ); assertEquals( 1., v4.x ); assertEquals( 2., v4.y ); assertEquals( 3., v4.z ); v4 = null;
	}

	@test public function timeBuild() {
		time( vs( 1., 2., 3. ) );
		time( vc( 1., 2., 3. ) );
		// time( ve( 1., 2., 3. ) );
		time( va( 1., 2., 3. ) );
	}

}

// Structure implementation proposal

private typedef _Vector2Structure = { x:Float, y:Float }

private typedef _Vector3Structure = { >_Vector2Structure, z:Float }

private abstract Vector2Structure( _Vector2Structure ) {
	public inline function new( _x:Float, _y:Float )
		this = { x:_x, y:_y };
	public var x( get, set ):Float;
	public var y( get, set ):Float;

	inline function get_x() return this.x;
	inline function set_x(_x) return this.x = _x;
	inline function get_y() return this.y;
	inline function set_y(_y) return this.y = _y;
}

private abstract Vector3Structure( _Vector3Structure ) {
	public inline function new( _x:Float, _y:Float, _z:Float )
		this = { x:_x, y:_y, z:_z };
	public var x( get, set ):Float;
	public var y( get, set ):Float;
	public var z( get, set ):Float;

	inline function get_x() return this.x;
	inline function set_x(_x) return this.x = _x;
	inline function get_y() return this.y;
	inline function set_y(_y) return this.y = _y;
	inline function get_z() return this.z;
	inline function set_z(_z) return this.z = _z;
}

// Class implementation proposal

private class _Vector2Class {
	public var x:Float;
	public var y:Float;
	public inline function new( _x:Float, _y:Float ) {
		x = _x; y = _y;
	}
}

private class _Vector3Class extends _Vector2Class {
	public var z:Float;
	public inline function new( _x:Float, _y:Float, _z:Float ) {
		super( _x, _y );
		z = _z;
	}
}

private abstract Vector2Class( _Vector2Class ) {
	public inline function new( _x:Float, _y:Float )
		this = new _Vector2Class( _x, _y );
	public var x( get, set ):Float;
	public var y( get, set ):Float;

	inline function get_x() return this.x;
	inline function set_x(_x) return this.x = _x;
	inline function get_y() return this.y;
	inline function set_y(_y) return this.y = _y;
}

private abstract Vector3Class( _Vector3Class ) {
	public inline function new( _x:Float, _y:Float, _z:Float )
		this = new _Vector3Class( _x, _y, _z );
	public var x( get, set ):Float;
	public var y( get, set ):Float;
	public var z( get, set ):Float;

	inline function get_x() return this.x;
	inline function set_x(_x) return this.x = _x;
	inline function get_y() return this.y;
	inline function set_y(_y) return this.y = _y;
	inline function get_z() return this.z;
	inline function set_z(_z) return this.z = _z;
}

// Enum implementation proposal

// private enum _VectorEnum {
// 	_Vector2Enum( x:Float, y:Float );
// 	_Vector3Enum( x:Float, y:Float, z:Float );
// }

// private abstract Vector2Enum( _VectorEnum ) {
// 	public inline function new( _x:Float, _y:Float )
// 		this = _Vector2Enum( _x, _y );
// 	public var x( get, set ):Float;
// 	public var y( get, set ):Float;

// 	inline function get_x() return switch ( this ) {
// 		case _Vector2Enum(cx,_): cx;
// 		case _: Math.NaN;
// 	};
// 	inline function set_x(_x) return switch ( this ) {
// 		case _Vector2Enum(_,cy): this = _Vector2Enum( _x, cy ); _x;
// 		case _: Math.NaN;
// 	};
// 	inline function get_y() return switch ( this ) {
// 		case _Vector2Enum(_,cy): cy;
// 		case _: Math.NaN;
// 	};
// 	inline function set_y(_y) return switch ( this ) {
// 		case _Vector2Enum(cx,_): this = _Vector2Enum( cx, _y ); _y;
// 		case _: Math.NaN;
// 	};
// }

// private abstract Vector3Enum( _VectorEnum ) {
// 	public inline function new( _x:Float, _y:Float, _z:Float )
// 		this = _Vector3Enum( _x, _y, _z );
// 	public var x( get, set ):Float;
// 	public var y( get, set ):Float;
// 	public var z( get, set ):Float;

// 	inline function get_x() return switch ( this ) {
// 		case _Vector3Enum(cx,_): cx;
// 		case _: Math.NaN;
// 	};
// 	inline function set_x(_x) return switch ( this ) {
// 		case _Vector3Enum(_,cy,cz): this = _Vector3Enum( _x, cy, cz ); _x;
// 		case _: Math.NaN;
// 	};
// 	inline function get_y() return switch ( this ) {
// 		case _Vector3Enum(_,cy,_): cy;
// 		case _: Math.NaN;
// 	};
// 	inline function set_y(_y) return switch ( this ) {
// 		case _Vector3Enum(cx,_,cz): this = _Vector3Enum( cx, _y, cz ); _y;
// 		case _: Math.NaN;
// 	};
// 	inline function get_z() return switch ( this ) {
// 		case _Vector3Enum(_,_,cz): cz;
// 		case _: Math.NaN;
// 	};
// 	inline function set_z(_z) return switch ( this ) {
// 		case _Vector3Enum(cx,cy,_): this = _Vector3Enum( cx, cy, _z ); _z;
// 		case _: Math.NaN;
// 	};
// }

// Array implementation proposal

private abstract Vector2Array( Array<Float> ) {
	public inline function new( _x:Float, _y:Float )
		this = [ _x, _y ];
	public var x( get, set ):Float;
	public var y( get, set ):Float;

	inline function get_x() return this[0];
	inline function set_x(_x) return this[0] = _x;
	inline function get_y() return this[1];
	inline function set_y(_y) return this[1] = _y;
}

private abstract Vector3Array( Array<Float> ) {
	public inline function new( _x:Float, _y:Float, _z:Float )
		this = [ _x, _y, _z ];
	public var x( get, set ):Float;
	public var y( get, set ):Float;
	public var z( get, set ):Float;

	inline function get_x() return this[0];
	inline function set_x(_x) return this[0] = _x;
	inline function get_y() return this[1];
	inline function set_y(_y) return this[1] = _y;
	inline function get_z() return this[2];
	inline function set_z(_z) return this[2] = _z;
}
