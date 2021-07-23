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



class TuesdayState extends FlxState
{

	private var caption:FlxText;
	private var black:FlxSprite;

	private var scareSound:FlxSound;

	override public function create():Void
	{		
		super.create();

		caption = new FlxText(0,0,FlxG.width,"TUESDAY");
		caption.setFormat("Square",24,0xFFFFFFFF,"center");
		caption.y = FlxG.height / 2 - caption.height/2;
		caption.visible = true;

		black = new FlxSprite().makeGraphic(FlxG.width,FlxG.height,0xFF000000);
		black.visible = true;

		add(black);
		add(caption);


		scareSound = new FlxSound().loadEmbedded(AssetPaths.scare__wav,false);
		scareSound.play();

		new FlxTimer(3,nextState);
	}


	override public function destroy():Void
	{
		super.destroy();

		caption.destroy();
		black.destroy();

	}


	override public function update():Void
	{
		super.update();
	}


	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new TypeState());
	}

}
