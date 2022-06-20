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

class TricycleState extends FlxState
{
	private static var TRICYCLE_SPEED:Int = 200;
	private static var MIN_CORRIDOR_SCREENS:Int = 8;

	private var carpet:FlxSprite;
	private var wood:FlxSprite;
	private var corridor:FlxSprite;
	private var danny:FlxSprite;
	private var dannyHit:FlxSprite;
	private var twins:FlxSprite;

	private var leftTrigger:FlxSprite;
	private var rightTrigger:FlxSprite;
	private var upTrigger:FlxSprite;
	private var downTrigger:FlxSprite;

	private var arrivalTrigger:FlxSprite;

	private var corridorScreens:Int = 0;
	private var completed:Bool = false;
	private var endTrigger:FlxSprite;
	private var checkEndTrigger:Bool = false;

	private var movementEnabled = true;

	private var hardSound:FlxSound;
	private var scareSound:FlxSound;

	override public function create():Void
	{
		super.create();

		FlxG.camera.antialiasing = false;

		wood = new FlxSprite(0, 0, "assets/images/4_Tricycle/tricycle_wood.png");
		wood.origin.x = wood.origin.y = 0;
		add(wood);

		carpet = new FlxSprite(0, 0, "assets/images/4_Tricycle/tricycle_carpet.png");
		carpet.origin.x = carpet.origin.y = 0;
		add(carpet);

		corridor = new FlxSprite(0, 0, "assets/images/4_Tricycle/tricycle_corridor_corner.png");
		// road = new FlxSprite(0,0,"assets/images/1_Drive/end_road.png");
		add(corridor);
		corridor.angle = 0;

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

		endTrigger = new FlxSprite().makeGraphic(1, Std.int(FlxG.height / 3), 0xFFFF0000);
		endTrigger.x = FlxG.width / 2 - endTrigger.width / 2;
		endTrigger.y = FlxG.height / 2 - endTrigger.height / 2;
		endTrigger.visible = false;
		add(endTrigger);

		danny = new FlxSprite().loadGraphic(AssetPaths.tricycle_danny__png, true, 11 * 4, 11 * 4);
		danny.animation.add("idle-right", [0, 0], 1, false);
		danny.animation.add("ride-right", [0, 1, 2], 20, true);
		danny.animation.add("idle-left", [3, 3], 1, false);
		danny.animation.add("ride-left", [3, 4, 5], 20, true);
		danny.animation.add("idle-up", [6, 6], 1, false);
		danny.animation.add("ride-up", [6, 7, 8], 20, true);
		danny.animation.add("idle-down", [9, 9], 1, false);
		danny.animation.add("ride-down", [9, 10, 11], 20, true);

		danny.animation.play("idle-right");
		danny.x = 200;
		danny.y = 200;
		add(danny);

		dannyHit = new FlxSprite().makeGraphic(Std.int(danny.width), Std.int(danny.height), 0xFFFF0000);
		dannyHit.x = danny.x;
		dannyHit.y = danny.y;
		dannyHit.visible = false;
		add(dannyHit);

		twins = new FlxSprite(0, 0, AssetPaths.tricycle_twins__png);
		// twins.x = 440 - twins.width;
		// twins.y = FlxG.height/2 - twins.height/2;
		twins.visible = false;
		add(twins);

		hardSound = new FlxSound().loadEmbedded(AssetPaths.tricycle_hard__wav, true);
		hardSound.volume = 0.5;
		scareSound = new FlxSound().loadEmbedded(AssetPaths.scare__wav, false);
	}

	override public function destroy():Void
	{
		super.destroy();

		carpet.destroy();
		wood.destroy();
		corridor.destroy();
		danny.destroy();
		dannyHit.destroy();
		twins.destroy();
		leftTrigger.destroy();
		rightTrigger.destroy();
		upTrigger.destroy();
		downTrigger.destroy();
		arrivalTrigger.destroy();
		endTrigger.destroy();
		hardSound.destroy();
		scareSound.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		dannyHit.x = danny.x;
		dannyHit.y = danny.y;

		// if (corridor.pixelsOverlapPoint(new FlxPoint(danny.x + danny.width/2,danny.y + danny.height/2)))
		if (FlxG.pixelPerfectOverlap(corridor, dannyHit))
		{
			danny.x -= 2 * (danny.velocity.x * FlxG.elapsed);
			danny.y -= 2 * (danny.velocity.y * FlxG.elapsed);
		}
		else
		{
			moveLinear();
		}

		checkTriggers();
		checkCarpet();
	}

