@:generic
private
class MyVertex implements Vertex {
	public var i( default, never ):Int;
	public var name:String;
}

@:generic
private
class MyArc implements Arc {
	public var r( default, never ):Int;
}

class ChooseDigraph extends gtf.Test {

	public function new() {}

	@test public function testAdjList() {
		assertNoThrow( var d = new AdjListDigraph<MyVertex,MyArc>() );
	}

}

// has to work with @:generic for additional performance improvements over jonas-haxe
// must allow for both self-loops and multi-digraphs

// and a common interface between implementation types would be nice
private
interface Vertex {
	@:allow( Digraph )
	public var i( default, never ):Int;
}

private
interface Arc {
	@:allow( Digraph )
	public var r( default, never ):Int;
}

private
interface Digraph<V:Vertex,A:Arc> {
	// simple updates
	public function addVertex( v:V ):Null<V>;
	public function addArc( v:V, w:V, a:A ):Null<A>;

	// simple queries by id
	public function hasVertex( i:Int ):Bool;
	public function hasArc( r:Int ):Bool;
	public function getVertex( i:Int ):V;
	public function getArc( r:Int ):A;

	// consistency checks
	public function vertexBelongs( v:V ):Bool;
	public function arcBelongs( a:A ):Bool;

	// iterators/iterables and queries by objects
	public function v( ?s:A, ?f:A ):Iterable<V>;
	public function a( ?v:V, w:V ):Iterable<V>;
}

// adjacency collections (lists/arrays) implementation

@:generic
private
class AdjListNode<V:Vertex,A:Arc> {
	public var a:A;
	public var adjNext:AdjListNode<V,A>;
}

@:generic
private
class VertexInfos<V:Vertex,A:Arc> {
	public var v:V;
	public var adjHead:AdjListNode<V,A>;
}

@:generic
private
class ArcInfos<V:Vertex,A:Arc> {
	public var v:V;
	public var w:V;
	public var a:A;
}

@:generic
private
class AdjListDigraph<V:Vertex,A:Arc> implements Digraph<V,A> {
	var vs:Array<VertexInfos<V,A>>;
	var as:Array<ArcInfos<V,A>>;

	public function new() {
		vs = [];
		as = [];
	}

	// simple updates
	public function addVertex( v:V ):Null<V> { return null; }
	public function addArc( v:V, w:V, a:A ):Null<A> { return null; }

	// simple queries by id
	public function hasVertex( i:Int ):Bool { return false; }
	public function hasArc( r:Int ):Bool { return false; }
	public function getVertex( i:Int ):Null<V> { return null; }
	public function getArc( r:Int ):Null<A> { return null; }

	// consistency checks
	public function vertexBelongs( v:V ):Bool { return false; }
	public function arcBelongs( a:A ):Bool { return false; }

	// iterators/iterables and queries by objects
	public function v( ?s:A, ?f:A ):Iterable<V> { return []; }
	public function a( ?v:V, w:V ):Iterable<V> { return []; }
}

// adjacency matrix implementation

// arc collection (list/array) implementation


