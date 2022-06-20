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

class SaturdayState extends FlxState
{
	private var caption:FlxText;
	private var black:FlxSprite;

	override public function create():Void
	{
		super.create();

		caption = new FlxText(0, 0, FlxG.width, "SATURDAY");
		caption.setFormat(AssetPaths.Commodore__ttf, 24, 0xFFFFFFFF, "center");
		caption.y = FlxG.height / 2 - caption.height / 2;
		caption.visible = true;

		black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		black.visible = true;

		add(black);
		add(caption);

		new FlxTimer().start(3, nextState);
	}

	override public function destroy():Void
	{
		super.destroy();

		caption.destroy();
		black.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new TricycleState());
	}
}
