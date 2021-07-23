import lime.Assets;
#if !macro


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	
	public static function create ():Void {
		
		var app = new openfl.display.Application ();
		app.create (config);
		
		var display = new NMEPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		preloader.onComplete = init;
		preloader.create (config);
		
		#if (js && html5)
		var urls = [];
		var types = [];
		
		
		urls.push ("assets/data/data-goes-here.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/fonts/Commodore.eot");
		types.push (AssetType.TEXT);
		
		
		urls.push ("Commodore 64 Pixelized");
		types.push (AssetType.FONT);
		
		
		urls.push ("assets/fonts/Square.eot");
		types.push (AssetType.BINARY);
		
		
		urls.push ("assets/fonts/Square.svg");
		types.push (AssetType.TEXT);
		
		
		urls.push ("SquareFont");
		types.push (AssetType.FONT);
		
		
		urls.push ("assets/fonts/Square.woff");
		types.push (AssetType.BINARY);
		
		
		urls.push ("assets/images/0_Instructions/instructions_arrow_key.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/0_Instructions/instructions_space_bar.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/10_Final/final_jack.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/b_l_road.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/b_r_road.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/b_u_road.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/car.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/end_bg.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/end_road.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/l_u_road.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/lake_bottom.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/lake_bottom_left.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/lake_left.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/r_l_road.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/r_u_road.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/trees_green_bg.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/trees_lake_bg.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/1_Drive/trees_snow_bg.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/2_Throw/ball.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/2_Throw/throw_bg.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/2_Throw/throw_jack_animations.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/3_Maze/maze_walk_bg.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/3_Maze/maze_walk_bg_end.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/3_Maze/maze_walk_maze.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/3_Maze/maze_walk_maze_0.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/3_Maze/maze_walk_maze_1.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/3_Maze/maze_walk_maze_2.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/3_Maze/maze_walk_maze_3.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/3_Maze/maze_walk_maze_4.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/3_Maze/maze_walk_maze_5.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/3_Maze/maze_walk_maze_end.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/3_Maze/maze_walk_walkcycle.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/4_Tricycle/tricycle_carpet.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/4_Tricycle/tricycle_corridor_corner.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/4_Tricycle/tricycle_corridor_straight.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/4_Tricycle/tricycle_corridor_t.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/4_Tricycle/tricycle_danny.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/4_Tricycle/tricycle_twins.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/4_Tricycle/tricycle_wood.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/5_Type/type_bg.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/5_Type/type_jack_typing.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/6_Room_237/room_237_bg.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/6_Room_237/room_237_hitmap.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/6_Room_237/room_237_jack_walk.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/6_Room_237/room_237_lady_walk.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/7_Bat/bat_bg.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/7_Bat/bat_jack.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/7_Bat/bat_wendy.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/8_Axe/axe_bg.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/8_Axe/axe_door.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/8_Axe/axe_jack.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_bg.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_jack.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_maze_0.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_maze_1.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_maze_2.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_maze_3.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_maze_4.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_maze_5.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_steps_end.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_steps_maze_end.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_steps_maze_start.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_steps_maze_turn_1.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_steps_maze_turn_2.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_steps_start.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_steps_turn_1.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/9_Maze/maze_chase_steps_turn_2.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/A_Elevators/interstitial_elevators.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/B_Redrum/interstitial_redrum.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/preloader/click.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/preloader/loaded.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/preloader/loading.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/music/midnight.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/music/shining_theme.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/ball_bounce.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/ball_catch.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/ball_lost.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/ball_throw.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/bat_hit.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/bat_hit_high.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/bat_swing.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/elevator_buzz.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/laugh.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/scare.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/step_hard.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/step_soft.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/tricycle_hard.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/tricycle_hard2.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("assets/sounds/tricycle_hard3.wav");
		types.push (AssetType.SOUND);
		
		
		urls.push ("Commodore 64 Pixelized");
		types.push (AssetType.FONT);
		
		
		urls.push ("assets/sounds/beep.mp3");
		types.push (AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/flixel.mp3");
		types.push (AssetType.MUSIC);
		
		
		
		if (config.assetsPrefix != null) {
			
			for (i in 0...urls.length) {
				
				if (types[i] != AssetType.FONT) {
					
					urls[i] = config.assetsPrefix + urls[i];
					
				}
				
			}
			
		}
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if (sys && !emscripten)
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (__) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		preloader = null;
		
		
		
		if (loaded == total) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			antialiasing: Std.int (0),
			background: Std.int (0),
			borderless: false,
			depthBuffer: false,
			fps: Std.int (60),
			fullscreen: false,
			height: Std.int (480),
			orientation: "portrait",
			resizable: true,
			stencilBuffer: false,
			title: "LetsPlayTheShining",
			vsync: true,
			width: Std.int (480),
			
		}
		
		#if js
		#if (munit || utest)
		flash.Lib.embed (null, 480, 480, "000000");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		var hasMain = false;
		var entryPoint = Type.resolveClass ("Main");
		
		for (methodName in Type.getClassFields (entryPoint)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		if (hasMain) {
			
			Reflect.callMethod (entryPoint, Reflect.field (entryPoint, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			/*if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}*/
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		
	}
	
	
	#if neko
	@:noCompletion public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


@:build(DocumentClass.build())
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					openfl.Lib.current.addChild (this);
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end
