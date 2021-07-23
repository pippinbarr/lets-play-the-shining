#if !macro
import Main;
import haxe.Resource;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.ILoader;
import openfl.events.Event;
import openfl.media.Sound;
import openfl.net.IURLLoader;
import openfl.net.URLRequest;
import openfl.net.URLLoaderDataFormat;
import openfl.Lib;
import js.html.Element;
import js.html.AudioElement;
import js.html.ProgressEvent;

@:build(ApplicationMain.build())
class ApplicationMain {
	#if (lime >= "2.6.0")
	public static var config:lime.app.Config = {
		build: "903",
		company: "HaxeFlixel",
		file: "LetsPlayTheShining",
		fps: 60,
		name: "LetsPlayTheShining",
		orientation: "portrait",
		packageName: "com.example.myapp",
		version: "0.0.1",
		windows: [ {
			antialiasing: 0,
			background: 0,
			borderless: false,
			depthBuffer: false,
			display: 0,
			fullscreen: false,
			hardware: true,
			height: 480,
			parameters: "{}",
			resizable: true,
			stencilBuffer: false,
			title: "LetsPlayTheShining",
			vsync: true,
			width: 480,
			x: null,
			y: null
		}, ],
	};
	#elseif (openfl >= "2.1")
	public static var config:lime.app.Config = {
		antialiasing: Std.int(0),
		background: Std.int(0),
		borderless: false,
		depthBuffer: false,
		fps: Std.int(60),
		fullscreen: false,
		height: Std.int(480),
		orientation: "portrait",
		resizable: true,
		stencilBuffer: false,
		title: "LetsPlayTheShining",
		vsync: true,
		width: Std.int(480),
	};
	#end
	private static var completed:Int;
	private static var preloader:Preloader;
	private static var total:Int;
	private static var bytesLoaded:Int;
	private static var totalBytes:Int;

	public static var loaders:Map<String, ILoader>;
	public static var urlLoaders:Map<String, IURLLoader>;
	private static var loaderStack:Array<String>;
	private static var urlLoaderStack:Array<String>;
	// Embed data preloading
	@:noCompletion public static var embeds:Int;
	@:noCompletion public static function loadEmbed(o:Element) {
		embeds = (embeds != null ? embeds : 0) + 1;
		var f = null;
		f = function(_) {
			o.removeEventListener("load", f);
			if (--embeds == 0) preload();
		}
		o.addEventListener("load", f);
	}
	
	public static function main() {
		if (embeds == null || embeds == 0) preload();
	}

