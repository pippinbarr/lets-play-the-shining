package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxTimer;

class EightAMState extends FlxState
{
	private var elevators:FlxSprite;
	private var redrum:FlxSprite;

	private var caption:FlxText;
	private var black:FlxSprite;

	private var elevatorSound:FlxSound;
	private var scareSound:FlxSound;

	private var elevatorsPlaying:Bool = false;

	override public function create():Void
	{
		super.create();

		elevators = new FlxSprite().loadGraphic(AssetPaths.interstitial_elevators__png, true, 30, 30);
		elevators.animation.add("blood", [
			0, 11, 0, 11, 0, 11, 1, 11, 2, 11, 3, 11, 4, 11, 5, 11, 6, 11, 7, 11, 8, 11, 9, 11, 10
		], 3, false);
		elevators.origin.x = elevators.origin.y = 0;
		elevators.scale.x = elevators.scale.y = 16;

		redrum = new FlxSprite().loadGraphic(AssetPaths.interstitial_redrum__png, true, 30, 30);
		redrum.origin.x = redrum.origin.y = 0;
		redrum.scale.x = redrum.scale.y = 16;
		redrum.visible = false;

		caption = new FlxText(0, 0, FlxG.width, "8AM");
		caption.setFormat(AssetPaths.Commodore__ttf, 24, 0xFFFFFFFF, "center");
		caption.y = FlxG.height / 2 - caption.height / 2;
		caption.visible = false;

		black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		black.visible = true;

		add(elevators);
		add(black);
		add(caption);
		add(redrum);

		elevatorSound = new FlxSound().loadEmbedded(AssetPaths.elevator_buzz__wav, true);
		scareSound = new FlxSound().loadEmbedded(AssetPaths.scare__wav, false);

		new FlxTimer().start(3, blackToElevators);
	}

	override public function destroy():Void
	{
		super.destroy();

		elevators.destroy();
		redrum.destroy();
		caption.destroy();
		black.destroy();
		elevatorSound.destroy();
		scareSound.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (elevatorsPlaying && elevators.animation.finished)
		{
			elevatorsPlaying = false;
			new FlxTimer().start(1, elevatorsToRedrum);
		}
	}

	private function blackToElevators(t:FlxTimer):Void
	{
		black.visible = false;
		elevators.animation.play("blood");
		elevatorSound.play();
		elevatorsPlaying = true;
	}

	private function elevatorsToRedrum(t:FlxTimer):Void
	{
		elevators.visible = false;
		redrum.visible = true;
		elevatorSound.stop();
		scareSound.play();

		new FlxTimer().start(0.2, redrumToEightAM);
	}

	private function redrumToEightAM(t:FlxTimer):Void
	{
		redrum.visible = false;
		black.visible = true;
		caption.visible = true;

		elevatorSound.stop();

		new FlxTimer().start(3, nextState);
	}

	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new BatState());
	}
}
