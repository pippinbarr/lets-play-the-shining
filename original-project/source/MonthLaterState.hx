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



class MonthLaterState extends FlxState
{
	private var elevators:FlxSprite;

	private var caption:FlxText;
	private var black:FlxSprite;

	private var elevatorSound:FlxSound;

	private var elevatorsPlaying:Bool = false;




	override public function create():Void
	{
		super.create();
		

		elevators = new FlxSprite().loadGraphic(AssetPaths.interstitial_elevators__png,true,30,30);
		elevators.animation.add("blood",[0,11,0,11,0,11,1,11,2,11,3,11,4,11,5,11,6,11,7,11,8,11,9,11,10],3,false);
		elevators.origin.x = elevators.origin.y = 0;
		elevators.scale.x = elevators.scale.y = 16;

		caption = new FlxText(0,0,FlxG.width,"A MONTH LATER");
		caption.setFormat("Square",24,0xFFFFFFFF,"center");
		caption.y = FlxG.height / 2 - caption.height/2;
		caption.visible = false;

		black = new FlxSprite().makeGraphic(FlxG.width,FlxG.height,0xFF000000);
		black.visible = true;

		add(elevators);
		add(black);
		add(caption);


		elevatorSound = new FlxSound().loadEmbedded(AssetPaths.elevator_buzz__wav,true);

		new FlxTimer(3,blackToElevators);
	}


	override public function destroy():Void
	{
		super.destroy();

		elevatorSound.destroy();
		elevators.destroy();
		caption.destroy();
		black.destroy();
	}


	override public function update():Void
	{
		super.update();

		if (elevatorsPlaying && elevators.animation.finished)
		{
			elevatorsPlaying = false;
			new FlxTimer(2,blackToMonthLater);
		}
	}


	private function blackToElevators(t:FlxTimer):Void
	{
		black.visible = false;
		elevators.animation.play("blood");
		elevatorSound.play();
		elevatorsPlaying = true;
	}


	private function blackToMonthLater(t:FlxTimer):Void
	{
		black.visible = true;
		caption.visible = true;
		elevatorSound.stop();

		new FlxTimer(3,monthLaterToBallThrow);
	}


	private function monthLaterToBallThrow(t:FlxTimer):Void
	{
		FlxG.switchState(new ThrowState());
	}

}
