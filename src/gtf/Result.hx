package gtf;

class Result {
	public var assert( default, null ):Null<AssertResult>;
	// public var time( default, null ):Null<TimeResult>;
	public function new( _assert, _time ) {
		assert = _assert;
		// time = _time;
	}
}
