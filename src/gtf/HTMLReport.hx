package gtf;

class HTMLReport {
	
	var t:haxe.Template;

	public function new( _template:String ) {
		t = new haxe.Template( _template );
	}

	public function execute( title:String, results:Result, ?intro:String, ?conclusion:String ):String {
		return t.execute( { title:title, assertResults:results.assert, timingResults:results.timing, intro:intro, conclusion:conclusion } );
	}

}