	private function moveLinear():Void
	{
		if (!movementEnabled)
			return;

		if (FlxG.keys.pressed.LEFT)
		{
			danny.velocity.x = -TRICYCLE_SPEED;
			danny.velocity.y = 0;
			danny.facing = FlxObject.LEFT;
			// danny.scale.x = 1;
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			danny.angle = 0;
			danny.velocity.x = TRICYCLE_SPEED;
			danny.velocity.y = 0;
			danny.facing = FlxObject.RIGHT;
			// danny.scale.x = -1;
		}
		else if (FlxG.keys.pressed.UP)
		{
			danny.velocity.x = 0;
			danny.velocity.y = -TRICYCLE_SPEED;
		}
		else if (FlxG.keys.pressed.DOWN)
		{
			danny.velocity.x = 0;
			danny.velocity.y = TRICYCLE_SPEED;
		}
		else
		{
			danny.velocity.x = danny.velocity.y = 0;
		}

		if (danny.velocity.x != 0)
		{
			if (danny.facing == FlxObject.LEFT)
				danny.animation.play("ride-left");
			else if (danny.facing == FlxObject.RIGHT)
				danny.animation.play("ride-right");
			danny.scale.x = 1;
		}
		else if (danny.velocity.y != 0)
		{
			if (danny.velocity.y < 0)
				danny.animation.play("ride-up");
			else
				danny.animation.play("ride-down");

			if (danny.facing == FlxObject.LEFT)
				danny.scale.x = 1;
			else if (danny.facing == FlxObject.RIGHT)
				danny.scale.x = -1;
		}
		else
		{
			danny.animation.pause();
			// if (danny.facing == FlxObject.LEFT) danny.animation.play("idle-left");
			// else if (danny.facing == FlxObject.RIGHT) danny.animation.play("idle-right");
			// else if (danny.facing == FlxObject.UP) danny.animation.play("idle-up");
			// else if (danny.facing == FlxObject.DOWN) danny.animation.play("idle-down");
		}
	}

