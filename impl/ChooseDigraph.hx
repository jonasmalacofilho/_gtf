@:generic
class MyVertex implements Vertex {
	public var i( default, null ):Int;
	public var name:String;
	public function new( _name ) name = _name;
}

@:generic
class MyArc implements Arc {
	public var r( default, null ):Int;
	public function new() {}
}

class ChooseDigraph extends gtf.Test {

	public function new() {}

	@:access( AdjListDigraph )
	@test public function testAdjList() {
		var d = new AdjListDigraph<MyVertex,MyArc>();
		d.quickArcAddition = false;

		var vs = [ for (x in 0...5) d.addVertex(new MyVertex('Vertex $x')) ];
		// for ( v in vs ) assertEquals( v, d.vs[v.i].v );
		assertEquals( [ for (v in vs) v.i ].toString(), [ for (v in d.v()) v.i ].toString() );
		time( for (v in d.v()) v );

		var as = [ for (v in vs) for (w in vs) if (v!=w) d.addArc(v,w,new MyArc()) ];
		// for ( a in as ) assertEquals( a, d.as[a.r].a );
		assertEquals( [ for (a in as) a.r ].toString(), [ for (a in d.a()) a.r ].toString() );
		time( for (a in d.a()) a );
	}

}

// has to work with @:generic for additional performance improvements over jonas-haxe
// must allow for both self-loops and multi-digraphs

// and a common interface between implementation types would be nice
interface Vertex {
	public var i( default, null ):Int; // should only be written by a Digraph implementation using the @:access metadata
}

interface Arc {
	public var r( default, null ):Int; // should only be written by a Digraph implementation using the @:access metadata
}

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
	public function v( ?s:A, ?f:A ):Iterator<V>;
	public function a( ?v:V, ?w:V ):Iterator<A>;
}

// adjacency collections (lists/arrays) implementation

@:generic
private class AdjListNode<V:Vertex,A:Arc> {
	public var a:A;
	public var adjNext:AdjListNode<V,A>;
	public inline function new( _a, _adjNext ) {
		a = _a;
		adjNext = _adjNext;
	}
}

@:generic
private class VertexInfos<V:Vertex,A:Arc> {
	public var v:V;
	public var adjHead:AdjListNode<V,A>;
	public inline function new( _v, _adjHead ) {
		v = _v;
		adjHead = _adjHead;
	}
}

@:generic
private class ArcInfos<V:Vertex,A:Arc> {
	public var v:V;
	public var w:V;
	public var a:A;
	public inline function new( _v, _w, _a ) {
		v = _v;
		w = _w;
		a = _a;
	}
}

@:generic
@:access( Vertex.i )
@:access( Arc.r )
class AdjListDigraph<V:Vertex,A:Arc> implements Digraph<V,A> {

	public var quickArcAddition:Bool;

	var vs:Array<VertexInfos<V,A>>;
	var as:Array<ArcInfos<V,A>>;

	public function new() {
		quickArcAddition = false;

		vs = [];
		as = [];
	}

	// simple updates
	public function addVertex( v:V ):Null<V> {
		v.i = vs.length;
		vs[v.i] = new VertexInfos<V,A>( v, null );
		return v;
	}
	public function addArc( v:V, w:V, a:A ):Null<A> {
		a.r = as.length;
		as[a.r] = new ArcInfos<V,A>( v, w, a );
		if ( vs[v.i].adjHead == null || quickArcAddition ) {
			// arc goes to the head of the adj list
			vs[v.i].adjHead = new AdjListNode<V,A>( a, vs[v.i].adjHead );
		}
		else {
			// arc goes to the tail end of the adj list
			var p = vs[v.i].adjHead;
			while ( p.adjNext != null )
				p = p.adjNext;
			p.adjNext = new AdjListNode<V,A>( a, null );
		}
		return a;
	}

	// simple queries by id
	public function hasVertex( i:Int ):Bool { return false; }
	public function hasArc( r:Int ):Bool { return false; }
	public function getVertex( i:Int ):Null<V> { return null; }
	public function getArc( r:Int ):Null<A> { return null; }

	// consistency checks
	public function vertexBelongs( v:V ):Bool { return false; }
	public function arcBelongs( a:A ):Bool { return false; }

	// iterators/iterables and queries by objects
	public function v( ?s:A, ?f:A ):Iterator<V> return new AdjListVertexIterator<V,A>( this, s, f );
	public function a( ?v:V, ?w:V ):Iterator<A> return new AdjListArcIterator<V,A>( this, v, w );
}

@:generic
@:access( AdjListDigraph )
private class AdjListVertexIterator<V:Vertex,A:Arc> {

	// input settings
	var d:AdjListDigraph<V,A>;
	var s:A;
	var f:A;

	// cached next value
	// if null, there is no next value
	// else, it is the next value
	var cache:V;

	public inline function new( _d:AdjListDigraph<V,A>, ?_s:A, ?_f:A ) {
		d = _d;
		s = _s;
		f = _f;
		cache = null;
		tryNext();
	}

	public inline function hasNext():Bool {
		return cache != null;
	}

	public inline function next():V {
		var val = cache;
		if ( val != null ) tryNext();
		return val;
	}

	inline function tryNext() {
		throw 'TODO';
	}

}

@:generic
@:access( AdjListDigraph )
private class AdjListArcIterator<V:Vertex,A:Arc> {

	// input settings
	var d:AdjListDigraph<V,A>;
	var v:V;
	var w:V;

	// current position
	var pos:Int; // if running on ArcInfos
	var p:AdjListNode<V,A>; // if running on VertexInfos (AdjList)

	// cached next value
	// if null, there is no next value
	// else, it is the next value
	var cache:A;

	public inline function new( _d:AdjListDigraph<V,A>, ?_v:V, ?_w:V ) {
		d = _d;
		v = _v;
		w = _w;
		pos = 0;
		p = null;
		cache = null;
		tryNext();
	}

	public inline function hasNext():Bool {
		return cache != null;
	}

	public inline function next():A {
		var val = cache;
		if ( val != null ) tryNext();
		return val;
	}

	inline function tryNext() {
		if ( v != null )
			if ( w != null ) { // query is arcs between v and w
				// p stores the current list node
				// if null, begin at list head
				if ( p == null )
					p = d.vs[v.i].adjHead;
				// while there is p, check if p.a has w as destionation
				// at each iteration update p with the next list node
				while ( p != null ) {
					if ( d.as[p.a.r].w == w )
						cache = p.a;
					p = p.adjNext;
				}
			}
			else { // query is arcs from v
				// p stores the previous list node
				// if there is p, go to the next list node, if it exists, the current arc is p.a
				// if the previous list node was null, begin at list head
				if ( p != null ) {
					p = p.adjNext;
					if ( p != null )
						cache = p.a;
				}
				else {
					p = d.vs[v.i].adjHead;
					cache = p.a;
				}
			}
		else
			if ( w != null ) { // query is arcs to w
				throw 'TODO';
			}
			else { // query is all arcs
				cache = pos<d.as.length? d.as[pos++].a: null;
			}
	}
	
}

// adjacency matrix implementation

// arc collection (list/array) implementation


