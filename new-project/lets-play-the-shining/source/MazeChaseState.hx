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

enum StepsState
{
	START;
	TURN_1;
	TURN_2;
	END;
	NONE;
	DIE;
	DEAD;
}

class MazeChaseState extends FlxState
{
	private static var WALK_SPEED:Float = 100.0;
	private static var MIN_MAZE_SCREENS:Int = 5;
	private static var SLOW_JACK_TIME:Float = 3;

	private var jackSpeed:Float = WALK_SPEED;

	private var bg:FlxSprite;
	private var maze:FlxSprite;
	private var steps:FlxSprite;
	private var jack:FlxSprite;
	private var jackHit:FlxSprite;
	private var fog:FlxSprite;

	private var jackMove:FlxPoint;

	private var leftTrigger:FlxSprite;
	private var rightTrigger:FlxSprite;
	private var upTrigger:FlxSprite;
	private var downTrigger:FlxSprite;

	private var arrivalTrigger:FlxSprite;
	private var departureTrigger:FlxSprite;

	private var mazeScreens:Int = 0;

	private var movementEnabled = true;

	private var stepsState:StepsState = START;

	private var limpTimer:FlxTimer;

	private var stepSound:FlxSound;
	private var fallSound:FlxSound;
	private var stepPlayed:Bool = false;

	override public function create():Void
	{
		super.create();

		FlxG.camera.antialiasing = false;

		bg = new FlxSprite(0, 0, "assets/images/9_Maze/maze_chase_bg.png");
		bg.origin.x = bg.origin.y = 0;
		add(bg);

		maze = new FlxSprite(0, 0, "assets/images/9_Maze/maze_chase_steps_maze_start.png");
		add(maze);

		steps = new FlxSprite(0, 0, "assets/images/9_Maze/maze_chase_steps_start.png");
		add(steps);

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

		jack = new FlxSprite().loadGraphic(AssetPaths.maze_chase_jack__png, true, 15 * 4, 21 * 4);
		jack.animation.add("idle", [0, 0], 1, false);
		jack.animation.add("walk4", [1, 2, 3, 0], 4, false);
		jack.animation.add("walk6", [1, 2, 3, 0], 6, false);
		jack.animation.add("walk8", [1, 2, 3, 0], 8, false);
		jack.animation.add("walk10", [1, 2, 3, 0], 10, false);
		jack.animation.add("sit", [4, 5, 6], 5, false);
		jack.x = 200;
		jack.y = 200;
		jack.facing = FlxObject.RIGHT;
		jack.scale.x = -1;
		add(jack);

		jackHit = new FlxSprite().makeGraphic(Std.int(jack.width), Std.int(jack.height), 0xFFFF0000);
		jackHit.x = jack.x;
		jackHit.y = jack.y;
		jackHit.visible = false;
		add(jackHit);

		fog = new FlxSprite().makeGraphic(Std.int(FlxG.width), Std.int(FlxG.height), 0xFFFFFFFF);
		fog.alpha = 0.5;
		add(fog);

		limpTimer = new FlxTimer().start();
		limpTimer.finished = true;

		jackMove = new FlxPoint(0, 0);

		// new FlxTimer().start(SLOW_JACK_TIME,slowJack);

		stepSound = new FlxSound().loadEmbedded(AssetPaths.step_soft__wav, false);
		fallSound = new FlxSound().loadEmbedded(AssetPaths.ball_lost__wav, false);
		stepSound.volume = 0.6;
	}

	override public function destroy():Void
	{
		super.destroy();

		bg.destroy();
		maze.destroy();
		steps.destroy();
		jack.destroy();
		jackHit.destroy();
		fog.destroy();
		jackMove.destroy();
		leftTrigger.destroy();
		rightTrigger.destroy();
		upTrigger.destroy();
		downTrigger.destroy();
		arrivalTrigger.destroy();
		departureTrigger.destroy();
		limpTimer.destroy();
		stepSound.destroy();
		fallSound.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		jackHit.x = jack.x;
		jackHit.y = jack.y;

		if (FlxG.pixelPerfectOverlap(maze, jackHit))
		{
			jack.x -= 2 * (jack.velocity.x * FlxG.elapsed);
			jack.y -= 2 * (jack.velocity.y * FlxG.elapsed);
		}
		else
		{
			moveLinear();
		}

		checkTriggers();

		if (stepsState == DIE && jack.animation.finished)
		{
			stepsState = DEAD;
			// FlxFlicker.flicker(jack,1000,0.25);
			new FlxTimer().start(2, nextState);
		}

		if ((jack.animation.frameIndex == 2))
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
			jackMove.x = -jackSpeed;
			jackMove.y = 0;
			jack.facing = FlxObject.LEFT;
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			jack.angle = 0;
			jackMove.x = jackSpeed;
			jackMove.y = 0;
			jack.facing = FlxObject.RIGHT;
		}
		else if (FlxG.keys.pressed.UP)
		{
			jackMove.x = 0;
			jackMove.y = -jackSpeed;
		}
		else if (FlxG.keys.pressed.DOWN)
		{
			jackMove.x = 0;
			jackMove.y = jackSpeed;
		}
		else if (jack.animation.finished)
		{
			jackMove.x = jackMove.y = 0;
		}

		jack.velocity.x = jackMove.x;
		jack.velocity.y = jackMove.y;