	private function checkTriggers():Void
	{
		var changeCorridor:Bool = false;

		if (danny.overlaps(leftTrigger))
		{
			danny.x = FlxG.width - danny.width - 8;
			changeCorridor = true;
			if (arrivalTrigger != leftTrigger)
				corridorScreens++;
			arrivalTrigger = rightTrigger;
		}
		else if (danny.overlaps(rightTrigger))
		{
			danny.x = 0 + 8; // + 2*danny.width;
			changeCorridor = true;
			if (arrivalTrigger != rightTrigger)
				corridorScreens++;
			arrivalTrigger = leftTrigger;
		}
		else if (danny.overlaps(upTrigger))
		{
			danny.y = FlxG.height - danny.height - 8;
			changeCorridor = true;
			if (arrivalTrigger != upTrigger)
				corridorScreens++;
			arrivalTrigger = downTrigger;
		}
		else if (danny.overlaps(downTrigger))
		{
			danny.y = 0 + 8; // + 2*danny.width;
			changeCorridor = true;
			if (arrivalTrigger != downTrigger)
				corridorScreens++;
			arrivalTrigger = upTrigger;
		}
		else if (danny.overlaps(endTrigger) && movementEnabled && checkEndTrigger)
		{
			danny.velocity.x = 0;
			danny.velocity.y = 0;
			danny.animation.pause();
			// if (danny.facing == FlxObject.LEFT) danny.animation.play("idle-left");
			// else if (danny.facing == FlxObject.RIGHT) danny.animation.play("idle-right");
			// else if (danny.facing == FlxObject.UP) danny.animation.play("idle-up");
			// else if (danny.facing == FlxObject.DOWN) danny.animation.play("idle-down");

			movementEnabled = false;

			if (arrivalTrigger == leftTrigger)
			{
				twins.x = FlxG.width - twins.width - 40;
			}
			else if (arrivalTrigger == rightTrigger)
			{
				twins.x = 40;
			}
			twins.y = FlxG.height / 2 - twins.height / 2;
			twins.visible = true;

			hardSound.stop();
			scareSound.play();

			new FlxTimer().start(2, flickerTwins);

			// new FlxTimer().start(2,startTitle);
		}

		if (corridorScreens >= MIN_CORRIDOR_SCREENS)
			completed = true;

		if (!changeCorridor)
			return;

		// trace("Changing corridor.");

		if (completed && (arrivalTrigger == leftTrigger || arrivalTrigger == rightTrigger))
		{
			// bg.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_straight.png");
			corridor.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_straight.png");
			corridor.centerOrigin();
			corridor.angle = 90;
			checkEndTrigger = true;

			if (arrivalTrigger == leftTrigger)
			{
				endTrigger.x = 0 + danny.width * 2;
			}
			else
			{
				endTrigger.x = FlxG.width - endTrigger.width - danny.width * 2;
			}
		}
		else
		{
			var rand:Float = Math.random();
			var rand2:Float = Math.random();

			if (arrivalTrigger == leftTrigger)
			{
				if (rand < 0.33)
				{
					corridor.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_straight.png");
					corridor.centerOrigin();
					corridor.angle = 90;
				}
				else if (rand < 0.66)
				{
					corridor.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_corner.png");
					corridor.centerOrigin();
					if (rand2 < 0.5)
					{
						corridor.angle = 180;
					}
					else
					{
						corridor.angle = 90;
					}
				}
				else
				{
					corridor.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_t.png");
					if (rand2 < 0.33)
					{
						corridor.angle = 0;
					}
					else if (rand2 < 0.66)
					{
						corridor.angle = 180;
					}
					else
					{
						corridor.angle = 90;
					}
				}
			}
			else if (arrivalTrigger == rightTrigger)
			{
				if (rand < 0.33)
				{
					corridor.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_straight.png");
					corridor.centerOrigin();
					corridor.angle = 90;
				}
				else if (rand < 0.66)
				{
					corridor.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_corner.png");
					corridor.centerOrigin();
					if (rand2 < 0.5)
					{
						corridor.angle = 0;
					}
					else
					{
						corridor.angle = -90;
					}
				}
				else
				{
					corridor.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_t.png");
					if (rand2 < 0.33)
					{
						corridor.angle = 0;
					}
					else if (rand2 < 0.66)
					{
						corridor.angle = -90;
					}
					else
					{
						corridor.angle = 180;
					}
				}
			}
			else if (arrivalTrigger == downTrigger)
			{
				if (rand < 0.33)
				{
					corridor.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_straight.png");
					corridor.centerOrigin();
					corridor.angle = 0;
				}
				else if (rand < 0.66)
				{
					corridor.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_corner.png");
					corridor.centerOrigin();
					if (rand2 < 0.5)
					{
						corridor.angle = 0;
					}
					else
					{
						corridor.angle = 90;
					}
				}
				else
				{
					corridor.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_t.png");
					if (rand2 < 0.33)
					{
						corridor.angle = 0;
					}
					else if (rand2 < 0.66)
					{
						corridor.angle = 90;
					}
					else
					{
						corridor.angle = -90;
					}
				}
			}
			else if (arrivalTrigger == upTrigger)
			{
				if (rand < 0.33)
				{
					corridor.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_straight.png");
					corridor.centerOrigin();
					corridor.angle = 0;
				}
				else if (rand < 0.66)
				{
					corridor.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_corner.png");
					corridor.centerOrigin();
					if (rand2 < 0.5)
					{
						corridor.angle = -90;
					}
					else
					{
						corridor.angle = 180;
					}
				}
				else
				{
					corridor.loadGraphic("assets/images/4_Tricycle/tricycle_corridor_t.png");
					if (rand2 < 0.33)
					{
						corridor.angle = 90;
					}
					else if (rand2 < 0.66)
					{
						corridor.angle = 180;
					}
					else
					{
						corridor.angle = -90;
					}
				}
			}

			carpet.centerOrigin();
			wood.centerOrigin();
			if (Math.random() < 0.5)
			{
				carpet.angle = 90;
				wood.angle = 90;
			}
			else
			{
				carpet.angle = 0;
				wood.angle = 0;
			}

			// var nextMaze:Int = Math.floor(Math.random() * 6);
			// var nextRotation:Int = 0;
			// var rand:Float = Math.random();

			// if (rand < 0.25) nextRotation = 0;
			// else if (rand < 0.5) nextRotation = 90;
			// else if (rand < 0.75) nextRotation = 180;
			// else nextRotation = 270;

			// bg.loadGraphic("assets/images/1_Drive/" + "trees_" + currentLandscape + "_bg" + ".png");
			// corridor.loadGraphic("assets/images/4_Tricycle/corridor_walk_corridor_" + nextMaze + ".png");
			// corridor.centerOrigin();
			// corridor.angle = nextRotation;
		}
		// bg.origin.x = bg.origin.y = 0;
	}

	private function checkCarpet():Void
	{
		if (danny.velocity.x == 0 && danny.velocity.y == 0)
		{
			hardSound.stop();
		}

		if (FlxG.pixelPerfectOverlap(danny, wood)
			&& !FlxG.pixelPerfectOverlap(danny, carpet)
			&& (danny.velocity.x != 0 || danny.velocity.y != 0))
		{
			hardSound.play();
		}
		else
		{
			hardSound.stop();
		}
	}

	private function flickerTwins(t:FlxTimer):Void
	{
		// FlxFlicker.flicker(twins,1000,0.25);

		new FlxTimer().start(3, nextState);
	}

	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new WednesdayState());
	}
}
