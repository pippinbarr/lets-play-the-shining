package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;



class TrailerState extends FlxState
{
	private var elevators:FlxSprite;
	private var black:FlxSprite;
	private var elevatorSound:FlxSound;
	private var elevatorsPlaying:Bool = false;

	private var hotel:FlxSprite;
	private var road:FlxSprite;

	private var themeMusic:FlxSound;

	private var superTitleText:FlxText;
	private var subTitleText:FlxText;
	private var titleText:FlxText;
	private var titleIn:Bool = false;


	override public function create():Void
	{		
		super.create();
		
		elevators = new FlxSprite().loadGraphic(AssetPaths.interstitial_elevators__png,true,30,30);
		elevators.animation.add("blood",[0,11,0,11,0,11,1,11,2,11,3,11,4,11,5,11,6,11,7,11,8,11,9,11,10],3,false);
		elevators.origin.x = elevators.origin.y = 0;
		elevators.scale.x = elevators.scale.y = 16;

		black = new FlxSprite().makeGraphic(FlxG.width,FlxG.height,0xFF000000);
		black.visible = true;

		hotel = new FlxSprite().loadGraphic("assets/images/1_Drive/" + "end_bg" + ".png");
		hotel.visible = false;
		road = new FlxSprite().loadGraphic("assets/images/1_Drive/" + "end_road" + ".png");
		road.visible = false;

		superTitleText = new FlxText(0,0,FlxG.width,"LET'S PLAY:");
		superTitleText.setFormat("Square",24,0xFF2255FF,"center");
		superTitleText.y = 60;
		superTitleText.moves = true;
		superTitleText.visible = false;

		titleText = new FlxText(0,0,FlxG.width,"THE SHINING");
		titleText.setFormat("Square",48,0xFF2255FF,"center");
		titleText.y = FlxG.height;
		titleText.moves = true;

		subTitleText = new FlxText(0,0,FlxG.width,"A PIPPIN BARR GAME");
		subTitleText.setFormat("Square",18,0xFF2255FF,"center");
		subTitleText.moves = false;
		subTitleText.visible = false;

		add(elevators);
		add(black);
		add(hotel);
		add(road);

		add(superTitleText);
		add(titleText);
		add(subTitleText);


		elevatorSound = new FlxSound().loadEmbedded(AssetPaths.elevator_buzz__wav,true);
		themeMusic = new FlxSound().loadEmbedded(AssetPaths.shining_theme__wav,false);
		themeMusic.onComplete = themeMusicComplete;

		new FlxTimer(0.1,blackToElevators);
	}


	override public function destroy():Void
	{
		super.destroy();

		elevatorSound.destroy();
		elevators.destroy();
		black.destroy();
	}


	override public function update():Void
	{
		super.update();

		if (elevatorsPlaying && elevators.animation.finished)
		{
			elevatorsPlaying = false;
			new FlxTimer(2,blackToHotel);
		}

		checkTitle();
	}


	private function blackToElevators(t:FlxTimer):Void
	{
		black.visible = false;
		elevators.animation.play("blood");
		elevatorSound.play();
		elevatorsPlaying = true;
	}


	private function blackToHotel(t:FlxTimer):Void
	{
		black.visible = true;
		elevatorSound.stop();

		new FlxTimer(3,startTitle);
	}


	private function hotelToBlack(t:FlxTimer):Void
	{
		FlxG.switchState(new ThrowState());
	}


	private function startTitle(t:FlxTimer):Void
	{
		hotel.visible = true;
		road.visible = true;

		titleIn = true;
		titleText.velocity.y = -40;
		themeMusic.play();
	}


	private function checkTitle():Void
	{
		if (!titleIn) return;

		if (titleText.y <= superTitleText.y + superTitleText.height + superTitleText.height*0.5)
		{
			// titleText.y = superTitleText.y + superTitleText.height + superTitleText.height*0.5;
			titleText.velocity.y = 0;
			displaySuperTitle(null);
			titleIn = false;
		}
	}


	private function displaySuperTitle(t:FlxTimer):Void
	{
		superTitleText.visible = true;

		new FlxTimer(2,displaySubTitle);
	}


	private function displaySubTitle(t:FlxTimer):Void
	{
		subTitleText.y = titleText.y + titleText.height;
		subTitleText.visible = true;

		// FlxTween.tween(themeMusic, {volume: 0}, 3);
	}


	private function themeMusicComplete():Void
	{
		FlxG.camera.fade(0xFF000000,0.1);
	}
}