	private static function preload() {
		bytesLoaded = totalBytes = 0;
		for (bytes in AssetBytes) totalBytes += bytes;
		completed = 0;
		loaders = new Map<String, ILoader>();
		urlLoaders = new Map<String, IURLLoader>();
		total = 0;
		
		Lib.current.loaderInfo = openfl.display.LoaderInfo.create (null);
		
		Lib.stage.frameRate = 60;
		// preloader:
		Lib.current.addChild(preloader = new Preloader());
		preloader.onInit();
		
		// assets:
		loadBinary("assets/data/data-goes-here.txt");
		loadBinary("assets/fonts/Commodore.eot");
		loadBinary("assets/fonts/Square.eot");
		loadBinary("assets/fonts/Square.svg");
		loadBinary("assets/fonts/Square.woff");
		loadFile("assets/images/0_Instructions/instructions_arrow_key.png");
		loadFile("assets/images/0_Instructions/instructions_space_bar.png");
		loadFile("assets/images/10_Final/final_jack.png");
		loadFile("assets/images/1_Drive/b_l_road.png");
		loadFile("assets/images/1_Drive/b_r_road.png");
		loadFile("assets/images/1_Drive/b_u_road.png");
		loadFile("assets/images/1_Drive/car.png");
		loadFile("assets/images/1_Drive/end_bg.png");
		loadFile("assets/images/1_Drive/end_road.png");
		loadFile("assets/images/1_Drive/l_u_road.png");
		loadFile("assets/images/1_Drive/lake_bottom.png");
		loadFile("assets/images/1_Drive/lake_bottom_left.png");
		loadFile("assets/images/1_Drive/lake_left.png");
		loadFile("assets/images/1_Drive/r_l_road.png");
		loadFile("assets/images/1_Drive/r_u_road.png");
		loadFile("assets/images/1_Drive/trees_green_bg.png");
		loadFile("assets/images/1_Drive/trees_lake_bg.png");
		loadFile("assets/images/1_Drive/trees_snow_bg.png");
		loadFile("assets/images/2_Throw/ball.png");
		loadFile("assets/images/2_Throw/throw_bg.png");
		loadFile("assets/images/2_Throw/throw_jack_animations.png");
		loadFile("assets/images/3_Maze/maze_walk_bg.png");
		loadFile("assets/images/3_Maze/maze_walk_bg_end.png");
		loadFile("assets/images/3_Maze/maze_walk_maze.png");
		loadFile("assets/images/3_Maze/maze_walk_maze_0.png");
		loadFile("assets/images/3_Maze/maze_walk_maze_1.png");
		loadFile("assets/images/3_Maze/maze_walk_maze_2.png");
		loadFile("assets/images/3_Maze/maze_walk_maze_3.png");
		loadFile("assets/images/3_Maze/maze_walk_maze_4.png");
		loadFile("assets/images/3_Maze/maze_walk_maze_5.png");
		loadFile("assets/images/3_Maze/maze_walk_maze_end.png");
		loadFile("assets/images/3_Maze/maze_walk_walkcycle.png");
		loadFile("assets/images/4_Tricycle/tricycle_carpet.png");
		loadFile("assets/images/4_Tricycle/tricycle_corridor_corner.png");
		loadFile("assets/images/4_Tricycle/tricycle_corridor_straight.png");
		loadFile("assets/images/4_Tricycle/tricycle_corridor_t.png");
		loadFile("assets/images/4_Tricycle/tricycle_danny.png");
		loadFile("assets/images/4_Tricycle/tricycle_twins.png");
		loadFile("assets/images/4_Tricycle/tricycle_wood.png");
		loadFile("assets/images/5_Type/type_bg.png");
		loadFile("assets/images/5_Type/type_jack_typing.png");
		loadFile("assets/images/6_237/237_bg.png");
		loadFile("assets/images/6_237/237_hitmap.png");
		loadFile("assets/images/6_237/237_jack_walk.png");
		loadFile("assets/images/6_237/237_lady_walk.png");
		loadFile("assets/images/7_Bat/bat_bg.png");
		loadFile("assets/images/7_Bat/bat_jack.png");
		loadFile("assets/images/7_Bat/bat_wendy.png");
		loadFile("assets/images/8_Axe/axe_bg.png");
		loadFile("assets/images/8_Axe/axe_door.png");
		loadFile("assets/images/8_Axe/axe_jack.png");
		loadFile("assets/images/9_Maze/maze_chase_bg.png");
		loadFile("assets/images/9_Maze/maze_chase_jack.png");
		loadFile("assets/images/9_Maze/maze_chase_maze_0.png");
		loadFile("assets/images/9_Maze/maze_chase_maze_1.png");
		loadFile("assets/images/9_Maze/maze_chase_maze_2.png");
		loadFile("assets/images/9_Maze/maze_chase_maze_3.png");
		loadFile("assets/images/9_Maze/maze_chase_maze_4.png");
		loadFile("assets/images/9_Maze/maze_chase_maze_5.png");
		loadFile("assets/images/9_Maze/maze_chase_steps_end.png");
		loadFile("assets/images/9_Maze/maze_chase_steps_maze_end.png");
		loadFile("assets/images/9_Maze/maze_chase_steps_maze_start.png");
		loadFile("assets/images/9_Maze/maze_chase_steps_maze_turn_1.png");
		loadFile("assets/images/9_Maze/maze_chase_steps_maze_turn_2.png");
		loadFile("assets/images/9_Maze/maze_chase_steps_start.png");
		loadFile("assets/images/9_Maze/maze_chase_steps_turn_1.png");
		loadFile("assets/images/9_Maze/maze_chase_steps_turn_2.png");
		loadFile("assets/images/A_Elevators/interstitial_elevators.png");
		loadFile("assets/images/B_Redrum/interstitial_redrum.png");
		loadFile("assets/images/preloader/click.png");
		loadFile("assets/images/preloader/loaded.png");
		loadFile("assets/images/preloader/loading.png");
		loadSound("assets/music/midnight.wav");
		loadSound("assets/music/shining_theme.wav");
		loadSound("assets/sounds/ball_bounce.wav");
		loadSound("assets/sounds/ball_catch.wav");
		loadSound("assets/sounds/ball_lost.wav");
		loadSound("assets/sounds/ball_throw.wav");
		loadSound("assets/sounds/bat_hit.wav");
		loadSound("assets/sounds/bat_hit_high.wav");
		loadSound("assets/sounds/bat_swing.wav");
		loadSound("assets/sounds/elevator_buzz.wav");
		loadSound("assets/sounds/laugh.wav");
		loadSound("assets/sounds/scare.wav");
		loadSound("assets/sounds/step_hard.wav");
		loadSound("assets/sounds/step_soft.wav");
		loadSound("assets/sounds/tricycle_hard.wav");
		loadSound("assets/sounds/tricycle_hard2.wav");
		loadSound("assets/sounds/tricycle_hard3.wav");
		loadSound("assets/sounds/beep.mp3");
		loadSound("assets/sounds/flixel.mp3");
		loadSound("assets/sounds/beep.ogg");
		loadSound("assets/sounds/flixel.ogg");
		
		// bitmaps:
		var resourcePrefix = "NME_:bitmap_";
		for (resourceName in Resource.listNames()) {
			if (StringTools.startsWith (resourceName, resourcePrefix)) {
				var type = Type.resolveClass(StringTools.replace (resourceName.substring(resourcePrefix.length), "_", "."));
				if (type != null) {
					total++;
					#if bitfive_logLoading
						Lib.trace("Loading " + Std.string(type));
					#end
					var instance = Type.createInstance (type, [ 0, 0, true, 0x00FFFFFF, bitmapClass_onComplete ]);
				}
			}
		}
		
		if (total != 0) {
			loaderStack = [];
			for (p in loaders.keys()) loaderStack.push(p);
			urlLoaderStack = [];
			for (p in urlLoaders.keys()) urlLoaderStack.push(p);
			// launch 8 loaders at once:
			for (i in 0 ... 8) nextLoader();
		} else begin();
	}
	
