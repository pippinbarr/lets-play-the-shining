package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.FlxFlicker;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxTimer;

class MazeWalkState extends FlxState
{
	private static var WALK_SPEED:Int = 100;
	private static var MIN_MAZE_SCREENS:Int = 5;

	private var bg:FlxSprite;
	private var maze:FlxSprite;
	private var wendyDanny:FlxSprite;
	private var wendyDannyHit:FlxSprite;

	private var leftTrigger:FlxSprite;
	private var rightTrigger:FlxSprite;
	private var upTrigger:FlxSprite;
	private var downTrigger:FlxSprite;

	private var arrivalTrigger:FlxSprite;

	private var mazeScreens:Int = 0;
	private var completed:Bool = false;
	private var endTrigger:FlxSprite;
	private var checkEndTrigger:Bool = false;

	private var movementEnabled = true;

	private var stepSound:FlxSound;
	private var stepPlayed:Bool = false;

	override public function create():Void
	{
		super.create();

		FlxG.camera.antialiasing = false;

		bg = new FlxSprite(0, 0, "assets/images/3_Maze/maze_walk_bg.png");
		// bg = new FlxSprite(0,0,"assets/images/1_Drive/end_bg.png");
		bg.origin.x = bg.origin.y = 0;
		add(bg);

		maze = new FlxSprite(0, 0, "assets/images/3_Maze/maze_walk_maze_0.png");
		// road = new FlxSprite(0,0,"assets/images/1_Drive/end_road.png");
		add(maze);

		leftTrigger = new FlxSprite(0, 0);
		leftTrigger.makeGraphic(10, Std.int(FlxG.height / 3), 0xFF00FF00);
		leftTrigger.x = -leftTrigger.width;
		leftTrigger.y = FlxG.height / 3;
		add(leftTrigger);

		rightTrigger = new FlxSprite(0, 0);
		rightTrigger.makeGraphic(10, Std.int(FlxG.height / 3), 0xFF00FF00);
		rightTrigger.x = FlxG.width;
		rightTrigger.y = FlxG.height / 3;
		add(rightTrigger);

		upTrigger = new FlxSprite(0, 0);
		upTrigger.makeGraphic(Std.int(FlxG.width / 3), 10, 0xFF00FF00);
		upTrigger.x = FlxG.width / 3;
		upTrigger.y = -upTrigger.height;
		add(upTrigger);

		downTrigger = new FlxSprite(0, 0);
		downTrigger.makeGraphic(Std.int(FlxG.width / 3), 10, 0xFF00FF00);
		downTrigger.x = FlxG.width / 3;
		downTrigger.y = FlxG.height;
		add(downTrigger);

		endTrigger = new FlxSprite().makeGraphic(64, 64, 0xFFFF0000);
		endTrigger.x = FlxG.width / 2 - endTrigger.width / 2;
		endTrigger.y = FlxG.height / 2 - endTrigger.height / 2;
		endTrigger.visible = false;
		add(endTrigger);

		wendyDanny = new FlxSprite().loadGraphic(AssetPaths.maze_walk_walkcycle__png, true, 16 * 4, 22 * 4);
		wendyDanny.animation.add("idle-left", [0, 0], 1, false);
		wendyDanny.animation.add("walk-left", [1, 2, 3], 20, true);
		wendyDanny.animation.add("idle-right", [4, 4], 1, false);
		wendyDanny.animation.add("walk-right", [5, 6, 7], 20, true);
		wendyDanny.animation.play("idle-right");
		wendyDanny.x = 200;
		wendyDanny.y = 200;
		add(wendyDanny);

		wendyDannyHit = new FlxSprite().makeGraphic(Std.int(wendyDanny.width), Std.int(wendyDanny.height), 0xFFFF0000);
		wendyDannyHit.x = wendyDanny.x;
		wendyDannyHit.y = wendyDanny.y;
		wendyDannyHit.visible = false;
		add(wendyDannyHit);

		stepSound = new FlxSound().loadEmbedded(AssetPaths.step_soft__wav, false);
		stepSound.volume = 0.3;
	}

	override public function destroy():Void
	{
		super.destroy();

		bg.destroy();
		maze.destroy();
		wendyDanny.destroy();
		wendyDannyHit.destroy();
		leftTrigger.destroy();
		rightTrigger.destroy();
		upTrigger.destroy();
		downTrigger.destroy();
		arrivalTrigger.destroy();
		endTrigger.destroy();
		stepSound.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		wendyDannyHit.x = wendyDanny.x;
		wendyDannyHit.y = wendyDanny.y;

		// if (maze.pixelsOverlapPoint(new FlxPoint(wendyDanny.x + wendyDanny.width/2,wendyDanny.y + wendyDanny.height/2)))
		if (FlxG.pixelPerfectOverlap(maze, wendyDannyHit))
		{
			wendyDanny.x -= 2 * (wendyDanny.velocity.x * FlxG.elapsed);
			wendyDanny.y -= 2 * (wendyDanny.velocity.y * FlxG.elapsed);
		}
		else
		{
			moveLinear();
		}

		checkTriggers();

		if ((wendyDanny.animation.frameIndex == 2 || wendyDanny.animation.frameIndex == 6))
		{
			if (!stepPlayed)
			{
				stepPlayed = true;
				stepSound.play();
			}
		}
		else
		{
			stepPlayed = false;
		}
	}

