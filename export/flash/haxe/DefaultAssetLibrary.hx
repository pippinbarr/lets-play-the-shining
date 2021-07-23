package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Preloader;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Font;
import lime.graphics.Image;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if (sys || nodejs)
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		className.set ("assets/fonts/Commodore.eot", __ASSET__assets_fonts_commodore_eot);
		type.set ("assets/fonts/Commodore.eot", AssetType.TEXT);
		className.set ("assets/fonts/Commodore.ttf", __ASSET__assets_fonts_commodore_ttf);
		type.set ("assets/fonts/Commodore.ttf", AssetType.FONT);
		className.set ("assets/fonts/Square.eot", __ASSET__assets_fonts_square_eot);
		type.set ("assets/fonts/Square.eot", AssetType.BINARY);
		className.set ("assets/fonts/Square.svg", __ASSET__assets_fonts_square_svg);
		type.set ("assets/fonts/Square.svg", AssetType.TEXT);
		className.set ("assets/fonts/Square.ttf", __ASSET__assets_fonts_square_ttf);
		type.set ("assets/fonts/Square.ttf", AssetType.FONT);
		className.set ("assets/fonts/Square.woff", __ASSET__assets_fonts_square_woff);
		type.set ("assets/fonts/Square.woff", AssetType.BINARY);
		className.set ("assets/images/0_Instructions/instructions_arrow_key.png", __ASSET__assets_images_0_instructions_instructions_arrow_key_png);
		type.set ("assets/images/0_Instructions/instructions_arrow_key.png", AssetType.IMAGE);
		className.set ("assets/images/0_Instructions/instructions_space_bar.png", __ASSET__assets_images_0_instructions_instructions_space_bar_png);
		type.set ("assets/images/0_Instructions/instructions_space_bar.png", AssetType.IMAGE);
		className.set ("assets/images/10_Final/final_jack.png", __ASSET__assets_images_10_final_final_jack_png);
		type.set ("assets/images/10_Final/final_jack.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/b_l_road.png", __ASSET__assets_images_1_drive_b_l_road_png);
		type.set ("assets/images/1_Drive/b_l_road.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/b_r_road.png", __ASSET__assets_images_1_drive_b_r_road_png);
		type.set ("assets/images/1_Drive/b_r_road.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/b_u_road.png", __ASSET__assets_images_1_drive_b_u_road_png);
		type.set ("assets/images/1_Drive/b_u_road.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/car.png", __ASSET__assets_images_1_drive_car_png);
		type.set ("assets/images/1_Drive/car.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/end_bg.png", __ASSET__assets_images_1_drive_end_bg_png);
		type.set ("assets/images/1_Drive/end_bg.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/end_road.png", __ASSET__assets_images_1_drive_end_road_png);
		type.set ("assets/images/1_Drive/end_road.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/l_u_road.png", __ASSET__assets_images_1_drive_l_u_road_png);
		type.set ("assets/images/1_Drive/l_u_road.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/lake_bottom.png", __ASSET__assets_images_1_drive_lake_bottom_png);
		type.set ("assets/images/1_Drive/lake_bottom.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/lake_bottom_left.png", __ASSET__assets_images_1_drive_lake_bottom_left_png);
		type.set ("assets/images/1_Drive/lake_bottom_left.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/lake_left.png", __ASSET__assets_images_1_drive_lake_left_png);
		type.set ("assets/images/1_Drive/lake_left.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/r_l_road.png", __ASSET__assets_images_1_drive_r_l_road_png);
		type.set ("assets/images/1_Drive/r_l_road.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/r_u_road.png", __ASSET__assets_images_1_drive_r_u_road_png);
		type.set ("assets/images/1_Drive/r_u_road.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/trees_green_bg.png", __ASSET__assets_images_1_drive_trees_green_bg_png);
		type.set ("assets/images/1_Drive/trees_green_bg.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/trees_lake_bg.png", __ASSET__assets_images_1_drive_trees_lake_bg_png);
		type.set ("assets/images/1_Drive/trees_lake_bg.png", AssetType.IMAGE);
		className.set ("assets/images/1_Drive/trees_snow_bg.png", __ASSET__assets_images_1_drive_trees_snow_bg_png);
		type.set ("assets/images/1_Drive/trees_snow_bg.png", AssetType.IMAGE);
		className.set ("assets/images/2_Throw/ball.png", __ASSET__assets_images_2_throw_ball_png);
		type.set ("assets/images/2_Throw/ball.png", AssetType.IMAGE);
		className.set ("assets/images/2_Throw/throw_bg.png", __ASSET__assets_images_2_throw_throw_bg_png);
		type.set ("assets/images/2_Throw/throw_bg.png", AssetType.IMAGE);
		className.set ("assets/images/2_Throw/throw_jack_animations.png", __ASSET__assets_images_2_throw_throw_jack_animations_png);
		type.set ("assets/images/2_Throw/throw_jack_animations.png", AssetType.IMAGE);
		className.set ("assets/images/3_Maze/maze_walk_bg.png", __ASSET__assets_images_3_maze_maze_walk_bg_png);
		type.set ("assets/images/3_Maze/maze_walk_bg.png", AssetType.IMAGE);
		className.set ("assets/images/3_Maze/maze_walk_bg_end.png", __ASSET__assets_images_3_maze_maze_walk_bg_end_png);
		type.set ("assets/images/3_Maze/maze_walk_bg_end.png", AssetType.IMAGE);
		className.set ("assets/images/3_Maze/maze_walk_maze.png", __ASSET__assets_images_3_maze_maze_walk_maze_png);
		type.set ("assets/images/3_Maze/maze_walk_maze.png", AssetType.IMAGE);
		className.set ("assets/images/3_Maze/maze_walk_maze_0.png", __ASSET__assets_images_3_maze_maze_walk_maze_0_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_0.png", AssetType.IMAGE);
		className.set ("assets/images/3_Maze/maze_walk_maze_1.png", __ASSET__assets_images_3_maze_maze_walk_maze_1_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_1.png", AssetType.IMAGE);
		className.set ("assets/images/3_Maze/maze_walk_maze_2.png", __ASSET__assets_images_3_maze_maze_walk_maze_2_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_2.png", AssetType.IMAGE);
		className.set ("assets/images/3_Maze/maze_walk_maze_3.png", __ASSET__assets_images_3_maze_maze_walk_maze_3_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_3.png", AssetType.IMAGE);
		className.set ("assets/images/3_Maze/maze_walk_maze_4.png", __ASSET__assets_images_3_maze_maze_walk_maze_4_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_4.png", AssetType.IMAGE);
		className.set ("assets/images/3_Maze/maze_walk_maze_5.png", __ASSET__assets_images_3_maze_maze_walk_maze_5_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_5.png", AssetType.IMAGE);
		className.set ("assets/images/3_Maze/maze_walk_maze_end.png", __ASSET__assets_images_3_maze_maze_walk_maze_end_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_end.png", AssetType.IMAGE);
		className.set ("assets/images/3_Maze/maze_walk_walkcycle.png", __ASSET__assets_images_3_maze_maze_walk_walkcycle_png);
		type.set ("assets/images/3_Maze/maze_walk_walkcycle.png", AssetType.IMAGE);
		className.set ("assets/images/4_Tricycle/tricycle_carpet.png", __ASSET__assets_images_4_tricycle_tricycle_carpet_png);
		type.set ("assets/images/4_Tricycle/tricycle_carpet.png", AssetType.IMAGE);
		className.set ("assets/images/4_Tricycle/tricycle_corridor_corner.png", __ASSET__assets_images_4_tricycle_tricycle_corridor_corner_png);
		type.set ("assets/images/4_Tricycle/tricycle_corridor_corner.png", AssetType.IMAGE);
		className.set ("assets/images/4_Tricycle/tricycle_corridor_straight.png", __ASSET__assets_images_4_tricycle_tricycle_corridor_straight_png);
		type.set ("assets/images/4_Tricycle/tricycle_corridor_straight.png", AssetType.IMAGE);
		className.set ("assets/images/4_Tricycle/tricycle_corridor_t.png", __ASSET__assets_images_4_tricycle_tricycle_corridor_t_png);
		type.set ("assets/images/4_Tricycle/tricycle_corridor_t.png", AssetType.IMAGE);
		className.set ("assets/images/4_Tricycle/tricycle_danny.png", __ASSET__assets_images_4_tricycle_tricycle_danny_png);
		type.set ("assets/images/4_Tricycle/tricycle_danny.png", AssetType.IMAGE);
		className.set ("assets/images/4_Tricycle/tricycle_twins.png", __ASSET__assets_images_4_tricycle_tricycle_twins_png);
		type.set ("assets/images/4_Tricycle/tricycle_twins.png", AssetType.IMAGE);
		className.set ("assets/images/4_Tricycle/tricycle_wood.png", __ASSET__assets_images_4_tricycle_tricycle_wood_png);
		type.set ("assets/images/4_Tricycle/tricycle_wood.png", AssetType.IMAGE);
		className.set ("assets/images/5_Type/type_bg.png", __ASSET__assets_images_5_type_type_bg_png);
		type.set ("assets/images/5_Type/type_bg.png", AssetType.IMAGE);
		className.set ("assets/images/5_Type/type_jack_typing.png", __ASSET__assets_images_5_type_type_jack_typing_png);
		type.set ("assets/images/5_Type/type_jack_typing.png", AssetType.IMAGE);
		className.set ("assets/images/6_Room_237/room_237_bg.png", __ASSET__assets_images_6_room_237_room_237_bg_png);
		type.set ("assets/images/6_Room_237/room_237_bg.png", AssetType.IMAGE);
		className.set ("assets/images/6_Room_237/room_237_hitmap.png", __ASSET__assets_images_6_room_237_room_237_hitmap_png);
		type.set ("assets/images/6_Room_237/room_237_hitmap.png", AssetType.IMAGE);
		className.set ("assets/images/6_Room_237/room_237_jack_walk.png", __ASSET__assets_images_6_room_237_room_237_jack_walk_png);
		type.set ("assets/images/6_Room_237/room_237_jack_walk.png", AssetType.IMAGE);
		className.set ("assets/images/6_Room_237/room_237_lady_walk.png", __ASSET__assets_images_6_room_237_room_237_lady_walk_png);
		type.set ("assets/images/6_Room_237/room_237_lady_walk.png", AssetType.IMAGE);
		className.set ("assets/images/7_Bat/bat_bg.png", __ASSET__assets_images_7_bat_bat_bg_png);
		type.set ("assets/images/7_Bat/bat_bg.png", AssetType.IMAGE);
		className.set ("assets/images/7_Bat/bat_jack.png", __ASSET__assets_images_7_bat_bat_jack_png);
		type.set ("assets/images/7_Bat/bat_jack.png", AssetType.IMAGE);
		className.set ("assets/images/7_Bat/bat_wendy.png", __ASSET__assets_images_7_bat_bat_wendy_png);
		type.set ("assets/images/7_Bat/bat_wendy.png", AssetType.IMAGE);
		className.set ("assets/images/8_Axe/axe_bg.png", __ASSET__assets_images_8_axe_axe_bg_png);
		type.set ("assets/images/8_Axe/axe_bg.png", AssetType.IMAGE);
		className.set ("assets/images/8_Axe/axe_door.png", __ASSET__assets_images_8_axe_axe_door_png);
		type.set ("assets/images/8_Axe/axe_door.png", AssetType.IMAGE);
		className.set ("assets/images/8_Axe/axe_jack.png", __ASSET__assets_images_8_axe_axe_jack_png);
		type.set ("assets/images/8_Axe/axe_jack.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_bg.png", __ASSET__assets_images_9_maze_maze_chase_bg_png);
		type.set ("assets/images/9_Maze/maze_chase_bg.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_jack.png", __ASSET__assets_images_9_maze_maze_chase_jack_png);
		type.set ("assets/images/9_Maze/maze_chase_jack.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_maze_0.png", __ASSET__assets_images_9_maze_maze_chase_maze_0_png);
		type.set ("assets/images/9_Maze/maze_chase_maze_0.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_maze_1.png", __ASSET__assets_images_9_maze_maze_chase_maze_1_png);
		type.set ("assets/images/9_Maze/maze_chase_maze_1.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_maze_2.png", __ASSET__assets_images_9_maze_maze_chase_maze_2_png);
		type.set ("assets/images/9_Maze/maze_chase_maze_2.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_maze_3.png", __ASSET__assets_images_9_maze_maze_chase_maze_3_png);
		type.set ("assets/images/9_Maze/maze_chase_maze_3.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_maze_4.png", __ASSET__assets_images_9_maze_maze_chase_maze_4_png);
		type.set ("assets/images/9_Maze/maze_chase_maze_4.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_maze_5.png", __ASSET__assets_images_9_maze_maze_chase_maze_5_png);
		type.set ("assets/images/9_Maze/maze_chase_maze_5.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_steps_end.png", __ASSET__assets_images_9_maze_maze_chase_steps_end_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_end.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_steps_maze_end.png", __ASSET__assets_images_9_maze_maze_chase_steps_maze_end_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_maze_end.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_steps_maze_start.png", __ASSET__assets_images_9_maze_maze_chase_steps_maze_start_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_maze_start.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_steps_maze_turn_1.png", __ASSET__assets_images_9_maze_maze_chase_steps_maze_turn_1_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_maze_turn_1.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_steps_maze_turn_2.png", __ASSET__assets_images_9_maze_maze_chase_steps_maze_turn_2_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_maze_turn_2.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_steps_start.png", __ASSET__assets_images_9_maze_maze_chase_steps_start_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_start.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_steps_turn_1.png", __ASSET__assets_images_9_maze_maze_chase_steps_turn_1_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_turn_1.png", AssetType.IMAGE);
		className.set ("assets/images/9_Maze/maze_chase_steps_turn_2.png", __ASSET__assets_images_9_maze_maze_chase_steps_turn_2_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_turn_2.png", AssetType.IMAGE);
		className.set ("assets/images/A_Elevators/interstitial_elevators.png", __ASSET__assets_images_a_elevators_interstitial_elevators_png);
		type.set ("assets/images/A_Elevators/interstitial_elevators.png", AssetType.IMAGE);
		className.set ("assets/images/B_Redrum/interstitial_redrum.png", __ASSET__assets_images_b_redrum_interstitial_redrum_png);
		type.set ("assets/images/B_Redrum/interstitial_redrum.png", AssetType.IMAGE);
		className.set ("assets/images/preloader/click.png", __ASSET__assets_images_preloader_click_png);
		type.set ("assets/images/preloader/click.png", AssetType.IMAGE);
		className.set ("assets/images/preloader/loaded.png", __ASSET__assets_images_preloader_loaded_png);
		type.set ("assets/images/preloader/loaded.png", AssetType.IMAGE);
		className.set ("assets/images/preloader/loading.png", __ASSET__assets_images_preloader_loading_png);
		type.set ("assets/images/preloader/loading.png", AssetType.IMAGE);
		className.set ("assets/music/midnight.wav", __ASSET__assets_music_midnight_wav);
		type.set ("assets/music/midnight.wav", AssetType.SOUND);
		className.set ("assets/music/shining_theme.wav", __ASSET__assets_music_shining_theme_wav);
		type.set ("assets/music/shining_theme.wav", AssetType.SOUND);
		className.set ("assets/sounds/ball_bounce.wav", __ASSET__assets_sounds_ball_bounce_wav);
		type.set ("assets/sounds/ball_bounce.wav", AssetType.SOUND);
		className.set ("assets/sounds/ball_catch.wav", __ASSET__assets_sounds_ball_catch_wav);
		type.set ("assets/sounds/ball_catch.wav", AssetType.SOUND);
		className.set ("assets/sounds/ball_lost.wav", __ASSET__assets_sounds_ball_lost_wav);
		type.set ("assets/sounds/ball_lost.wav", AssetType.SOUND);
		className.set ("assets/sounds/ball_throw.wav", __ASSET__assets_sounds_ball_throw_wav);
		type.set ("assets/sounds/ball_throw.wav", AssetType.SOUND);
		className.set ("assets/sounds/bat_hit.wav", __ASSET__assets_sounds_bat_hit_wav);
		type.set ("assets/sounds/bat_hit.wav", AssetType.SOUND);
		className.set ("assets/sounds/bat_hit_high.wav", __ASSET__assets_sounds_bat_hit_high_wav);
		type.set ("assets/sounds/bat_hit_high.wav", AssetType.SOUND);
		className.set ("assets/sounds/bat_swing.wav", __ASSET__assets_sounds_bat_swing_wav);
		type.set ("assets/sounds/bat_swing.wav", AssetType.SOUND);
		className.set ("assets/sounds/elevator_buzz.wav", __ASSET__assets_sounds_elevator_buzz_wav);
		type.set ("assets/sounds/elevator_buzz.wav", AssetType.SOUND);
		className.set ("assets/sounds/laugh.wav", __ASSET__assets_sounds_laugh_wav);
		type.set ("assets/sounds/laugh.wav", AssetType.SOUND);
		className.set ("assets/sounds/scare.wav", __ASSET__assets_sounds_scare_wav);
		type.set ("assets/sounds/scare.wav", AssetType.SOUND);
		className.set ("assets/sounds/step_hard.wav", __ASSET__assets_sounds_step_hard_wav);
		type.set ("assets/sounds/step_hard.wav", AssetType.SOUND);
		className.set ("assets/sounds/step_soft.wav", __ASSET__assets_sounds_step_soft_wav);
		type.set ("assets/sounds/step_soft.wav", AssetType.SOUND);
		className.set ("assets/sounds/tricycle_hard.wav", __ASSET__assets_sounds_tricycle_hard_wav);
		type.set ("assets/sounds/tricycle_hard.wav", AssetType.SOUND);
		className.set ("assets/sounds/tricycle_hard2.wav", __ASSET__assets_sounds_tricycle_hard2_wav);
		type.set ("assets/sounds/tricycle_hard2.wav", AssetType.SOUND);
		className.set ("assets/sounds/tricycle_hard3.wav", __ASSET__assets_sounds_tricycle_hard3_wav);
		type.set ("assets/sounds/tricycle_hard3.wav", AssetType.SOUND);
		className.set ("Square", __ASSET__assets_fonts_commodore_ttf1);
		type.set ("Square", AssetType.FONT);
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		
		#elseif html5
		
		var id;
		id = "assets/data/data-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/fonts/Commodore.eot";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/fonts/Commodore.ttf";
		className.set (id, __ASSET__assets_fonts_commodore_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/Square.eot";
		path.set (id, id);
		
		type.set (id, AssetType.BINARY);
		id = "assets/fonts/Square.svg";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/fonts/Square.ttf";
		className.set (id, __ASSET__assets_fonts_square_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/fonts/Square.woff";
		path.set (id, id);
		
		type.set (id, AssetType.BINARY);
		id = "assets/images/0_Instructions/instructions_arrow_key.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/0_Instructions/instructions_space_bar.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/10_Final/final_jack.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/b_l_road.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/b_r_road.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/b_u_road.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/car.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/end_bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/end_road.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/l_u_road.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/lake_bottom.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/lake_bottom_left.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/lake_left.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/r_l_road.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/r_u_road.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/trees_green_bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/trees_lake_bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/1_Drive/trees_snow_bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/2_Throw/ball.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/2_Throw/throw_bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/2_Throw/throw_jack_animations.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/3_Maze/maze_walk_bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/3_Maze/maze_walk_bg_end.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/3_Maze/maze_walk_maze.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/3_Maze/maze_walk_maze_0.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/3_Maze/maze_walk_maze_1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/3_Maze/maze_walk_maze_2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/3_Maze/maze_walk_maze_3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/3_Maze/maze_walk_maze_4.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/3_Maze/maze_walk_maze_5.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/3_Maze/maze_walk_maze_end.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/3_Maze/maze_walk_walkcycle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/4_Tricycle/tricycle_carpet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/4_Tricycle/tricycle_corridor_corner.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/4_Tricycle/tricycle_corridor_straight.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/4_Tricycle/tricycle_corridor_t.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/4_Tricycle/tricycle_danny.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/4_Tricycle/tricycle_twins.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/4_Tricycle/tricycle_wood.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/5_Type/type_bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/5_Type/type_jack_typing.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/6_Room_237/room_237_bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/6_Room_237/room_237_hitmap.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/6_Room_237/room_237_jack_walk.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/6_Room_237/room_237_lady_walk.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/7_Bat/bat_bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/7_Bat/bat_jack.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/7_Bat/bat_wendy.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/8_Axe/axe_bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/8_Axe/axe_door.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/8_Axe/axe_jack.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_jack.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_maze_0.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_maze_1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_maze_2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_maze_3.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_maze_4.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_maze_5.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_steps_end.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_steps_maze_end.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_steps_maze_start.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_steps_maze_turn_1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_steps_maze_turn_2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_steps_start.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_steps_turn_1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/9_Maze/maze_chase_steps_turn_2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/A_Elevators/interstitial_elevators.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/B_Redrum/interstitial_redrum.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/preloader/click.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/preloader/loaded.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/preloader/loading.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/music/midnight.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/music/shining_theme.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/ball_bounce.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/ball_catch.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/ball_lost.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/ball_throw.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/bat_hit.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/bat_hit_high.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/bat_swing.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/elevator_buzz.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/laugh.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/scare.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/step_hard.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/step_soft.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/tricycle_hard.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/tricycle_hard2.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/tricycle_hard3.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "Square";
		className.set (id, __ASSET__assets_fonts_commodore_ttf1);
		
		type.set (id, AssetType.FONT);
		id = "assets/sounds/beep.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/flixel.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		
		
		var assetsPrefix = ApplicationMain.config.assetsPrefix;
		if (assetsPrefix != null) {
			for (k in path.keys()) {
				path.set(k, assetsPrefix + path[k]);
			}
		}
		
		#else
		
		#if openfl
		
		
		
		openfl.text.Font.registerFont (__ASSET__assets_fonts_commodore_ttf);
		
		
		openfl.text.Font.registerFont (__ASSET__assets_fonts_square_ttf);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__assets_fonts_commodore_ttf1);
		
		
		
		#end
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/fonts/Commodore.eot", __ASSET__assets_fonts_commodore_eot);
		type.set ("assets/fonts/Commodore.eot", AssetType.TEXT);
		
		className.set ("assets/fonts/Commodore.ttf", __ASSET__assets_fonts_commodore_ttf);
		type.set ("assets/fonts/Commodore.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/Square.eot", __ASSET__assets_fonts_square_eot);
		type.set ("assets/fonts/Square.eot", AssetType.BINARY);
		
		className.set ("assets/fonts/Square.svg", __ASSET__assets_fonts_square_svg);
		type.set ("assets/fonts/Square.svg", AssetType.TEXT);
		
		className.set ("assets/fonts/Square.ttf", __ASSET__assets_fonts_square_ttf);
		type.set ("assets/fonts/Square.ttf", AssetType.FONT);
		
		className.set ("assets/fonts/Square.woff", __ASSET__assets_fonts_square_woff);
		type.set ("assets/fonts/Square.woff", AssetType.BINARY);
		
		className.set ("assets/images/0_Instructions/instructions_arrow_key.png", __ASSET__assets_images_0_instructions_instructions_arrow_key_png);
		type.set ("assets/images/0_Instructions/instructions_arrow_key.png", AssetType.IMAGE);
		
		className.set ("assets/images/0_Instructions/instructions_space_bar.png", __ASSET__assets_images_0_instructions_instructions_space_bar_png);
		type.set ("assets/images/0_Instructions/instructions_space_bar.png", AssetType.IMAGE);
		
		className.set ("assets/images/10_Final/final_jack.png", __ASSET__assets_images_10_final_final_jack_png);
		type.set ("assets/images/10_Final/final_jack.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/b_l_road.png", __ASSET__assets_images_1_drive_b_l_road_png);
		type.set ("assets/images/1_Drive/b_l_road.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/b_r_road.png", __ASSET__assets_images_1_drive_b_r_road_png);
		type.set ("assets/images/1_Drive/b_r_road.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/b_u_road.png", __ASSET__assets_images_1_drive_b_u_road_png);
		type.set ("assets/images/1_Drive/b_u_road.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/car.png", __ASSET__assets_images_1_drive_car_png);
		type.set ("assets/images/1_Drive/car.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/end_bg.png", __ASSET__assets_images_1_drive_end_bg_png);
		type.set ("assets/images/1_Drive/end_bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/end_road.png", __ASSET__assets_images_1_drive_end_road_png);
		type.set ("assets/images/1_Drive/end_road.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/l_u_road.png", __ASSET__assets_images_1_drive_l_u_road_png);
		type.set ("assets/images/1_Drive/l_u_road.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/lake_bottom.png", __ASSET__assets_images_1_drive_lake_bottom_png);
		type.set ("assets/images/1_Drive/lake_bottom.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/lake_bottom_left.png", __ASSET__assets_images_1_drive_lake_bottom_left_png);
		type.set ("assets/images/1_Drive/lake_bottom_left.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/lake_left.png", __ASSET__assets_images_1_drive_lake_left_png);
		type.set ("assets/images/1_Drive/lake_left.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/r_l_road.png", __ASSET__assets_images_1_drive_r_l_road_png);
		type.set ("assets/images/1_Drive/r_l_road.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/r_u_road.png", __ASSET__assets_images_1_drive_r_u_road_png);
		type.set ("assets/images/1_Drive/r_u_road.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/trees_green_bg.png", __ASSET__assets_images_1_drive_trees_green_bg_png);
		type.set ("assets/images/1_Drive/trees_green_bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/trees_lake_bg.png", __ASSET__assets_images_1_drive_trees_lake_bg_png);
		type.set ("assets/images/1_Drive/trees_lake_bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/1_Drive/trees_snow_bg.png", __ASSET__assets_images_1_drive_trees_snow_bg_png);
		type.set ("assets/images/1_Drive/trees_snow_bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/2_Throw/ball.png", __ASSET__assets_images_2_throw_ball_png);
		type.set ("assets/images/2_Throw/ball.png", AssetType.IMAGE);
		
		className.set ("assets/images/2_Throw/throw_bg.png", __ASSET__assets_images_2_throw_throw_bg_png);
		type.set ("assets/images/2_Throw/throw_bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/2_Throw/throw_jack_animations.png", __ASSET__assets_images_2_throw_throw_jack_animations_png);
		type.set ("assets/images/2_Throw/throw_jack_animations.png", AssetType.IMAGE);
		
		className.set ("assets/images/3_Maze/maze_walk_bg.png", __ASSET__assets_images_3_maze_maze_walk_bg_png);
		type.set ("assets/images/3_Maze/maze_walk_bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/3_Maze/maze_walk_bg_end.png", __ASSET__assets_images_3_maze_maze_walk_bg_end_png);
		type.set ("assets/images/3_Maze/maze_walk_bg_end.png", AssetType.IMAGE);
		
		className.set ("assets/images/3_Maze/maze_walk_maze.png", __ASSET__assets_images_3_maze_maze_walk_maze_png);
		type.set ("assets/images/3_Maze/maze_walk_maze.png", AssetType.IMAGE);
		
		className.set ("assets/images/3_Maze/maze_walk_maze_0.png", __ASSET__assets_images_3_maze_maze_walk_maze_0_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_0.png", AssetType.IMAGE);
		
		className.set ("assets/images/3_Maze/maze_walk_maze_1.png", __ASSET__assets_images_3_maze_maze_walk_maze_1_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_1.png", AssetType.IMAGE);
		
		className.set ("assets/images/3_Maze/maze_walk_maze_2.png", __ASSET__assets_images_3_maze_maze_walk_maze_2_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_2.png", AssetType.IMAGE);
		
		className.set ("assets/images/3_Maze/maze_walk_maze_3.png", __ASSET__assets_images_3_maze_maze_walk_maze_3_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_3.png", AssetType.IMAGE);
		
		className.set ("assets/images/3_Maze/maze_walk_maze_4.png", __ASSET__assets_images_3_maze_maze_walk_maze_4_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_4.png", AssetType.IMAGE);
		
		className.set ("assets/images/3_Maze/maze_walk_maze_5.png", __ASSET__assets_images_3_maze_maze_walk_maze_5_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_5.png", AssetType.IMAGE);
		
		className.set ("assets/images/3_Maze/maze_walk_maze_end.png", __ASSET__assets_images_3_maze_maze_walk_maze_end_png);
		type.set ("assets/images/3_Maze/maze_walk_maze_end.png", AssetType.IMAGE);
		
		className.set ("assets/images/3_Maze/maze_walk_walkcycle.png", __ASSET__assets_images_3_maze_maze_walk_walkcycle_png);
		type.set ("assets/images/3_Maze/maze_walk_walkcycle.png", AssetType.IMAGE);
		
		className.set ("assets/images/4_Tricycle/tricycle_carpet.png", __ASSET__assets_images_4_tricycle_tricycle_carpet_png);
		type.set ("assets/images/4_Tricycle/tricycle_carpet.png", AssetType.IMAGE);
		
		className.set ("assets/images/4_Tricycle/tricycle_corridor_corner.png", __ASSET__assets_images_4_tricycle_tricycle_corridor_corner_png);
		type.set ("assets/images/4_Tricycle/tricycle_corridor_corner.png", AssetType.IMAGE);
		
		className.set ("assets/images/4_Tricycle/tricycle_corridor_straight.png", __ASSET__assets_images_4_tricycle_tricycle_corridor_straight_png);
		type.set ("assets/images/4_Tricycle/tricycle_corridor_straight.png", AssetType.IMAGE);
		
		className.set ("assets/images/4_Tricycle/tricycle_corridor_t.png", __ASSET__assets_images_4_tricycle_tricycle_corridor_t_png);
		type.set ("assets/images/4_Tricycle/tricycle_corridor_t.png", AssetType.IMAGE);
		
		className.set ("assets/images/4_Tricycle/tricycle_danny.png", __ASSET__assets_images_4_tricycle_tricycle_danny_png);
		type.set ("assets/images/4_Tricycle/tricycle_danny.png", AssetType.IMAGE);
		
		className.set ("assets/images/4_Tricycle/tricycle_twins.png", __ASSET__assets_images_4_tricycle_tricycle_twins_png);
		type.set ("assets/images/4_Tricycle/tricycle_twins.png", AssetType.IMAGE);
		
		className.set ("assets/images/4_Tricycle/tricycle_wood.png", __ASSET__assets_images_4_tricycle_tricycle_wood_png);
		type.set ("assets/images/4_Tricycle/tricycle_wood.png", AssetType.IMAGE);
		
		className.set ("assets/images/5_Type/type_bg.png", __ASSET__assets_images_5_type_type_bg_png);
		type.set ("assets/images/5_Type/type_bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/5_Type/type_jack_typing.png", __ASSET__assets_images_5_type_type_jack_typing_png);
		type.set ("assets/images/5_Type/type_jack_typing.png", AssetType.IMAGE);
		
		className.set ("assets/images/6_Room_237/room_237_bg.png", __ASSET__assets_images_6_room_237_room_237_bg_png);
		type.set ("assets/images/6_Room_237/room_237_bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/6_Room_237/room_237_hitmap.png", __ASSET__assets_images_6_room_237_room_237_hitmap_png);
		type.set ("assets/images/6_Room_237/room_237_hitmap.png", AssetType.IMAGE);
		
		className.set ("assets/images/6_Room_237/room_237_jack_walk.png", __ASSET__assets_images_6_room_237_room_237_jack_walk_png);
		type.set ("assets/images/6_Room_237/room_237_jack_walk.png", AssetType.IMAGE);
		
		className.set ("assets/images/6_Room_237/room_237_lady_walk.png", __ASSET__assets_images_6_room_237_room_237_lady_walk_png);
		type.set ("assets/images/6_Room_237/room_237_lady_walk.png", AssetType.IMAGE);
		
		className.set ("assets/images/7_Bat/bat_bg.png", __ASSET__assets_images_7_bat_bat_bg_png);
		type.set ("assets/images/7_Bat/bat_bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/7_Bat/bat_jack.png", __ASSET__assets_images_7_bat_bat_jack_png);
		type.set ("assets/images/7_Bat/bat_jack.png", AssetType.IMAGE);
		
		className.set ("assets/images/7_Bat/bat_wendy.png", __ASSET__assets_images_7_bat_bat_wendy_png);
		type.set ("assets/images/7_Bat/bat_wendy.png", AssetType.IMAGE);
		
		className.set ("assets/images/8_Axe/axe_bg.png", __ASSET__assets_images_8_axe_axe_bg_png);
		type.set ("assets/images/8_Axe/axe_bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/8_Axe/axe_door.png", __ASSET__assets_images_8_axe_axe_door_png);
		type.set ("assets/images/8_Axe/axe_door.png", AssetType.IMAGE);
		
		className.set ("assets/images/8_Axe/axe_jack.png", __ASSET__assets_images_8_axe_axe_jack_png);
		type.set ("assets/images/8_Axe/axe_jack.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_bg.png", __ASSET__assets_images_9_maze_maze_chase_bg_png);
		type.set ("assets/images/9_Maze/maze_chase_bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_jack.png", __ASSET__assets_images_9_maze_maze_chase_jack_png);
		type.set ("assets/images/9_Maze/maze_chase_jack.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_maze_0.png", __ASSET__assets_images_9_maze_maze_chase_maze_0_png);
		type.set ("assets/images/9_Maze/maze_chase_maze_0.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_maze_1.png", __ASSET__assets_images_9_maze_maze_chase_maze_1_png);
		type.set ("assets/images/9_Maze/maze_chase_maze_1.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_maze_2.png", __ASSET__assets_images_9_maze_maze_chase_maze_2_png);
		type.set ("assets/images/9_Maze/maze_chase_maze_2.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_maze_3.png", __ASSET__assets_images_9_maze_maze_chase_maze_3_png);
		type.set ("assets/images/9_Maze/maze_chase_maze_3.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_maze_4.png", __ASSET__assets_images_9_maze_maze_chase_maze_4_png);
		type.set ("assets/images/9_Maze/maze_chase_maze_4.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_maze_5.png", __ASSET__assets_images_9_maze_maze_chase_maze_5_png);
		type.set ("assets/images/9_Maze/maze_chase_maze_5.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_steps_end.png", __ASSET__assets_images_9_maze_maze_chase_steps_end_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_end.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_steps_maze_end.png", __ASSET__assets_images_9_maze_maze_chase_steps_maze_end_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_maze_end.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_steps_maze_start.png", __ASSET__assets_images_9_maze_maze_chase_steps_maze_start_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_maze_start.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_steps_maze_turn_1.png", __ASSET__assets_images_9_maze_maze_chase_steps_maze_turn_1_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_maze_turn_1.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_steps_maze_turn_2.png", __ASSET__assets_images_9_maze_maze_chase_steps_maze_turn_2_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_maze_turn_2.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_steps_start.png", __ASSET__assets_images_9_maze_maze_chase_steps_start_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_start.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_steps_turn_1.png", __ASSET__assets_images_9_maze_maze_chase_steps_turn_1_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_turn_1.png", AssetType.IMAGE);
		
		className.set ("assets/images/9_Maze/maze_chase_steps_turn_2.png", __ASSET__assets_images_9_maze_maze_chase_steps_turn_2_png);
		type.set ("assets/images/9_Maze/maze_chase_steps_turn_2.png", AssetType.IMAGE);
		
		className.set ("assets/images/A_Elevators/interstitial_elevators.png", __ASSET__assets_images_a_elevators_interstitial_elevators_png);
		type.set ("assets/images/A_Elevators/interstitial_elevators.png", AssetType.IMAGE);
		
		className.set ("assets/images/B_Redrum/interstitial_redrum.png", __ASSET__assets_images_b_redrum_interstitial_redrum_png);
		type.set ("assets/images/B_Redrum/interstitial_redrum.png", AssetType.IMAGE);
		
		className.set ("assets/images/preloader/click.png", __ASSET__assets_images_preloader_click_png);
		type.set ("assets/images/preloader/click.png", AssetType.IMAGE);
		
		className.set ("assets/images/preloader/loaded.png", __ASSET__assets_images_preloader_loaded_png);
		type.set ("assets/images/preloader/loaded.png", AssetType.IMAGE);
		
		className.set ("assets/images/preloader/loading.png", __ASSET__assets_images_preloader_loading_png);
		type.set ("assets/images/preloader/loading.png", AssetType.IMAGE);
		
		className.set ("assets/music/midnight.wav", __ASSET__assets_music_midnight_wav);
		type.set ("assets/music/midnight.wav", AssetType.SOUND);
		
		className.set ("assets/music/shining_theme.wav", __ASSET__assets_music_shining_theme_wav);
		type.set ("assets/music/shining_theme.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/ball_bounce.wav", __ASSET__assets_sounds_ball_bounce_wav);
		type.set ("assets/sounds/ball_bounce.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/ball_catch.wav", __ASSET__assets_sounds_ball_catch_wav);
		type.set ("assets/sounds/ball_catch.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/ball_lost.wav", __ASSET__assets_sounds_ball_lost_wav);
		type.set ("assets/sounds/ball_lost.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/ball_throw.wav", __ASSET__assets_sounds_ball_throw_wav);
		type.set ("assets/sounds/ball_throw.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/bat_hit.wav", __ASSET__assets_sounds_bat_hit_wav);
		type.set ("assets/sounds/bat_hit.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/bat_hit_high.wav", __ASSET__assets_sounds_bat_hit_high_wav);
		type.set ("assets/sounds/bat_hit_high.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/bat_swing.wav", __ASSET__assets_sounds_bat_swing_wav);
		type.set ("assets/sounds/bat_swing.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/elevator_buzz.wav", __ASSET__assets_sounds_elevator_buzz_wav);
		type.set ("assets/sounds/elevator_buzz.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/laugh.wav", __ASSET__assets_sounds_laugh_wav);
		type.set ("assets/sounds/laugh.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/scare.wav", __ASSET__assets_sounds_scare_wav);
		type.set ("assets/sounds/scare.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/step_hard.wav", __ASSET__assets_sounds_step_hard_wav);
		type.set ("assets/sounds/step_hard.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/step_soft.wav", __ASSET__assets_sounds_step_soft_wav);
		type.set ("assets/sounds/step_soft.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/tricycle_hard.wav", __ASSET__assets_sounds_tricycle_hard_wav);
		type.set ("assets/sounds/tricycle_hard.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/tricycle_hard2.wav", __ASSET__assets_sounds_tricycle_hard2_wav);
		type.set ("assets/sounds/tricycle_hard2.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/tricycle_hard3.wav", __ASSET__assets_sounds_tricycle_hard3_wav);
		type.set ("assets/sounds/tricycle_hard3.wav", AssetType.SOUND);
		
		className.set ("Square", __ASSET__assets_fonts_commodore_ttf1);
		type.set ("Square", AssetType.FONT);
		
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && requestedType == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return AudioBuffer.fromFile (path.get (id));
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Dynamic /*Font*/ {
		
		// TODO: Complete Lime Font API
		
		#if openfl
		#if (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), openfl.text.Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			openfl.text.Font.registerFont (fontClass);
			return cast (Type.createInstance (fontClass, []), openfl.text.Font);
			
		} else {
			
			return new openfl.text.Font (path.get (id));
			
		}
		
		#end
		#end
		
		return null;
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		return Image.fromFile (path.get (id));
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String, handler:AudioBuffer -> Void):Void {
		
		#if (flash)
		if (path.exists (id)) {
			
			var soundLoader = new Sound ();
			soundLoader.addEventListener (Event.COMPLETE, function (event) {
				
				var audioBuffer:AudioBuffer = new AudioBuffer();
				audioBuffer.src = event.currentTarget;
				handler (audioBuffer);
				
			});
			soundLoader.load (new URLRequest (path.get (id)));
			
		} else {
			handler (getAudioBuffer (id));
			
		}
		#else
		handler (getAudioBuffer (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadImage (id:String, handler:Image -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				handler (Image.fromBitmapData (bitmapData));
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getImage (id));
			
		}
		
		#else
		
		handler (getImage (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = ByteArray.readFile ("../Resources/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	/*public override function loadMusic (id:String, handler:Dynamic -> Void):Void {
		
		#if (flash || js)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}*/
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		//#if html5
		
		/*if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}*/
		
		//#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		//#end
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_commodore_eot extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_commodore_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_square_eot extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_square_svg extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_square_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_square_woff extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_0_instructions_instructions_arrow_key_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_0_instructions_instructions_space_bar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_10_final_final_jack_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_b_l_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_b_r_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_b_u_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_car_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_end_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_end_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_l_u_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_lake_bottom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_lake_bottom_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_lake_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_r_l_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_r_u_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_trees_green_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_trees_lake_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_1_drive_trees_snow_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_2_throw_ball_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_2_throw_throw_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_2_throw_throw_jack_animations_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_3_maze_maze_walk_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_3_maze_maze_walk_bg_end_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_end_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_3_maze_maze_walk_walkcycle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_carpet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_corridor_corner_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_corridor_straight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_corridor_t_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_danny_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_twins_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_wood_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_5_type_type_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_5_type_type_jack_typing_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_6_room_237_room_237_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_6_room_237_room_237_hitmap_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_6_room_237_room_237_jack_walk_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_6_room_237_room_237_lady_walk_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_7_bat_bat_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_7_bat_bat_jack_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_7_bat_bat_wendy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_8_axe_axe_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_8_axe_axe_door_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_8_axe_axe_jack_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_jack_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_end_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_maze_end_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_maze_start_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_maze_turn_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_maze_turn_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_start_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_turn_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_turn_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_a_elevators_interstitial_elevators_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_b_redrum_interstitial_redrum_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_preloader_click_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_preloader_loaded_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_preloader_loading_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_music_midnight_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_music_shining_theme_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_ball_bounce_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_ball_catch_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_ball_lost_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_ball_throw_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_bat_hit_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_bat_hit_high_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_bat_swing_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_elevator_buzz_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_laugh_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_scare_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_step_hard_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_step_soft_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_tricycle_hard_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_tricycle_hard2_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_tricycle_hard3_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_commodore_ttf1 extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound { }


#elseif html5

#if openfl


@:keep #if display private #end class __ASSET__assets_fonts_commodore_ttf extends openfl.text.Font { public function new () { super (); fontName = "Commodore 64 Pixelized"; } } 


@:keep #if display private #end class __ASSET__assets_fonts_square_ttf extends openfl.text.Font { public function new () { super (); fontName = "SquareFont"; } } 


























































































@:keep #if display private #end class __ASSET__assets_fonts_commodore_ttf1 extends openfl.text.Font { public function new () { super (); fontName = "Commodore 64 Pixelized"; } } 



#end

#else

#if openfl
@:keep class __ASSET__assets_fonts_commodore_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/Commodore.ttf"; fontName = "Commodore 64 Pixelized"; }}
@:keep class __ASSET__assets_fonts_square_ttf extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/Square.ttf"; fontName = "SquareFont"; }}
@:keep class __ASSET__assets_fonts_commodore_ttf1 extends openfl.text.Font { public function new () { super (); __fontPath = "assets/fonts/Commodore.ttf"; fontName = "Commodore 64 Pixelized"; }}

#end

#if (windows || mac || linux)


@:file("assets/data/data-goes-here.txt") class __ASSET__assets_data_data_goes_here_txt extends lime.utils.ByteArray {}
@:file("assets/fonts/Commodore.eot") class __ASSET__assets_fonts_commodore_eot extends lime.utils.ByteArray {}
@:font("assets/fonts/Commodore.ttf") class __ASSET__assets_fonts_commodore_ttf extends lime.graphics.Font {}
@:file("assets/fonts/Square.eot") class __ASSET__assets_fonts_square_eot extends lime.utils.ByteArray {}
@:file("assets/fonts/Square.svg") class __ASSET__assets_fonts_square_svg extends lime.utils.ByteArray {}
@:font("assets/fonts/Square.ttf") class __ASSET__assets_fonts_square_ttf extends lime.graphics.Font {}
@:file("assets/fonts/Square.woff") class __ASSET__assets_fonts_square_woff extends lime.utils.ByteArray {}
@:bitmap("assets/images/0_Instructions/instructions_arrow_key.png") class __ASSET__assets_images_0_instructions_instructions_arrow_key_png extends lime.graphics.Image {}
@:bitmap("assets/images/0_Instructions/instructions_space_bar.png") class __ASSET__assets_images_0_instructions_instructions_space_bar_png extends lime.graphics.Image {}
@:bitmap("assets/images/10_Final/final_jack.png") class __ASSET__assets_images_10_final_final_jack_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/b_l_road.png") class __ASSET__assets_images_1_drive_b_l_road_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/b_r_road.png") class __ASSET__assets_images_1_drive_b_r_road_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/b_u_road.png") class __ASSET__assets_images_1_drive_b_u_road_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/car.png") class __ASSET__assets_images_1_drive_car_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/end_bg.png") class __ASSET__assets_images_1_drive_end_bg_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/end_road.png") class __ASSET__assets_images_1_drive_end_road_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/l_u_road.png") class __ASSET__assets_images_1_drive_l_u_road_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/lake_bottom.png") class __ASSET__assets_images_1_drive_lake_bottom_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/lake_bottom_left.png") class __ASSET__assets_images_1_drive_lake_bottom_left_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/lake_left.png") class __ASSET__assets_images_1_drive_lake_left_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/r_l_road.png") class __ASSET__assets_images_1_drive_r_l_road_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/r_u_road.png") class __ASSET__assets_images_1_drive_r_u_road_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/trees_green_bg.png") class __ASSET__assets_images_1_drive_trees_green_bg_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/trees_lake_bg.png") class __ASSET__assets_images_1_drive_trees_lake_bg_png extends lime.graphics.Image {}
@:bitmap("assets/images/1_Drive/trees_snow_bg.png") class __ASSET__assets_images_1_drive_trees_snow_bg_png extends lime.graphics.Image {}
@:bitmap("assets/images/2_Throw/ball.png") class __ASSET__assets_images_2_throw_ball_png extends lime.graphics.Image {}
@:bitmap("assets/images/2_Throw/throw_bg.png") class __ASSET__assets_images_2_throw_throw_bg_png extends lime.graphics.Image {}
@:bitmap("assets/images/2_Throw/throw_jack_animations.png") class __ASSET__assets_images_2_throw_throw_jack_animations_png extends lime.graphics.Image {}
@:bitmap("assets/images/3_Maze/maze_walk_bg.png") class __ASSET__assets_images_3_maze_maze_walk_bg_png extends lime.graphics.Image {}
@:bitmap("assets/images/3_Maze/maze_walk_bg_end.png") class __ASSET__assets_images_3_maze_maze_walk_bg_end_png extends lime.graphics.Image {}
@:bitmap("assets/images/3_Maze/maze_walk_maze.png") class __ASSET__assets_images_3_maze_maze_walk_maze_png extends lime.graphics.Image {}
@:bitmap("assets/images/3_Maze/maze_walk_maze_0.png") class __ASSET__assets_images_3_maze_maze_walk_maze_0_png extends lime.graphics.Image {}
@:bitmap("assets/images/3_Maze/maze_walk_maze_1.png") class __ASSET__assets_images_3_maze_maze_walk_maze_1_png extends lime.graphics.Image {}
@:bitmap("assets/images/3_Maze/maze_walk_maze_2.png") class __ASSET__assets_images_3_maze_maze_walk_maze_2_png extends lime.graphics.Image {}
@:bitmap("assets/images/3_Maze/maze_walk_maze_3.png") class __ASSET__assets_images_3_maze_maze_walk_maze_3_png extends lime.graphics.Image {}
@:bitmap("assets/images/3_Maze/maze_walk_maze_4.png") class __ASSET__assets_images_3_maze_maze_walk_maze_4_png extends lime.graphics.Image {}
@:bitmap("assets/images/3_Maze/maze_walk_maze_5.png") class __ASSET__assets_images_3_maze_maze_walk_maze_5_png extends lime.graphics.Image {}
@:bitmap("assets/images/3_Maze/maze_walk_maze_end.png") class __ASSET__assets_images_3_maze_maze_walk_maze_end_png extends lime.graphics.Image {}
@:bitmap("assets/images/3_Maze/maze_walk_walkcycle.png") class __ASSET__assets_images_3_maze_maze_walk_walkcycle_png extends lime.graphics.Image {}
@:bitmap("assets/images/4_Tricycle/tricycle_carpet.png") class __ASSET__assets_images_4_tricycle_tricycle_carpet_png extends lime.graphics.Image {}
@:bitmap("assets/images/4_Tricycle/tricycle_corridor_corner.png") class __ASSET__assets_images_4_tricycle_tricycle_corridor_corner_png extends lime.graphics.Image {}
@:bitmap("assets/images/4_Tricycle/tricycle_corridor_straight.png") class __ASSET__assets_images_4_tricycle_tricycle_corridor_straight_png extends lime.graphics.Image {}
@:bitmap("assets/images/4_Tricycle/tricycle_corridor_t.png") class __ASSET__assets_images_4_tricycle_tricycle_corridor_t_png extends lime.graphics.Image {}
@:bitmap("assets/images/4_Tricycle/tricycle_danny.png") class __ASSET__assets_images_4_tricycle_tricycle_danny_png extends lime.graphics.Image {}
@:bitmap("assets/images/4_Tricycle/tricycle_twins.png") class __ASSET__assets_images_4_tricycle_tricycle_twins_png extends lime.graphics.Image {}
@:bitmap("assets/images/4_Tricycle/tricycle_wood.png") class __ASSET__assets_images_4_tricycle_tricycle_wood_png extends lime.graphics.Image {}
@:bitmap("assets/images/5_Type/type_bg.png") class __ASSET__assets_images_5_type_type_bg_png extends lime.graphics.Image {}
@:bitmap("assets/images/5_Type/type_jack_typing.png") class __ASSET__assets_images_5_type_type_jack_typing_png extends lime.graphics.Image {}
@:bitmap("assets/images/6_Room_237/room_237_bg.png") class __ASSET__assets_images_6_room_237_room_237_bg_png extends lime.graphics.Image {}
@:bitmap("assets/images/6_Room_237/room_237_hitmap.png") class __ASSET__assets_images_6_room_237_room_237_hitmap_png extends lime.graphics.Image {}
@:bitmap("assets/images/6_Room_237/room_237_jack_walk.png") class __ASSET__assets_images_6_room_237_room_237_jack_walk_png extends lime.graphics.Image {}
@:bitmap("assets/images/6_Room_237/room_237_lady_walk.png") class __ASSET__assets_images_6_room_237_room_237_lady_walk_png extends lime.graphics.Image {}
@:bitmap("assets/images/7_Bat/bat_bg.png") class __ASSET__assets_images_7_bat_bat_bg_png extends lime.graphics.Image {}
@:bitmap("assets/images/7_Bat/bat_jack.png") class __ASSET__assets_images_7_bat_bat_jack_png extends lime.graphics.Image {}
@:bitmap("assets/images/7_Bat/bat_wendy.png") class __ASSET__assets_images_7_bat_bat_wendy_png extends lime.graphics.Image {}
@:bitmap("assets/images/8_Axe/axe_bg.png") class __ASSET__assets_images_8_axe_axe_bg_png extends lime.graphics.Image {}
@:bitmap("assets/images/8_Axe/axe_door.png") class __ASSET__assets_images_8_axe_axe_door_png extends lime.graphics.Image {}
@:bitmap("assets/images/8_Axe/axe_jack.png") class __ASSET__assets_images_8_axe_axe_jack_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_bg.png") class __ASSET__assets_images_9_maze_maze_chase_bg_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_jack.png") class __ASSET__assets_images_9_maze_maze_chase_jack_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_maze_0.png") class __ASSET__assets_images_9_maze_maze_chase_maze_0_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_maze_1.png") class __ASSET__assets_images_9_maze_maze_chase_maze_1_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_maze_2.png") class __ASSET__assets_images_9_maze_maze_chase_maze_2_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_maze_3.png") class __ASSET__assets_images_9_maze_maze_chase_maze_3_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_maze_4.png") class __ASSET__assets_images_9_maze_maze_chase_maze_4_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_maze_5.png") class __ASSET__assets_images_9_maze_maze_chase_maze_5_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_steps_end.png") class __ASSET__assets_images_9_maze_maze_chase_steps_end_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_steps_maze_end.png") class __ASSET__assets_images_9_maze_maze_chase_steps_maze_end_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_steps_maze_start.png") class __ASSET__assets_images_9_maze_maze_chase_steps_maze_start_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_steps_maze_turn_1.png") class __ASSET__assets_images_9_maze_maze_chase_steps_maze_turn_1_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_steps_maze_turn_2.png") class __ASSET__assets_images_9_maze_maze_chase_steps_maze_turn_2_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_steps_start.png") class __ASSET__assets_images_9_maze_maze_chase_steps_start_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_steps_turn_1.png") class __ASSET__assets_images_9_maze_maze_chase_steps_turn_1_png extends lime.graphics.Image {}
@:bitmap("assets/images/9_Maze/maze_chase_steps_turn_2.png") class __ASSET__assets_images_9_maze_maze_chase_steps_turn_2_png extends lime.graphics.Image {}
@:bitmap("assets/images/A_Elevators/interstitial_elevators.png") class __ASSET__assets_images_a_elevators_interstitial_elevators_png extends lime.graphics.Image {}
@:bitmap("assets/images/B_Redrum/interstitial_redrum.png") class __ASSET__assets_images_b_redrum_interstitial_redrum_png extends lime.graphics.Image {}
@:bitmap("assets/images/preloader/click.png") class __ASSET__assets_images_preloader_click_png extends lime.graphics.Image {}
@:bitmap("assets/images/preloader/loaded.png") class __ASSET__assets_images_preloader_loaded_png extends lime.graphics.Image {}
@:bitmap("assets/images/preloader/loading.png") class __ASSET__assets_images_preloader_loading_png extends lime.graphics.Image {}
@:sound("assets/music/midnight.wav") class __ASSET__assets_music_midnight_wav extends lime.audio.AudioSource {}
@:sound("assets/music/shining_theme.wav") class __ASSET__assets_music_shining_theme_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/ball_bounce.wav") class __ASSET__assets_sounds_ball_bounce_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/ball_catch.wav") class __ASSET__assets_sounds_ball_catch_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/ball_lost.wav") class __ASSET__assets_sounds_ball_lost_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/ball_throw.wav") class __ASSET__assets_sounds_ball_throw_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/bat_hit.wav") class __ASSET__assets_sounds_bat_hit_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/bat_hit_high.wav") class __ASSET__assets_sounds_bat_hit_high_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/bat_swing.wav") class __ASSET__assets_sounds_bat_swing_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/elevator_buzz.wav") class __ASSET__assets_sounds_elevator_buzz_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/laugh.wav") class __ASSET__assets_sounds_laugh_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/scare.wav") class __ASSET__assets_sounds_scare_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/step_hard.wav") class __ASSET__assets_sounds_step_hard_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/step_soft.wav") class __ASSET__assets_sounds_step_soft_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/tricycle_hard.wav") class __ASSET__assets_sounds_tricycle_hard_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/tricycle_hard2.wav") class __ASSET__assets_sounds_tricycle_hard2_wav extends lime.audio.AudioSource {}
@:sound("assets/sounds/tricycle_hard3.wav") class __ASSET__assets_sounds_tricycle_hard3_wav extends lime.audio.AudioSource {}
@:font("assets/fonts/Commodore.ttf") class __ASSET__assets_fonts_commodore_ttf1 extends lime.graphics.Font {}
@:sound("/usr/lib/haxe/lib/flixel/3,3,6/assets/sounds/beep.mp3") class __ASSET__assets_sounds_beep_mp3 extends lime.audio.AudioSource {}
@:sound("/usr/lib/haxe/lib/flixel/3,3,6/assets/sounds/flixel.mp3") class __ASSET__assets_sounds_flixel_mp3 extends lime.audio.AudioSource {}



#end

#end
#end