	private static function nextLoader() {
		if (loaderStack.length != 0) {
			var p = loaderStack.shift(), o = loaders.get(p);
			#if bitfive_logLoading
				Lib.trace("Loading " + p);
				o.contentLoaderInfo.addEventListener("complete", function(e) {
					Lib.trace("Loaded " + p);
					loader_onComplete(e);
				});
			#else
				o.contentLoaderInfo.addEventListener("complete", loader_onComplete);
			#end
			o.load(new URLRequest(p));
		} else if (urlLoaderStack.length != 0) {
			var p = urlLoaderStack.shift(), o = urlLoaders.get(p);
			#if bitfive_logLoading
				Lib.trace("Loading " + p);
				o.addEventListener("complete", function(e) {
					Lib.trace("Loaded " + p);
					loader_onComplete(e);
				});
			#else
				o.addEventListener("complete", loader_onComplete);
			#end
			o.load(new URLRequest(p));
		}
	}
	
	private static function loadFile(p:String):Void {
		loaders.set(p, new openfl.display.Loader());
		total++;
	}
	
	private static function loadBinary(p:String):Void {
		var o = new openfl.net.URLLoader();
		o.dataFormat = URLLoaderDataFormat.BINARY;
		urlLoaders.set(p, o);
		total++;
	}
	
