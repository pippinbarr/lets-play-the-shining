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

class FourPMState extends FlxState
{
	private var redrum:FlxSprite;

	private var caption:FlxText;
	private var black:FlxSprite;

	private var redrumPlaying:Bool = false;

	private var redrumSound:FlxSound;
	private var scareSound:FlxSound;

	override public function create():Void
	{
		super.create();

		redrum = new FlxSprite().loadGraphic(AssetPaths.interstitial_redrum__png, true, 30, 30);
		redrum.origin.x = redrum.origin.y = 0;
		redrum.scale.x = redrum.scale.y = 16;
		redrum.visible = false;

		caption = new FlxText(0, 0, FlxG.width, "4PM");
		caption.setFormat(AssetPaths.Commodore__ttf, 24, 0xFFFFFFFF, "center");
		caption.y = FlxG.height / 2 - caption.height / 2;
		caption.visible = true;

		black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		black.visible = true;

		add(black);
		add(caption);
		add(redrum);

		scareSound = new FlxSound().loadEmbedded(AssetPaths.scare__wav, false);
		redrumSound = new FlxSound().loadEmbedded(AssetPaths.elevator_buzz__wav, true);

		new FlxTimer().start(3, blackToRedrum);
	}

	override public function destroy():Void
	{
		super.destroy();

		redrum.destroy();
		caption.destroy();
		black.destroy();
		redrumSound.destroy();
		scareSound.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	private function blackToRedrum(t:FlxTimer):Void
	{
		black.visible = false;
		caption.visible = false;
		redrum.visible = true;
		redrumPlaying = true;

		redrumSound.play();

		new FlxTimer().start(2, redrumToMurder);
	}

	private function redrumToMurder(t:FlxTimer):Void
	{
		redrumSound.stop();
		scareSound.play();
		redrum.animation.frameIndex = 1;
		new FlxTimer().start(0.2, redrumToBlack);
	}

	private function redrumToBlack(t:FlxTimer):Void
	{
		redrum.visible = false;
		black.visible = true;

		new FlxTimer().start(3, nextState);
	}

	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new AxeState());
	}
}
