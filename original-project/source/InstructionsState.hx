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
import flixel.effects.FlxFlicker;



class InstructionsState extends FlxState
{
	private var instructions:FlxText;

	private var leftArrow:FlxSprite;
	private var rightArrow:FlxSprite;
	private var upArrow:FlxSprite;
	private var downArrow:FlxSprite;
	private var spacebar:FlxSprite;


	override public function create():Void
	{		
		super.create();

		FlxG.stage.displayState = FULL_SCREEN_INTERACTIVE;

		FlxG.camera.bgColor = 0xFF000000;

		instructions = new FlxText(0,100,FlxG.width,
			"This game is played with\nthe arrow keys and spacebar.\n\nPress them to begin.");
		instructions.setFormat("Square",18,0xFFFFFFFF,"center");

		leftArrow = new FlxSprite().loadGraphic(AssetPaths.instructions_arrow_key__png,true,9*4,9*4);
		rightArrow = new FlxSprite().loadGraphic(AssetPaths.instructions_arrow_key__png,true,9*4,9*4);
		rightArrow.angle = 180;
		upArrow = new FlxSprite().loadGraphic(AssetPaths.instructions_arrow_key__png,true,9*4,9*4);
		upArrow.angle = 90;
		downArrow = new FlxSprite().loadGraphic(AssetPaths.instructions_arrow_key__png,true,9*4,9*4);
		downArrow.angle = -90;
		spacebar = new FlxSprite().loadGraphic(AssetPaths.instructions_space_bar__png,true,45*4,9*4);


		spacebar.x = 58*4;
		spacebar.y = 300;

		downArrow.x = spacebar.x - 32 - 2*leftArrow.width - 2*8;
		downArrow.y = spacebar.y;
		leftArrow.x = downArrow.x - 8 - leftArrow.width;
		leftArrow.y = downArrow.y;
		rightArrow.x = downArrow.x + downArrow.width + 8;
		rightArrow.y = downArrow.y;
		upArrow.x = downArrow.x;
		upArrow.y = downArrow.y - 8 - upArrow.height;

		add(instructions);
		add(leftArrow);
		add(rightArrow);
		add(upArrow);
		add(downArrow);
		add(spacebar);
	}


	override public function destroy():Void
	{
		super.destroy();

		instructions.destroy();
		leftArrow.destroy();
		rightArrow.destroy();
		upArrow.destroy();
		downArrow.destroy();
		spacebar.destroy();
	}


	override public function update():Void
	{
		super.update();

		handleInput();

		if (
			leftArrow.animation.frameIndex == 1 &&
			rightArrow.animation.frameIndex == 1 &&
			upArrow.animation.frameIndex == 1 &&
			downArrow.animation.frameIndex == 1 &&
			spacebar.animation.frameIndex == 1)
		{
			FlxG.camera.fade(0xFF000000,2,false,toBlack);
		}
	}


	private function handleInput():Void
	{
		if (FlxG.keys.pressed.LEFT) leftArrow.animation.frameIndex = 1;
		if (FlxG.keys.pressed.RIGHT) rightArrow.animation.frameIndex = 1;
		if (FlxG.keys.pressed.UP) upArrow.animation.frameIndex = 1;
		if (FlxG.keys.pressed.DOWN) downArrow.animation.frameIndex = 1;
		if (FlxG.keys.pressed.SPACE) spacebar.animation.frameIndex = 1;
	}


	private function toBlack():Void
	{
		new FlxTimer(2,nextState);
	}


	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new DriveState());
	}

}
