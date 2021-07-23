package;

import haxe.Timer;
import haxe.Unserializer;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Loader;
import openfl.events.Event;
import openfl.media.Sound;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.text.Font;
import openfl.utils.ByteArray;

class DefaultAssetLibrary extends openfl.AssetLibrary {
	public var className(default, null) = new Map<String, Dynamic>();
	public var path(default, null) = new Map<String, String>();
	public var type(default, null) = new Map<String, AssetType>();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	public function new() {
		super();
		// register assets:
		add("assets/data/data-goes-here.txt", TEXT);
		add("assets/fonts/Commodore.eot", TEXT);
		add("assets/fonts/Commodore.ttf", FONT);
		add("assets/fonts/Square.eot", BINARY);
		add("assets/fonts/Square.svg", TEXT);
		add("assets/fonts/Square.ttf", FONT);
		add("assets/fonts/Square.woff", BINARY);
		add("assets/images/0_Instructions/instructions_arrow_key.png", IMAGE);
		add("assets/images/0_Instructions/instructions_space_bar.png", IMAGE);
		add("assets/images/10_Final/final_jack.png", IMAGE);
		add("assets/images/1_Drive/b_l_road.png", IMAGE);
		add("assets/images/1_Drive/b_r_road.png", IMAGE);
		add("assets/images/1_Drive/b_u_road.png", IMAGE);
		add("assets/images/1_Drive/car.png", IMAGE);
		add("assets/images/1_Drive/end_bg.png", IMAGE);
		add("assets/images/1_Drive/end_road.png", IMAGE);
		add("assets/images/1_Drive/l_u_road.png", IMAGE);
		add("assets/images/1_Drive/lake_bottom.png", IMAGE);
		add("assets/images/1_Drive/lake_bottom_left.png", IMAGE);
		add("assets/images/1_Drive/lake_left.png", IMAGE);
		add("assets/images/1_Drive/r_l_road.png", IMAGE);
		add("assets/images/1_Drive/r_u_road.png", IMAGE);
		add("assets/images/1_Drive/trees_green_bg.png", IMAGE);
		add("assets/images/1_Drive/trees_lake_bg.png", IMAGE);
		add("assets/images/1_Drive/trees_snow_bg.png", IMAGE);
		add("assets/images/2_Throw/ball.png", IMAGE);
		add("assets/images/2_Throw/throw_bg.png", IMAGE);
		add("assets/images/2_Throw/throw_jack_animations.png", IMAGE);
		add("assets/images/3_Maze/maze_walk_bg.png", IMAGE);
		add("assets/images/3_Maze/maze_walk_bg_end.png", IMAGE);
		add("assets/images/3_Maze/maze_walk_maze.png", IMAGE);
		add("assets/images/3_Maze/maze_walk_maze_0.png", IMAGE);
		add("assets/images/3_Maze/maze_walk_maze_1.png", IMAGE);
		add("assets/images/3_Maze/maze_walk_maze_2.png", IMAGE);
		add("assets/images/3_Maze/maze_walk_maze_3.png", IMAGE);
		add("assets/images/3_Maze/maze_walk_maze_4.png", IMAGE);
		add("assets/images/3_Maze/maze_walk_maze_5.png", IMAGE);
		add("assets/images/3_Maze/maze_walk_maze_end.png", IMAGE);
		add("assets/images/3_Maze/maze_walk_walkcycle.png", IMAGE);
		add("assets/images/4_Tricycle/tricycle_carpet.png", IMAGE);
		add("assets/images/4_Tricycle/tricycle_corridor_corner.png", IMAGE);
		add("assets/images/4_Tricycle/tricycle_corridor_straight.png", IMAGE);
		add("assets/images/4_Tricycle/tricycle_corridor_t.png", IMAGE);
		add("assets/images/4_Tricycle/tricycle_danny.png", IMAGE);
		add("assets/images/4_Tricycle/tricycle_twins.png", IMAGE);
		add("assets/images/4_Tricycle/tricycle_wood.png", IMAGE);
		add("assets/images/5_Type/type_bg.png", IMAGE);
		add("assets/images/5_Type/type_jack_typing.png", IMAGE);
		add("assets/images/6_237/237_bg.png", IMAGE);
		add("assets/images/6_237/237_hitmap.png", IMAGE);
		add("assets/images/6_237/237_jack_walk.png", IMAGE);
		add("assets/images/6_237/237_lady_walk.png", IMAGE);
		add("assets/images/7_Bat/bat_bg.png", IMAGE);
		add("assets/images/7_Bat/bat_jack.png", IMAGE);
		add("assets/images/7_Bat/bat_wendy.png", IMAGE);
		add("assets/images/8_Axe/axe_bg.png", IMAGE);
		add("assets/images/8_Axe/axe_door.png", IMAGE);
		add("assets/images/8_Axe/axe_jack.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_bg.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_jack.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_maze_0.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_maze_1.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_maze_2.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_maze_3.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_maze_4.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_maze_5.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_steps_end.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_steps_maze_end.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_steps_maze_start.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_steps_maze_turn_1.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_steps_maze_turn_2.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_steps_start.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_steps_turn_1.png", IMAGE);
		add("assets/images/9_Maze/maze_chase_steps_turn_2.png", IMAGE);
		add("assets/images/A_Elevators/interstitial_elevators.png", IMAGE);
		add("assets/images/B_Redrum/interstitial_redrum.png", IMAGE);
		add("assets/images/preloader/click.png", IMAGE);
		add("assets/images/preloader/loaded.png", IMAGE);
		add("assets/images/preloader/loading.png", IMAGE);
		add("assets/music/midnight.wav", SOUND);
		add("assets/music/shining_theme.wav", SOUND);
		add("assets/sounds/ball_bounce.wav", SOUND);
		add("assets/sounds/ball_catch.wav", SOUND);
		add("assets/sounds/ball_lost.wav", SOUND);
		add("assets/sounds/ball_throw.wav", SOUND);
		add("assets/sounds/bat_hit.wav", SOUND);
		add("assets/sounds/bat_hit_high.wav", SOUND);
		add("assets/sounds/bat_swing.wav", SOUND);
		add("assets/sounds/elevator_buzz.wav", SOUND);
		add("assets/sounds/laugh.wav", SOUND);
		add("assets/sounds/scare.wav", SOUND);
		add("assets/sounds/step_hard.wav", SOUND);
		add("assets/sounds/step_soft.wav", SOUND);
		add("assets/sounds/tricycle_hard.wav", SOUND);
		add("assets/sounds/tricycle_hard2.wav", SOUND);
		add("assets/sounds/tricycle_hard3.wav", SOUND);
		add("Square", FONT, "assets/fonts/Commodore.ttf");
		add("assets/sounds/beep.mp3", MUSIC);
		add("assets/sounds/flixel.mp3", MUSIC);
		add("assets/sounds/beep.ogg", SOUND);
		add("assets/sounds/flixel.ogg", SOUND);
		//
	}
	
