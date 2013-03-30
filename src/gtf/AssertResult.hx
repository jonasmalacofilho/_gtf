package gtf;

@:allow( gtf.Runner )
class AssertResult {
	public var assertions( default, null ):Int;
	public var passed( default, null ):Array<{ expected:Dynamic, pos:Null<haxe.PosInfos> }>;
	public var failed( default, null ):Array<{ expected:Dynamic, got:Dynamic, pos:Null<haxe.PosInfos> }>;
	public var errors( default, null ):Array<{ error:Dynamic, pos:Null<haxe.PosInfos> }>;
	public function new() {
		assertions = 0;
		passed = [];
		failed = [];
		errors = [];
	}
}
