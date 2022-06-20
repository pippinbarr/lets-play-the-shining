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



class AxeState extends FlxState
{
	private var jack:FlxSprite;
	private var door:FlxSprite;
	private var black:FlxSprite;

	private var inputEnabled:Bool = true;

	private var axeSound:FlxSound;
	private var scareSound:FlxSound;

	override public function create():Void
	{		
		super.create();

		var bg:FlxSprite = new FlxSprite(0,0,AssetPaths.axe_bg__png);
		
		door = new FlxSprite(52*4,76*4).loadGraphic(AssetPaths.axe_door__png,true,16*4,26*4);

		jack = new FlxSprite(42*4,70*4).loadGraphic(AssetPaths.axe_jack__png,true,29*4,32*4);

		black = new FlxSprite().makeGraphic(FlxG.width,FlxG.height,0xFF000000);
		black.visible = false;

		add(bg);
		add(door);
		add(jack);
		add(black);

		axeSound = new FlxSound().loadEmbedded(AssetPaths.step_hard__wav,false);
		scareSound = new FlxSound().loadEmbedded(AssetPaths.scare__wav,false);


	}


	override public function destroy():Void
	{
		super.destroy();

		jack.destroy();
		door.destroy();
		black.destroy();
		axeSound.destroy();
		scareSound.destroy();
	}


	override public function update():Void
	{
		super.update();

		handleInput();
	}


	private function handleInput():Void
	{
		if (!inputEnabled) return;

		if ((FlxG.keys.justPressed.LEFT && jack.animation.frameIndex == 0) ||
			(FlxG.keys.justPressed.UP && jack.animation.frameIndex == 1) ||
			(FlxG.keys.justPressed.RIGHT && jack.animation.frameIndex == 2) ||
			(FlxG.keys.justPressed.DOWN && jack.animation.frameIndex == 3))
		{
			jack.animation.frameIndex = (jack.animation.frameIndex + 1) % (jack.animation.frames - 1);

			if (jack.animation.frameIndex == 3)
			{
				door.animation.frameIndex = (door.animation.frameIndex + 1) % door.animation.frames;
				axeSound.play();
			}
		}

		if (door.animation.frameIndex == door.animation.frames - 1)
		{
			inputEnabled = false;
			new FlxTimer(0.5,lowerAxe);
		}
	}


	private function lowerAxe(t:FlxTimer):Void
	{
		jack.animation.frameIndex = 0;

		new FlxTimer(2,lookThrough);
	}


	private function lookThrough(t:FlxTimer):Void
	{
		jack.x += 2*4;
		jack.animation.frameIndex = 4;
		// flixel.effects.FlxFlicker.flicker(door,100,0.25);
		scareSound.play();
		
		new FlxTimer(3,toBlack);
	}


	private function toBlack(t:FlxTimer):Void
	{
		black.visible = true;
		new FlxTimer(3,nextState);
	}


	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new MazeChaseState());
	}




}