	private function moveLinear():Void
	{
		if (!movementEnabled)
			return;

		if (FlxG.keys.pressed.LEFT)
		{
			wendyDanny.velocity.x = -WALK_SPEED;
			wendyDanny.velocity.y = 0;
			wendyDanny.facing = FlxObject.LEFT;
			// wendyDanny.scale.x = 1;
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			wendyDanny.angle = 0;
			wendyDanny.velocity.x = WALK_SPEED;
			wendyDanny.velocity.y = 0;
			wendyDanny.facing = FlxObject.RIGHT;
			// wendyDanny.scale.x = -1;
		}
		else if (FlxG.keys.pressed.UP)
		{
			wendyDanny.velocity.x = 0;
			wendyDanny.velocity.y = -WALK_SPEED;
		}
		else if (FlxG.keys.pressed.DOWN)
		{
			wendyDanny.velocity.x = 0;
			wendyDanny.velocity.y = WALK_SPEED;
		}
		else
		{
			wendyDanny.velocity.x = wendyDanny.velocity.y = 0;
		}

		if (wendyDanny.velocity.x != 0 || wendyDanny.velocity.y != 0)
		{
			if (wendyDanny.facing == FlxObject.LEFT)
				wendyDanny.animation.play("walk-left");
			else
				wendyDanny.animation.play("walk-right");
		}
		else
		{
			if (wendyDanny.facing == FlxObject.LEFT)
				wendyDanny.animation.play("idle-left");
			else
				wendyDanny.animation.play("idle-right");
		}
	}

	private function checkTriggers():Void
	{
		var nextRoad:String = "";

		var changeMaze:Bool = false;

		if (wendyDanny.overlaps(leftTrigger))
		{
			wendyDanny.x = FlxG.width - wendyDanny.width;
			changeMaze = true;
			if (arrivalTrigger != leftTrigger)
				mazeScreens++;
			arrivalTrigger = rightTrigger;
		}
		else if (wendyDanny.overlaps(rightTrigger))
		{
			wendyDanny.x = 0; // + 2*wendyDanny.width;
			changeMaze = true;
			if (arrivalTrigger != rightTrigger)
				mazeScreens++;
			arrivalTrigger = leftTrigger;
		}
		else if (wendyDanny.overlaps(upTrigger))
		{
			wendyDanny.y = FlxG.height - wendyDanny.height;
			changeMaze = true;
			if (arrivalTrigger != upTrigger)
				mazeScreens++;
			arrivalTrigger = downTrigger;
		}
		else if (wendyDanny.overlaps(downTrigger))
		{
			wendyDanny.y = 0; // + 2*wendyDanny.width;
			changeMaze = true;
			if (arrivalTrigger != downTrigger)
				mazeScreens++;
			arrivalTrigger = upTrigger;
		}
		else if (wendyDanny.overlaps(endTrigger) && movementEnabled && checkEndTrigger)
		{
			wendyDanny.velocity.x = 0;
			wendyDanny.velocity.y = 0;
			if (wendyDanny.facing == FlxObject.LEFT)
				wendyDanny.animation.play("idle-left");
			else
				wendyDanny.animation.play("idle-right");

			movementEnabled = false;
			// FlxFlicker.flicker(maze,10,0.25);
			new FlxTimer().start(3, nextState);
		}

		if (mazeScreens >= MIN_MAZE_SCREENS)
			completed = true;

		if (!changeMaze)
			return;

		if (completed)
		{
			bg.loadGraphic("assets/images/3_Maze/maze_walk_bg_end.png");
			maze.loadGraphic("assets/images/3_Maze/maze_walk_maze_end.png");
			checkEndTrigger = true;
		}
		else
		{
			var nextMaze:Int = Math.floor(Math.random() * 6);
			var nextRotation:Int = 0;
			var rand:Float = Math.random();

			if (rand < 0.25)
				nextRotation = 0;
			else if (rand < 0.5)
				nextRotation = 90;
			else if (rand < 0.75)
				nextRotation = 180;
			else
				nextRotation = 270;

			// bg.loadGraphic("assets/images/1_Drive/" + "trees_" + currentLandscape + "_bg" + ".png");
			maze.loadGraphic("assets/images/3_Maze/maze_walk_maze_" + nextMaze + ".png");
			maze.centerOrigin();
			maze.angle = nextRotation;
		}
		bg.origin.x = bg.origin.y = 0;
	}

	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new TuesdayState());
	}
}