	private function add(id:String, t:AssetType, ?p:String) {
		type.set(id, t);
		path.set(id, p != null ? p : id);
	}
	
	override public function getPath(id:String):String {
		return path.get(id);
	}
	
	override public function exists(id:String, t:AssetType):Bool {
		var r = type.get(id);
		if (r != null) {
			if (r == t || t == null) return true;
			switch (t) {
			case AssetType.SOUND: return r == AssetType.MUSIC;
			case AssetType.MUSIC: return r == AssetType.SOUND;
			case AssetType.BINARY: return true;
			default: return false;
			}
		}
		return false;
	}
	
	override public function getBitmapData(id:String):BitmapData {
		var q = ApplicationMain.loaders.get(path.get(id));
		var b:Bitmap = cast q.contentLoaderInfo.content;
		return b.bitmapData;
	}
	
	override public function getFont(id:String):Font {
		// not yet.
		return null;
	}
	
	override public function getSound(id:String):Sound {
		return new Sound(new URLRequest(path.get(id)));
	}
	
	override public function getMusic(id:String):Sound {
		return new Sound(new URLRequest(path.get(id)));
	}
	
	override public function getBytes(id:String):ByteArray {
		var r:ByteArray = null;
		var p = path.get(id);
		var d = ApplicationMain.urlLoaders.get(p).data;
		if (Std.is(d, String)) {
			(r = new ByteArray()).writeUTFBytes(cast d);
		} else if (Std.is(d, ByteArray)) {
			r = cast d;
		} else r = null;
		if (r != null) {
			r.position = 0;
			return r;
		} else return null;
	}
	
	override public function getText(id:String):String {
		var r:ByteArray = null;
		var p = path.get(id);
		var d = ApplicationMain.urlLoaders.get(p).data;
		if (Std.is(d, String)) {
			return cast d;
		} else if (Std.is(d, ByteArray)) {
			r = cast d;
			r.position = 0;
			return r.readUTFBytes(r.length);
		} else return null;
	}
	
	override public function list(t:AssetType):Array<String> {
		var r:Array<String> = [];
		for (id in type.keys()) {
			if (t == null || exists(id, t)) r.push(id);
		}
		return r;
	}
	
	override public function loadBitmapData(id:String, h:BitmapData->Void):Void {
		if (path.exists(id)) {
			var r = new Loader();
			var f:Event->Void = null;
			f = function(e:Event) {
				r.contentLoaderInfo.removeEventListener(Event.COMPLETE, f);
				var b:Bitmap = cast e.currentTarget.content;
				h(b.bitmapData);
				b = null; f = null; r = null;
			};
			r.addEventListener(Event.COMPLETE, f);
			r.load(new URLRequest(path.get(id)));
		} else h(getBitmapData(id));
	}
	
	override public function loadFont(id:String, h:Font->Void):Void {
		h(getFont(id));
	}
	
	override public function loadSound(id:String, h:Sound->Void):Void {
		h(getSound(id));
	}
	
	override public function loadMusic(id:String, h:Sound->Void):Void {
		h(getMusic(id));
	}
	
	override public function loadBytes(id:String, h:ByteArray->Void):Void {
		if (path.exists(id)) {
			var r = new URLLoader();
			var f:Event->Void = null;
			f = function(e:Event) {
				r.removeEventListener(Event.COMPLETE, f);
				var b = new ByteArray();
				b.writeUTFBytes(e.currentTarget.data);
				b.position = 0;
				h(b);
				b = null; f = null; r = null;
			};
			r.addEventListener(Event.COMPLETE, f);
		} else h(getBytes(id));
	}
	
	override public function loadText(id:String, h:String->Void):Void {
		if (path.exists(id)) {
			var r = new URLLoader();
			var f:Event->Void = null;
			f = function(e:Event) {
				r.removeEventListener(Event.COMPLETE, f);
				h(e.currentTarget.data);
				f = null; r = null;
			};
			r.addEventListener(Event.COMPLETE, f);
		} else h(getText(id));
	}
	
}