	private static function loadSound(p:String):Void {
		return;
		var i:Int = p.lastIndexOf("."), // extension separator location
			c:Dynamic = untyped openfl.media.Sound, // sound class
			s:String, // perceived sound filename (*.mp3)
			o:AudioElement, // audio node
			m:Bool = Lib.mobile,
			f:Dynamic->Void = null, // event listener
			q:String = "canplaythrough"; // preload event
		// not a valid sound path:
		if (i == -1) return;
		// wrong audio type:
		if (!c.canPlayType || !c.canPlayType(p.substr(i + 1))) return;
		// form perceived path:
		s = p.substr(0, i) + ".mp3";
		// already loaded?
		if (c.library.exists(s)) return;
		#if bitfive_logLoading
			Lib.trace("Loading " + p);
		#end
		total++;
		c.library.set(s, o = untyped __js__("new Audio(p)"));
		f = function(_) {
			#if bitfive_logLoading
				Lib.trace("Loaded " + p);
			#end
			if (!m) o.removeEventListener(q, f);
			preloader.onUpdate(++completed, total);
			if (completed == total) begin();
		};
		// do not auto-preload sounds on mobile:
		if (m) f(null); else o.addEventListener(q, f);
	}

	private static function begin():Void {
		preloader.addEventListener(Event.COMPLETE, preloader_onComplete);
		preloader.onLoaded();
	}
	
	private static function bitmapClass_onComplete(instance:BitmapData):Void {
		completed++;
		var classType = Type.getClass (instance);
		Reflect.setField(classType, "preload", instance);
		if (completed == total) begin();
	}

	private static function loader_onComplete(event:Event):Void {
		completed ++;
		bytesLoaded += AssetBytes[AssetNames.indexOf(untyped event._target.url)];
		preloader.onUpdate (bytesLoaded, totalBytes);
		if (completed == total) begin();
		else nextLoader();
	}

	private static function preloader_onComplete(event:Event):Void {
		preloader.removeEventListener(Event.COMPLETE, preloader_onComplete);
		Lib.current.removeChild(preloader);
		preloader = null;
		if (untyped Main.main == null) {
			var o = new DocumentClass();
			if (Std.is(o, openfl.display.DisplayObject)) Lib.current.addChild(cast o);
		} else untyped Main.main();
	}
}

@:build(DocumentClass.build())
class DocumentClass extends Main {
	@:keep public function new() {
		super();
	}
}

#else // macro
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;

