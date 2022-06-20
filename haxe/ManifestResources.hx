package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_commodore_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:sizei5685292y4:typey5:SOUNDy2:idy29:assets%2Fmusic%2Fmidnight.wavy9:pathGroupaR4hy7:preloadtgoR0i3842092R1R2R3y34:assets%2Fmusic%2Fshining_theme.wavR5aR7hR6tgoy4:pathy40:assets%2Fimages%2Fpreloader%2Floaded.pngR0i7351R1y5:IMAGER3R9R6tgoR8y39:assets%2Fimages%2Fpreloader%2Fclick.pngR0i7285R1R10R3R11R6tgoR8y41:assets%2Fimages%2Fpreloader%2Floading.pngR0i7592R1R10R3R12R6tgoR8y43:assets%2Fimages%2F10_Final%2Ffinal_jack.pngR0i11193R1R10R3R13R6tgoR8y53:assets%2Fimages%2F6_Room_237%2Froom_237_jack_walk.pngR0i2429R1R10R3R14R6tgoR8y46:assets%2Fimages%2F6_Room_237%2Froom_237_bg.pngR0i7699R1R10R3R15R6tgoR8y50:assets%2Fimages%2F6_Room_237%2Froom_237_hitmap.pngR0i6926R1R10R3R16R6tgoR8y53:assets%2Fimages%2F6_Room_237%2Froom_237_lady_walk.pngR0i2116R1R10R3R17R6tgoR8y36:assets%2Fimages%2F8_Axe%2Faxe_bg.pngR0i6038R1R10R3R18R6tgoR8y38:assets%2Fimages%2F8_Axe%2Faxe_door.pngR0i3649R1R10R3R19R6tgoR8y38:assets%2Fimages%2F8_Axe%2Faxe_jack.pngR0i3327R1R10R3R20R6tgoR8y58:assets%2Fimages%2FA_Elevators%2Finterstitial_elevators.pngR0i2206R1R10R3R21R6tgoR8y39:assets%2Fimages%2F7_Bat%2Fbat_wendy.pngR0i2955R1R10R3R22R6tgoR8y38:assets%2Fimages%2F7_Bat%2Fbat_jack.pngR0i3221R1R10R3R23R6tgoR8y36:assets%2Fimages%2F7_Bat%2Fbat_bg.pngR0i7061R1R10R3R24R6tgoR8y59:assets%2Fimages%2F9_Maze%2Fmaze_chase_steps_maze_turn_1.pngR0i6651R1R10R3R25R6tgoR8y56:assets%2Fimages%2F9_Maze%2Fmaze_chase_steps_maze_end.pngR0i6598R1R10R3R26R6tgoR8y59:assets%2Fimages%2F9_Maze%2Fmaze_chase_steps_maze_turn_2.pngR0i6673R1R10R3R27R6tgoR8y51:assets%2Fimages%2F9_Maze%2Fmaze_chase_steps_end.pngR0i5367R1R10R3R28R6tgoR8y54:assets%2Fimages%2F9_Maze%2Fmaze_chase_steps_turn_2.pngR0i5642R1R10R3R29R6tgoR8y54:assets%2Fimages%2F9_Maze%2Fmaze_chase_steps_turn_1.pngR0i5630R1R10R3R30R6tgoR8y44:assets%2Fimages%2F9_Maze%2Fmaze_chase_bg.pngR0i6033R1R10R3R31R6tgoR8y48:assets%2Fimages%2F9_Maze%2Fmaze_chase_maze_3.pngR0i6560R1R10R3R32R6tgoR8y58:assets%2Fimages%2F9_Maze%2Fmaze_chase_steps_maze_start.pngR0i6419R1R10R3R33R6tgoR8y53:assets%2Fimages%2F9_Maze%2Fmaze_chase_steps_start.pngR0i5196R1R10R3R34R6tgoR8y48:assets%2Fimages%2F9_Maze%2Fmaze_chase_maze_2.pngR0i6866R1R10R3R35R6tgoR8y48:assets%2Fimages%2F9_Maze%2Fmaze_chase_maze_0.pngR0i6419R1R10R3R36R6tgoR8y48:assets%2Fimages%2F9_Maze%2Fmaze_chase_maze_1.pngR0i6909R1R10R3R37R6tgoR8y48:assets%2Fimages%2F9_Maze%2Fmaze_chase_maze_5.pngR0i6913R1R10R3R38R6tgoR8y48:assets%2Fimages%2F9_Maze%2Fmaze_chase_maze_4.pngR0i7002R1R10R3R39R6tgoR8y46:assets%2Fimages%2F9_Maze%2Fmaze_chase_jack.pngR0i2695R1R10R3R40R6tgoR8y47:assets%2Fimages%2F5_Type%2Ftype_jack_typing.pngR0i2098R1R10R3R41R6tgoR8y38:assets%2Fimages%2F5_Type%2Ftype_bg.pngR0i6039R1R10R3R42R6tgoR8y36:assets%2Fimages%2F2_Throw%2Fball.pngR0i1100R1R10R3R43R6tgoR8y40:assets%2Fimages%2F2_Throw%2Fthrow_bg.pngR0i1861R1R10R3R44R6tgoR8y53:assets%2Fimages%2F2_Throw%2Fthrow_jack_animations.pngR0i1723R1R10R3R45R6tgoR8y38:assets%2Fimages%2F1_Drive%2Fend_bg.pngR0i8322R1R10R3R46R6tgoR8y40:assets%2Fimages%2F1_Drive%2Fb_u_road.pngR0i7406R1R10R3R47R6tgoR8y40:assets%2Fimages%2F1_Drive%2Fb_l_road.pngR0i6435R1R10R3R48R6tgoR8y45:assets%2Fimages%2F1_Drive%2Ftrees_snow_bg.pngR0i9513R1R10R3R49R6tgoR8y43:assets%2Fimages%2F1_Drive%2Flake_bottom.pngR0i5440R1R10R3R50R6tgoR8y46:assets%2Fimages%2F1_Drive%2Ftrees_green_bg.pngR0i9533R1R10R3R51R6tgoR8y45:assets%2Fimages%2F1_Drive%2Ftrees_lake_bg.pngR0i9533R1R10R3R52R6tgoR8y40:assets%2Fimages%2F1_Drive%2Fb_r_road.pngR0i6443R1R10R3R53R6tgoR8y41:assets%2Fimages%2F1_Drive%2Flake_left.pngR0i6676R1R10R3R54R6tgoR8y35:assets%2Fimages%2F1_Drive%2Fcar.pngR0i1126R1R10R3R55R6tgoR8y40:assets%2Fimages%2F1_Drive%2Fr_l_road.pngR0i5379R1R10R3R56R6tgoR8y40:assets%2Fimages%2F1_Drive%2Fl_u_road.pngR0i6447R1R10R3R57R6tgoR8y40:assets%2Fimages%2F1_Drive%2Fend_road.pngR0i5989R1R10R3R58R6tgoR8y40:assets%2Fimages%2F1_Drive%2Fr_u_road.pngR0i6467R1R10R3R59R6tgoR8y48:assets%2Fimages%2F1_Drive%2Flake_bottom_left.pngR0i5437R1R10R3R60R6tgoR8y50:assets%2Fimages%2F3_Maze%2Fmaze_walk_walkcycle.pngR0i3205R1R10R3R61R6tgoR8y45:assets%2Fimages%2F3_Maze%2Fmaze_walk_maze.pngR0i6597R1R10R3R62R6tgoR8y47:assets%2Fimages%2F3_Maze%2Fmaze_walk_bg_end.pngR0i6828R1R10R3R63R6tgoR8y49:assets%2Fimages%2F3_Maze%2Fmaze_walk_maze_end.pngR0i6440R1R10R3R64R6tgoR8y43:assets%2Fimages%2F3_Maze%2Fmaze_walk_bg.pngR0i6034R1R10R3R65R6tgoR8y47:assets%2Fimages%2F3_Maze%2Fmaze_walk_maze_3.pngR0i6573R1R10R3R66R6tgoR8y47:assets%2Fimages%2F3_Maze%2Fmaze_walk_maze_2.pngR0i6882R1R10R3R67R6tgoR8y47:assets%2Fimages%2F3_Maze%2Fmaze_walk_maze_0.pngR0i6432R1R10R3R68R6tgoR8y47:assets%2Fimages%2F3_Maze%2Fmaze_walk_maze_1.pngR0i6924R1R10R3R69R6tgoR8y47:assets%2Fimages%2F3_Maze%2Fmaze_walk_maze_5.pngR0i6929R1R10R3R70R6tgoR8y47:assets%2Fimages%2F3_Maze%2Fmaze_walk_maze_4.pngR0i7018R1R10R3R71R6tgoR8y52:assets%2Fimages%2FB_Redrum%2Finterstitial_redrum.pngR0i1354R1R10R3R72R6tgoR8y49:assets%2Fimages%2F4_Tricycle%2Ftricycle_danny.pngR0i2344R1R10R3R73R6tgoR8y50:assets%2Fimages%2F4_Tricycle%2Ftricycle_carpet.pngR0i8496R1R10R3R74R6tgoR8y49:assets%2Fimages%2F4_Tricycle%2Ftricycle_twins.pngR0i1399R1R10R3R75R6tgoR8y61:assets%2Fimages%2F4_Tricycle%2Ftricycle_corridor_straight.pngR0i7003R1R10R3R76R6tgoR8y54:assets%2Fimages%2F4_Tricycle%2Ftricycle_corridor_t.pngR0i6160R1R10R3R77R6tgoR8y48:assets%2Fimages%2F4_Tricycle%2Ftricycle_wood.pngR0i5652R1R10R3R78R6tgoR8y59:assets%2Fimages%2F4_Tricycle%2Ftricycle_corridor_corner.pngR0i6687R1R10R3R79R6tgoR8y61:assets%2Fimages%2F0_Instructions%2Finstructions_arrow_key.pngR0i1341R1R10R3R80R6tgoR8y61:assets%2Fimages%2F0_Instructions%2Finstructions_space_bar.pngR0i1502R1R10R3R81R6tgoR0i17130R1R2R3y33:assets%2Fsounds%2Fball_bounce.wavR5aR82hR6tgoR0i10188R1R2R3y34:assets%2Fsounds%2Fbat_hit_high.wavR5aR83hR6tgoR0i17184R1R2R3y32:assets%2Fsounds%2Fball_throw.wavR5aR84hR6tgoR0i126424R1R2R3y27:assets%2Fsounds%2Flaugh.wavR5aR85hR6tgoR0i18586R1R2R3y31:assets%2Fsounds%2Fbat_swing.wavR5aR86hR6tgoR0i38870R1R2R3y31:assets%2Fsounds%2Fball_lost.wavR5aR87hR6tgoR0i30980R1R2R3y27:assets%2Fsounds%2Fscare.wavR5aR88hR6tgoR0i17130R1R2R3y32:assets%2Fsounds%2Fball_catch.wavR5aR89hR6tgoR0i10188R1R2R3y29:assets%2Fsounds%2Fbat_hit.wavR5aR90hR6tgoR0i88244R1R2R3y36:assets%2Fsounds%2Ftricycle_hard3.wavR5aR91hR6tgoR0i88244R1R2R3y36:assets%2Fsounds%2Ftricycle_hard2.wavR5aR92hR6tgoR0i88244R1R2R3y35:assets%2Fsounds%2Ftricycle_hard.wavR5aR93hR6tgoR0i10188R1R2R3y31:assets%2Fsounds%2Fstep_hard.wavR5aR94hR6tgoR0i8864R1R2R3y35:assets%2Fsounds%2Felevator_buzz.wavR5aR95hR6tgoR0i4454R1R2R3y31:assets%2Fsounds%2Fstep_soft.wavR5aR96hR6tgoR8y30:assets%2Ffonts%2FCommodore.eotR0zR1y4:TEXTR3R97R6tgoR0i20324R1y4:FONTy9:classNamey35:__ASSET__assets_fonts_commodore_ttfR3y30:assets%2Ffonts%2FCommodore.ttfR6tgoR8y34:assets%2Fdata%2Fdata-goes-here.txtR0zR1R98R3R103R6tgoR0i39706R1y5:MUSICR3y28:flixel%2Fsounds%2Fflixel.mp3R5aR105y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR0i2114R1R104R3y26:flixel%2Fsounds%2Fbeep.mp3R5aR107y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR0i5794R1R2R3R108R5aR107R108hgoR0i33629R1R2R3R106R5aR105R106hgoR0i15744R1R99R100y35:__ASSET__flixel_fonts_nokiafc22_ttfR3y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR0i29724R1R99R100y36:__ASSET__flixel_fonts_monsterrat_ttfR3y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR8y33:flixel%2Fimages%2Fui%2Fbutton.pngR0i519R1R10R3R113R6tgoR8y36:flixel%2Fimages%2Flogo%2Fdefault.pngR0i3280R1R10R3R114R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_midnight_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_shining_theme_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_preloader_loaded_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_preloader_click_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_preloader_loading_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_10_final_final_jack_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_6_room_237_room_237_jack_walk_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_6_room_237_room_237_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_6_room_237_room_237_hitmap_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_6_room_237_room_237_lady_walk_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_8_axe_axe_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_8_axe_axe_door_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_8_axe_axe_jack_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_a_elevators_interstitial_elevators_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_7_bat_bat_wendy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_7_bat_bat_jack_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_7_bat_bat_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_maze_turn_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_maze_end_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_maze_turn_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_end_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_turn_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_turn_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_maze_start_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_start_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_jack_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_5_type_type_jack_typing_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_5_type_type_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_2_throw_ball_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_2_throw_throw_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_2_throw_throw_jack_animations_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_end_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_b_u_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_b_l_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_trees_snow_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_lake_bottom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_trees_green_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_trees_lake_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_b_r_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_lake_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_car_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_r_l_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_l_u_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_end_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_r_u_road_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_lake_bottom_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_walkcycle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_bg_end_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_end_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_b_redrum_interstitial_redrum_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_danny_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_carpet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_twins_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_corridor_straight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_corridor_t_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_wood_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_corridor_corner_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_0_instructions_instructions_arrow_key_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_0_instructions_instructions_space_bar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_ball_bounce_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_bat_hit_high_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_ball_throw_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_laugh_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_bat_swing_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_ball_lost_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_scare_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_ball_catch_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_bat_hit_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_tricycle_hard3_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_tricycle_hard2_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_tricycle_hard_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_step_hard_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_elevator_buzz_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_step_soft_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_commodore_eot extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_commodore_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/music/midnight.wav") @:noCompletion #if display private #end class __ASSET__assets_music_midnight_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/shining_theme.wav") @:noCompletion #if display private #end class __ASSET__assets_music_shining_theme_wav extends haxe.io.Bytes {}
@:keep @:image("assets/images/preloader/loaded.png") @:noCompletion #if display private #end class __ASSET__assets_images_preloader_loaded_png extends lime.graphics.Image {}
@:keep @:image("assets/images/preloader/click.png") @:noCompletion #if display private #end class __ASSET__assets_images_preloader_click_png extends lime.graphics.Image {}
@:keep @:image("assets/images/preloader/loading.png") @:noCompletion #if display private #end class __ASSET__assets_images_preloader_loading_png extends lime.graphics.Image {}
@:keep @:image("assets/images/10_Final/final_jack.png") @:noCompletion #if display private #end class __ASSET__assets_images_10_final_final_jack_png extends lime.graphics.Image {}
@:keep @:image("assets/images/6_Room_237/room_237_jack_walk.png") @:noCompletion #if display private #end class __ASSET__assets_images_6_room_237_room_237_jack_walk_png extends lime.graphics.Image {}
@:keep @:image("assets/images/6_Room_237/room_237_bg.png") @:noCompletion #if display private #end class __ASSET__assets_images_6_room_237_room_237_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/6_Room_237/room_237_hitmap.png") @:noCompletion #if display private #end class __ASSET__assets_images_6_room_237_room_237_hitmap_png extends lime.graphics.Image {}
@:keep @:image("assets/images/6_Room_237/room_237_lady_walk.png") @:noCompletion #if display private #end class __ASSET__assets_images_6_room_237_room_237_lady_walk_png extends lime.graphics.Image {}
@:keep @:image("assets/images/8_Axe/axe_bg.png") @:noCompletion #if display private #end class __ASSET__assets_images_8_axe_axe_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/8_Axe/axe_door.png") @:noCompletion #if display private #end class __ASSET__assets_images_8_axe_axe_door_png extends lime.graphics.Image {}
@:keep @:image("assets/images/8_Axe/axe_jack.png") @:noCompletion #if display private #end class __ASSET__assets_images_8_axe_axe_jack_png extends lime.graphics.Image {}
@:keep @:image("assets/images/A_Elevators/interstitial_elevators.png") @:noCompletion #if display private #end class __ASSET__assets_images_a_elevators_interstitial_elevators_png extends lime.graphics.Image {}
@:keep @:image("assets/images/7_Bat/bat_wendy.png") @:noCompletion #if display private #end class __ASSET__assets_images_7_bat_bat_wendy_png extends lime.graphics.Image {}
@:keep @:image("assets/images/7_Bat/bat_jack.png") @:noCompletion #if display private #end class __ASSET__assets_images_7_bat_bat_jack_png extends lime.graphics.Image {}
@:keep @:image("assets/images/7_Bat/bat_bg.png") @:noCompletion #if display private #end class __ASSET__assets_images_7_bat_bat_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_steps_maze_turn_1.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_maze_turn_1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_steps_maze_end.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_maze_end_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_steps_maze_turn_2.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_maze_turn_2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_steps_end.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_end_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_steps_turn_2.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_turn_2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_steps_turn_1.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_turn_1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_bg.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_maze_3.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_steps_maze_start.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_maze_start_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_steps_start.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_steps_start_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_maze_2.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_maze_0.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_maze_1.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_maze_5.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_5_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_maze_4.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_maze_4_png extends lime.graphics.Image {}
@:keep @:image("assets/images/9_Maze/maze_chase_jack.png") @:noCompletion #if display private #end class __ASSET__assets_images_9_maze_maze_chase_jack_png extends lime.graphics.Image {}
@:keep @:image("assets/images/5_Type/type_jack_typing.png") @:noCompletion #if display private #end class __ASSET__assets_images_5_type_type_jack_typing_png extends lime.graphics.Image {}
@:keep @:image("assets/images/5_Type/type_bg.png") @:noCompletion #if display private #end class __ASSET__assets_images_5_type_type_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/2_Throw/ball.png") @:noCompletion #if display private #end class __ASSET__assets_images_2_throw_ball_png extends lime.graphics.Image {}
@:keep @:image("assets/images/2_Throw/throw_bg.png") @:noCompletion #if display private #end class __ASSET__assets_images_2_throw_throw_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/2_Throw/throw_jack_animations.png") @:noCompletion #if display private #end class __ASSET__assets_images_2_throw_throw_jack_animations_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/end_bg.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_end_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/b_u_road.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_b_u_road_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/b_l_road.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_b_l_road_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/trees_snow_bg.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_trees_snow_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/lake_bottom.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_lake_bottom_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/trees_green_bg.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_trees_green_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/trees_lake_bg.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_trees_lake_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/b_r_road.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_b_r_road_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/lake_left.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_lake_left_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/car.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_car_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/r_l_road.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_r_l_road_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/l_u_road.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_l_u_road_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/end_road.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_end_road_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/r_u_road.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_r_u_road_png extends lime.graphics.Image {}
@:keep @:image("assets/images/1_Drive/lake_bottom_left.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_drive_lake_bottom_left_png extends lime.graphics.Image {}
@:keep @:image("assets/images/3_Maze/maze_walk_walkcycle.png") @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_walkcycle_png extends lime.graphics.Image {}
@:keep @:image("assets/images/3_Maze/maze_walk_maze.png") @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_png extends lime.graphics.Image {}
@:keep @:image("assets/images/3_Maze/maze_walk_bg_end.png") @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_bg_end_png extends lime.graphics.Image {}
@:keep @:image("assets/images/3_Maze/maze_walk_maze_end.png") @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_end_png extends lime.graphics.Image {}
@:keep @:image("assets/images/3_Maze/maze_walk_bg.png") @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/3_Maze/maze_walk_maze_3.png") @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/3_Maze/maze_walk_maze_2.png") @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/3_Maze/maze_walk_maze_0.png") @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/3_Maze/maze_walk_maze_1.png") @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/3_Maze/maze_walk_maze_5.png") @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_5_png extends lime.graphics.Image {}
@:keep @:image("assets/images/3_Maze/maze_walk_maze_4.png") @:noCompletion #if display private #end class __ASSET__assets_images_3_maze_maze_walk_maze_4_png extends lime.graphics.Image {}
@:keep @:image("assets/images/B_Redrum/interstitial_redrum.png") @:noCompletion #if display private #end class __ASSET__assets_images_b_redrum_interstitial_redrum_png extends lime.graphics.Image {}
@:keep @:image("assets/images/4_Tricycle/tricycle_danny.png") @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_danny_png extends lime.graphics.Image {}
@:keep @:image("assets/images/4_Tricycle/tricycle_carpet.png") @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_carpet_png extends lime.graphics.Image {}
@:keep @:image("assets/images/4_Tricycle/tricycle_twins.png") @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_twins_png extends lime.graphics.Image {}
@:keep @:image("assets/images/4_Tricycle/tricycle_corridor_straight.png") @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_corridor_straight_png extends lime.graphics.Image {}
@:keep @:image("assets/images/4_Tricycle/tricycle_corridor_t.png") @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_corridor_t_png extends lime.graphics.Image {}
@:keep @:image("assets/images/4_Tricycle/tricycle_wood.png") @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_wood_png extends lime.graphics.Image {}
@:keep @:image("assets/images/4_Tricycle/tricycle_corridor_corner.png") @:noCompletion #if display private #end class __ASSET__assets_images_4_tricycle_tricycle_corridor_corner_png extends lime.graphics.Image {}
@:keep @:image("assets/images/0_Instructions/instructions_arrow_key.png") @:noCompletion #if display private #end class __ASSET__assets_images_0_instructions_instructions_arrow_key_png extends lime.graphics.Image {}
@:keep @:image("assets/images/0_Instructions/instructions_space_bar.png") @:noCompletion #if display private #end class __ASSET__assets_images_0_instructions_instructions_space_bar_png extends lime.graphics.Image {}
@:keep @:file("assets/sounds/ball_bounce.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_ball_bounce_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/bat_hit_high.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_bat_hit_high_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/ball_throw.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_ball_throw_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/laugh.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_laugh_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/bat_swing.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_bat_swing_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/ball_lost.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_ball_lost_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/scare.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_scare_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/ball_catch.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_ball_catch_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/bat_hit.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_bat_hit_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/tricycle_hard3.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_tricycle_hard3_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/tricycle_hard2.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_tricycle_hard2_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/tricycle_hard.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_tricycle_hard_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/step_hard.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_step_hard_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/elevator_buzz.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_elevator_buzz_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/step_soft.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_step_soft_wav extends haxe.io.Bytes {}
@:keep @:file("assets/fonts/Commodore.eot") @:noCompletion #if display private #end class __ASSET__assets_fonts_commodore_eot extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/Commodore.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_commodore_ttf extends lime.text.Font {}
@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("/usr/local/lib/haxe/lib/flixel/4,11,0/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("/usr/local/lib/haxe/lib/flixel/4,11,0/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("/usr/local/lib/haxe/lib/flixel/4,11,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("/usr/local/lib/haxe/lib/flixel/4,11,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("/usr/local/lib/haxe/lib/flixel/4,11,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("/usr/local/lib/haxe/lib/flixel/4,11,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_fonts_commodore_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_commodore_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Commodore"; #else ascender = 1800; descender = -200; height = 2000; numGlyphs = 204; underlinePosition = -156; underlineThickness = 22; unitsPerEM = 2048; #end name = "Commodore 64 Pixelized"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_fonts_commodore_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_commodore_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_commodore_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_fonts_commodore_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_commodore_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_commodore_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
