package gtf;

@:allow( gtf.Runner )
class AssertResult {

	public var assertions( default, null ):Int;
	public var passed( default, null ):Array<{ expected:Dynamic, expr:String, pos:haxe.PosInfos }>;
	public var failed( default, null ):Array<{ expected:Dynamic, got:Dynamic, expr:String, pos:haxe.PosInfos }>;
	public var errors( default, null ):Array<{ error:Dynamic, expr:String, pos:haxe.PosInfos }>;
	
	@:allow( gtf.Runner )
	function new() {
		assertions = 0;
		passed = [];
		failed = [];
		errors = [];
	}

}
