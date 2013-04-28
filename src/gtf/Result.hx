package gtf;

class Result {
	
	public var assert( default, null ):AssertResult;
	public var timing( default, null ):TimingResult;

	@:allow( gtf.Runner )
	function new( _assert, _time ) {
		assert = _assert;
		timing = _time;
	}

}