class ApplicationMain {
	macro public static function build():Array<Field> {
		var assetNames:Array<String> = new Array<String>();
		var assetBytes:Array<Int> = new Array<Int>();
		inline function addAsset(name:String, path:String) {
			assetNames.push(name);
			var size = 0;
			try {
				size = FileSystem.stat(path).size;
			} catch (_:Dynamic) {
				//trace("Can't stat() " + path);
			}
			assetBytes.push(size);
		}
		addAsset("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
		addAsset("assets/fonts/Commodore.eot", "assets/fonts/Commodore.eot");
		addAsset("assets/fonts/Commodore.ttf", "assets/fonts/Commodore.ttf");
		addAsset("assets/fonts/Square.eot", "assets/fonts/Square.eot");
		addAsset("assets/fonts/Square.svg", "assets/fonts/Square.svg");
		addAsset("assets/fonts/Square.ttf", "assets/fonts/Square.ttf");
		addAsset("assets/fonts/Square.woff", "assets/fonts/Square.woff");
		addAsset("assets/images/0_Instructions/instructions_arrow_key.png", "assets/images/0_Instructions/instructions_arrow_key.png");
		addAsset("assets/images/0_Instructions/instructions_space_bar.png", "assets/images/0_Instructions/instructions_space_bar.png");
		addAsset("assets/images/10_Final/final_jack.png", "assets/images/10_Final/final_jack.png");
		addAsset("assets/images/1_Drive/b_l_road.png", "assets/images/1_Drive/b_l_road.png");
		addAsset("assets/images/1_Drive/b_r_road.png", "assets/images/1_Drive/b_r_road.png");
		addAsset("assets/images/1_Drive/b_u_road.png", "assets/images/1_Drive/b_u_road.png");
		addAsset("assets/images/1_Drive/car.png", "assets/images/1_Drive/car.png");
		addAsset("assets/images/1_Drive/end_bg.png", "assets/images/1_Drive/end_bg.png");
		addAsset("assets/images/1_Drive/end_road.png", "assets/images/1_Drive/end_road.png");
		addAsset("assets/images/1_Drive/l_u_road.png", "assets/images/1_Drive/l_u_road.png");
		addAsset("assets/images/1_Drive/lake_bottom.png", "assets/images/1_Drive/lake_bottom.png");
		addAsset("assets/images/1_Drive/lake_bottom_left.png", "assets/images/1_Drive/lake_bottom_left.png");
		addAsset("assets/images/1_Drive/lake_left.png", "assets/images/1_Drive/lake_left.png");
		addAsset("assets/images/1_Drive/r_l_road.png", "assets/images/1_Drive/r_l_road.png");
		addAsset("assets/images/1_Drive/r_u_road.png", "assets/images/1_Drive/r_u_road.png");
		addAsset("assets/images/1_Drive/trees_green_bg.png", "assets/images/1_Drive/trees_green_bg.png");
		addAsset("assets/images/1_Drive/trees_lake_bg.png", "assets/images/1_Drive/trees_lake_bg.png");
		addAsset("assets/images/1_Drive/trees_snow_bg.png", "assets/images/1_Drive/trees_snow_bg.png");
		addAsset("assets/images/2_Throw/ball.png", "assets/images/2_Throw/ball.png");
		addAsset("assets/images/2_Throw/throw_bg.png", "assets/images/2_Throw/throw_bg.png");
		addAsset("assets/images/2_Throw/throw_jack_animations.png", "assets/images/2_Throw/throw_jack_animations.png");
		addAsset("assets/images/3_Maze/maze_walk_bg.png", "assets/images/3_Maze/maze_walk_bg.png");
		addAsset("assets/images/3_Maze/maze_walk_bg_end.png", "assets/images/3_Maze/maze_walk_bg_end.png");
		addAsset("assets/images/3_Maze/maze_walk_maze.png", "assets/images/3_Maze/maze_walk_maze.png");
		addAsset("assets/images/3_Maze/maze_walk_maze_0.png", "assets/images/3_Maze/maze_walk_maze_0.png");
		addAsset("assets/images/3_Maze/maze_walk_maze_1.png", "assets/images/3_Maze/maze_walk_maze_1.png");
		addAsset("assets/images/3_Maze/maze_walk_maze_2.png", "assets/images/3_Maze/maze_walk_maze_2.png");
		addAsset("assets/images/3_Maze/maze_walk_maze_3.png", "assets/images/3_Maze/maze_walk_maze_3.png");
		addAsset("assets/images/3_Maze/maze_walk_maze_4.png", "assets/images/3_Maze/maze_walk_maze_4.png");
		addAsset("assets/images/3_Maze/maze_walk_maze_5.png", "assets/images/3_Maze/maze_walk_maze_5.png");
		addAsset("assets/images/3_Maze/maze_walk_maze_end.png", "assets/images/3_Maze/maze_walk_maze_end.png");
		addAsset("assets/images/3_Maze/maze_walk_walkcycle.png", "assets/images/3_Maze/maze_walk_walkcycle.png");
		addAsset("assets/images/4_Tricycle/tricycle_carpet.png", "assets/images/4_Tricycle/tricycle_carpet.png");
		addAsset("assets/images/4_Tricycle/tricycle_corridor_corner.png", "assets/images/4_Tricycle/tricycle_corridor_corner.png");
		addAsset("assets/images/4_Tricycle/tricycle_corridor_straight.png", "assets/images/4_Tricycle/tricycle_corridor_straight.png");
		addAsset("assets/images/4_Tricycle/tricycle_corridor_t.png", "assets/images/4_Tricycle/tricycle_corridor_t.png");
		addAsset("assets/images/4_Tricycle/tricycle_danny.png", "assets/images/4_Tricycle/tricycle_danny.png");
		addAsset("assets/images/4_Tricycle/tricycle_twins.png", "assets/images/4_Tricycle/tricycle_twins.png");
		addAsset("assets/images/4_Tricycle/tricycle_wood.png", "assets/images/4_Tricycle/tricycle_wood.png");
		addAsset("assets/images/5_Type/type_bg.png", "assets/images/5_Type/type_bg.png");
		addAsset("assets/images/5_Type/type_jack_typing.png", "assets/images/5_Type/type_jack_typing.png");
		addAsset("assets/images/6_237/237_bg.png", "assets/images/6_237/237_bg.png");
		addAsset("assets/images/6_237/237_hitmap.png", "assets/images/6_237/237_hitmap.png");
		addAsset("assets/images/6_237/237_jack_walk.png", "assets/images/6_237/237_jack_walk.png");
		addAsset("assets/images/6_237/237_lady_walk.png", "assets/images/6_237/237_lady_walk.png");
		addAsset("assets/images/7_Bat/bat_bg.png", "assets/images/7_Bat/bat_bg.png");
		addAsset("assets/images/7_Bat/bat_jack.png", "assets/images/7_Bat/bat_jack.png");
		addAsset("assets/images/7_Bat/bat_wendy.png", "assets/images/7_Bat/bat_wendy.png");
		addAsset("assets/images/8_Axe/axe_bg.png", "assets/images/8_Axe/axe_bg.png");
		addAsset("assets/images/8_Axe/axe_door.png", "assets/images/8_Axe/axe_door.png");
		addAsset("assets/images/8_Axe/axe_jack.png", "assets/images/8_Axe/axe_jack.png");
		addAsset("assets/images/9_Maze/maze_chase_bg.png", "assets/images/9_Maze/maze_chase_bg.png");
		addAsset("assets/images/9_Maze/maze_chase_jack.png", "assets/images/9_Maze/maze_chase_jack.png");
		addAsset("assets/images/9_Maze/maze_chase_maze_0.png", "assets/images/9_Maze/maze_chase_maze_0.png");
		addAsset("assets/images/9_Maze/maze_chase_maze_1.png", "assets/images/9_Maze/maze_chase_maze_1.png");
		addAsset("assets/images/9_Maze/maze_chase_maze_2.png", "assets/images/9_Maze/maze_chase_maze_2.png");
		addAsset("assets/images/9_Maze/maze_chase_maze_3.png", "assets/images/9_Maze/maze_chase_maze_3.png");
		addAsset("assets/images/9_Maze/maze_chase_maze_4.png", "assets/images/9_Maze/maze_chase_maze_4.png");
		addAsset("assets/images/9_Maze/maze_chase_maze_5.png", "assets/images/9_Maze/maze_chase_maze_5.png");
		addAsset("assets/images/9_Maze/maze_chase_steps_end.png", "assets/images/9_Maze/maze_chase_steps_end.png");
		addAsset("assets/images/9_Maze/maze_chase_steps_maze_end.png", "assets/images/9_Maze/maze_chase_steps_maze_end.png");
		addAsset("assets/images/9_Maze/maze_chase_steps_maze_start.png", "assets/images/9_Maze/maze_chase_steps_maze_start.png");
		addAsset("assets/images/9_Maze/maze_chase_steps_maze_turn_1.png", "assets/images/9_Maze/maze_chase_steps_maze_turn_1.png");
		addAsset("assets/images/9_Maze/maze_chase_steps_maze_turn_2.png", "assets/images/9_Maze/maze_chase_steps_maze_turn_2.png");
		addAsset("assets/images/9_Maze/maze_chase_steps_start.png", "assets/images/9_Maze/maze_chase_steps_start.png");
		addAsset("assets/images/9_Maze/maze_chase_steps_turn_1.png", "assets/images/9_Maze/maze_chase_steps_turn_1.png");
		addAsset("assets/images/9_Maze/maze_chase_steps_turn_2.png", "assets/images/9_Maze/maze_chase_steps_turn_2.png");
		addAsset("assets/images/A_Elevators/interstitial_elevators.png", "assets/images/A_Elevators/interstitial_elevators.png");
		addAsset("assets/images/B_Redrum/interstitial_redrum.png", "assets/images/B_Redrum/interstitial_redrum.png");
		addAsset("assets/images/preloader/click.png", "assets/images/preloader/click.png");
		addAsset("assets/images/preloader/loaded.png", "assets/images/preloader/loaded.png");
		addAsset("assets/images/preloader/loading.png", "assets/images/preloader/loading.png");
		addAsset("assets/music/midnight.wav", "assets/music/midnight.wav");
		addAsset("assets/music/shining_theme.wav", "assets/music/shining_theme.wav");
		addAsset("assets/sounds/ball_bounce.wav", "assets/sounds/ball_bounce.wav");
		addAsset("assets/sounds/ball_catch.wav", "assets/sounds/ball_catch.wav");
		addAsset("assets/sounds/ball_lost.wav", "assets/sounds/ball_lost.wav");
		addAsset("assets/sounds/ball_throw.wav", "assets/sounds/ball_throw.wav");
		addAsset("assets/sounds/bat_hit.wav", "assets/sounds/bat_hit.wav");
		addAsset("assets/sounds/bat_hit_high.wav", "assets/sounds/bat_hit_high.wav");
		addAsset("assets/sounds/bat_swing.wav", "assets/sounds/bat_swing.wav");
		addAsset("assets/sounds/elevator_buzz.wav", "assets/sounds/elevator_buzz.wav");
		addAsset("assets/sounds/laugh.wav", "assets/sounds/laugh.wav");
		addAsset("assets/sounds/scare.wav", "assets/sounds/scare.wav");
		addAsset("assets/sounds/step_hard.wav", "assets/sounds/step_hard.wav");
		addAsset("assets/sounds/step_soft.wav", "assets/sounds/step_soft.wav");
		addAsset("assets/sounds/tricycle_hard.wav", "assets/sounds/tricycle_hard.wav");
		addAsset("assets/sounds/tricycle_hard2.wav", "assets/sounds/tricycle_hard2.wav");
		addAsset("assets/sounds/tricycle_hard3.wav", "assets/sounds/tricycle_hard3.wav");
		addAsset("assets/fonts/Commodore.ttf", "assets/fonts/Commodore.ttf");
		addAsset("assets/sounds/beep.mp3", "/usr/lib/haxe/lib/flixel/3,3,6/assets/sounds/beep.mp3");
		addAsset("assets/sounds/flixel.mp3", "/usr/lib/haxe/lib/flixel/3,3,6/assets/sounds/flixel.mp3");
		addAsset("assets/sounds/beep.ogg", "/usr/lib/haxe/lib/flixel/3,3,6/assets/sounds/beep.ogg");
		addAsset("assets/sounds/flixel.ogg", "/usr/lib/haxe/lib/flixel/3,3,6/assets/sounds/flixel.ogg");
		
		var fields = Context.getBuildFields();
		
		var typeArrayString = TPath({ pack : [], name : "Array", params : [TPType(TPath({ name : "String", pack : [], params : [] }))], sub : null });
		var newField = {
			name: "AssetNames",
			doc: null,
			meta: [],
			access: [AStatic, APublic],
			kind: FVar( typeArrayString, macro $v{assetNames}),
			pos: Context.currentPos()
		};
		fields.push(newField);
		var typeArrayInt = TPath({ pack : [], name : "Array", params : [TPType(TPath({ name : "Int", pack : [], params : [] }))], sub : null });
		var newField = {
			name: "AssetBytes",
			doc: null,
			meta: [],
			access: [AStatic, APublic],
			kind: FVar( typeArrayInt, macro $v{assetBytes}),
			pos: Context.currentPos()
		};
		fields.push(newField);
		return fields;
	}
}

class DocumentClass {
	
	macro public static function build ():Array<Field> {
		var classType = Context.getLocalClass().get();
		var searchTypes = classType;
		while (searchTypes.superClass != null) {
			if(searchTypes.pack.length == 2
			&& searchTypes.pack[1] == "display"
			&& searchTypes.name == "DisplayObject") {
				var fields = Context.getBuildFields();
				var method = macro {
					return Lib.current.stage;
				}
				fields.push( {
					name: "get_stage",
					access: [ APrivate, AOverride ],
					kind: FFun( {
						args: [],
						expr: method,
						params: [],
						ret: macro :openfl.display.Stage
					}), pos: Context.currentPos() });
				return fields;
			}
			searchTypes = searchTypes.superClass.t.get();
		}
		return null;
	}
	
}
#end