		if (jack.velocity.x != 0 || jack.velocity.y != 0)
		{
			if (jackSpeed >= 100)
				jack.animation.play("walk10");
			else if (jackSpeed >= 80)
				jack.animation.play("walk8");
			else if (jackSpeed >= 60)
				jack.animation.play("walk6");
			else
				jack.animation.play("walk4");

			if (jack.facing == FlxObject.LEFT)
				jack.scale.x = 1;
			else
				jack.scale.x = -1;
		}
		else {}

		if (jack.animation.frameIndex == 0 || jack.animation.frameIndex == 1)
		{
			jack.velocity.x = jack.velocity.y = 0;
		}
		else
		{
			jack.velocity.x = jackMove.x;
			jack.velocity.y = jackMove.y;
		}

		// limpTimer.start(1);
	}

	private function checkTriggers():Void
	{
		var changeMaze:Bool = false;

		var previousArrivalTrigger:FlxSprite = arrivalTrigger;

		if (jack.overlaps(leftTrigger))
		{
			jack.x = FlxG.width - jack.width;
			changeMaze = true;
			departureTrigger = leftTrigger;
			arrivalTrigger = rightTrigger;
		}
		else if (jack.overlaps(rightTrigger))
		{
			jack.x = 0;
			changeMaze = true;
			departureTrigger = rightTrigger;
			arrivalTrigger = leftTrigger;
		}
		else if (jack.overlaps(upTrigger))
		{
			jack.y = FlxG.height - jack.height;
			changeMaze = true;
			departureTrigger = upTrigger;
			arrivalTrigger = downTrigger;
		}
		else if (jack.overlaps(downTrigger))
		{
			jack.y = 0;
			departureTrigger = downTrigger;
			arrivalTrigger = upTrigger;
		}

		if (!changeMaze)
			return;

		switch stepsState
		{
			case START:
				if (departureTrigger == rightTrigger)
				{
					maze.loadGraphic("assets/images/9_Maze/maze_chase_steps_maze_turn_1.png");
					steps.loadGraphic("assets/images/9_Maze/maze_chase_steps_turn_1.png");
					stepsState = TURN_1;
				}
				else
				{
					// Do nothing and he'll just "wrap" and have to go out the right way.
				}

			case TURN_1:
				if (departureTrigger == upTrigger)
				{
					maze.loadGraphic("assets/images/9_Maze/maze_chase_steps_maze_turn_2.png");
					steps.loadGraphic("assets/images/9_Maze/maze_chase_steps_turn_2.png");
					stepsState = TURN_2;
				}
				else
				{
					maze.loadGraphic("assets/images/9_Maze/maze_chase_steps_maze_start.png");
					steps.loadGraphic("assets/images/9_Maze/maze_chase_steps_start.png");
					stepsState = START;
				}

			case TURN_2:
				if (departureTrigger == rightTrigger)
				{
					maze.loadGraphic("assets/images/9_Maze/maze_chase_steps_maze_end.png");
					steps.loadGraphic("assets/images/9_Maze/maze_chase_steps_end.png");

					new FlxTimer().start(SLOW_JACK_TIME, slowJack);

					stepsState = END;
				}
				else
				{
					maze.loadGraphic("assets/images/9_Maze/maze_chase_steps_maze_turn_1.png");
					steps.loadGraphic("assets/images/9_Maze/maze_chase_steps_turn_1.png");
					stepsState = TURN_1;
				}

			case END:
				// if (departureTrigger == leftTrigger)
				// {
				// 	maze.loadGraphic("assets/images/9_Maze/maze_chase_steps_maze_turn_2.png");
				// 	steps.loadGraphic("assets/images/9_Maze/maze_chase_steps_turn_2.png");
				// 	stepsState = TURN_2;
				// }
				// else
				// {
				stepsState = NONE;
				steps.visible = false;

				// We go over to the "lost in the maze" stuff

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

				maze.loadGraphic("assets/images/9_Maze/maze_chase_maze_" + nextMaze + ".png");
				maze.centerOrigin();
				maze.angle = nextRotation;

				bg.origin.x = bg.origin.y = 0;
			// }

			case NONE:
				if (departureTrigger != previousArrivalTrigger)
				{
					mazeScreens++;
				}

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

				maze.loadGraphic("assets/images/9_Maze/maze_chase_maze_" + nextMaze + ".png");
				maze.centerOrigin();
				maze.angle = nextRotation;

				bg.origin.x = bg.origin.y = 0;

			case DIE, DEAD:
		}
	}

	private function slowJack(t:FlxTimer):Void
	{
		jackSpeed -= 10;

		if (jack.velocity.x < 0)
			jack.velocity.x = -jackSpeed;
		else if (jack.velocity.x > 0)
			jack.velocity.y = jackSpeed;
		else if (jack.velocity.y < 0)
			jack.velocity.y = -jackSpeed;
		else if (jack.velocity.y > 0)
			jack.velocity.y = jackSpeed;

		if (jack.velocity.x != 0 || jack.velocity.y != 0)
		{
			if (jackSpeed >= 100)
				jack.animation.play("walk10");
			else if (jackSpeed >= 80)
				jack.animation.play("walk8");
			else if (jackSpeed >= 60)
				jack.animation.play("walk6");
			else
				jack.animation.play("walk4");
		}

		if (jackSpeed < 10)
		{
			jack.velocity.x = 0;
			jack.velocity.y = 0;
			movementEnabled = false;

			jack.animation.play("sit");

			fallSound.play();

			stepsState = DIE;
		}
		else
		{
			new FlxTimer().start(SLOW_JACK_TIME, slowJack);
		}
	}

	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new FinalState());
	}
}
