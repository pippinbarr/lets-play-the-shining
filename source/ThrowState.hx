package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;


enum JackThrowState {
	WITH_BALL;
	THROWING;
	CATCHING;
	IDLE;
}


class ThrowState extends FlxState
{
	private static var JACK_WALK_SPEED:Int = 200;
	private static var BALL_SPEED:Int = 300;
	private static var MAX_MISSES:Int = 3;
	private static var MAX_CATCHES:Int = 5;

	private var jack:FlxSprite;
	private var ball:FlxSprite;
	private var catchTrigger:FlxSprite;

	private var movementEnabled:Bool = true;
	private var throwing:Bool = true;

	private var leftWall:FlxSprite;
	private var topWall:FlxSprite;
	private var rightWall:FlxSprite;

	private var black:FlxSprite;

	private var walls:FlxGroup;

	private var jackState:JackThrowState;

	private var throws:Int = 0;
	private var catches:Int = 0;
	private var misses:Int = 0;


	private var throwSound:FlxSound;
	private var catchSound:FlxSound;
	private var bounceSound:FlxSound;
	private var stepSound:FlxSound;
	private var stepSoundPlayed:Bool = false;


	override public function create():Void
	{		
		super.create();

		var bg:FlxSprite = new FlxSprite(0,0,AssetPaths.throw_bg__png);
		bg.origin.x = bg.origin.y = 0;
		bg.scale.x = bg.scale.y = 4;

		leftWall = new FlxSprite(0,0).makeGraphic(16*4,FlxG.height,0xFFFF0000);
		leftWall.immovable = true;
		// leftWall.elasticity = 1;
		leftWall.solid = true;

		topWall = new FlxSprite(0,-20).makeGraphic(FlxG.width,20,0xFFFF0000);
		topWall.immovable = true;
		rightWall = new FlxSprite(FlxG.width,0).makeGraphic(20,FlxG.height);
		rightWall.immovable = true;

		walls = new FlxGroup();
		walls.add(leftWall);
		walls.add(rightWall);
		walls.add(topWall);
		walls.visible = false;

		ball = new FlxSprite().loadGraphic(AssetPaths.ball__png);
		ball.visible = false;
		ball.elasticity = 1;

		jack = new FlxSprite().loadGraphic(AssetPaths.throw_jack_animations__png,true,13,21);
		jack.scale.x = jack.scale.y = 4;
		jack.width *= jack.scale.x;
		jack.height *= jack.scale.y;
		jack.x = 240;
		jack.y = 364;
		jack.animation.add("ball_idle",[5,5],1,false);
		jack.animation.add("no_ball_idle",[0,0],1,false);
		jack.animation.add("no_ball_catch_idle",[1,1],1,false);
		jack.animation.add("no_ball_walk",[2,3,4],20,true);
		jack.animation.add("no_ball_walk_back",[4,3,2],20,true);
		jack.animation.add("ball_throw",[6,7],4,false);
		jack.animation.add("ball_walk",[8,9,10],20,true);
		jack.animation.add("ball_walk_back",[10,9,8],20,true);

		jack.animation.play("ball_idle");

		catchTrigger = new FlxSprite(0,0).makeGraphic(24,24,0xFFFF0000);
		catchTrigger.visible = false;

		black = new FlxSprite().makeGraphic(FlxG.width,FlxG.height,0xFF000000);
		black.visible = false;

		add(bg);
		add(walls);
		add(jack);
		add(ball);
		add(catchTrigger);
		add(black);


		throwSound = new FlxSound().loadEmbedded(AssetPaths.ball_throw__wav,false);
		catchSound = new FlxSound().loadEmbedded(AssetPaths.ball_catch__wav,false);
		bounceSound = new FlxSound().loadEmbedded(AssetPaths.ball_bounce__wav,false);
		stepSound = new FlxSound().loadEmbedded(AssetPaths.step_hard__wav,false);
		stepSound.volume = 0.2;

		jackState = WITH_BALL;
	}


	override public function destroy():Void
	{
		super.destroy();

		jack.destroy();
		ball.destroy();
		catchTrigger.destroy();
		leftWall.destroy();
		topWall.destroy();
		rightWall.destroy();
		black.destroy();
		walls.destroy();
		throwSound.destroy();
		catchSound.destroy();
		bounceSound.destroy();
		stepSound.destroy();
	}


	override public function update():Void
	{
		super.update();

		FlxG.collide(ball,walls,bounceHandler);

		if (jack.scale.x == 4)
		{
			catchTrigger.x = jack.x - jack.width/2 + 8;
			catchTrigger.y = jack.y - jack.height/2 + 8;			
		}
		else
		{
			catchTrigger.x = jack.x - jack.width/2 + jack.width - catchTrigger.width - 8;
			catchTrigger.y = jack.y - jack.height/2 + 8;						
		}

		handleInput();
		handleBall();
		handleJack();
	}


	private function bounceHandler(b:FlxObject, w:FlxObject):Void
	{
		if (w == leftWall) bounceSound.volume = 1;
		else bounceSound.volume = 0.2;

		bounceSound.play(true);
	}


	private function handleInput():Void
	{
		jack.scale.x = 4;

		if (!movementEnabled) return;

		switch (jackState)
		{
			case WITH_BALL:
			if (FlxG.keys.pressed.LEFT)
			{
				jack.animation.play("ball_walk");
				jack.velocity.x = -JACK_WALK_SPEED;
			}
			else if (FlxG.keys.pressed.RIGHT)
			{
				jack.animation.play("ball_walk_back");
				jack.velocity.x = JACK_WALK_SPEED;
			}
			else
			{			
				jack.animation.play("ball_idle");
				jack.velocity.x = 0;
			}

			if (FlxG.keys.pressed.SPACE)
			{
				jack.animation.play("ball_throw");
				jack.velocity.x = 0;

				jackState = THROWING;

				throws++;
			}

			case THROWING:
			if (jack.animation.frameIndex == 7)
			{
				jack.animation.play("no_ball_catch_idle");

				ball.visible = true;
				ball.x = jack.x - jack.width/2;
				ball.y = jack.y - jack.height/2;

				ball.velocity.x = -BALL_SPEED;
				ball.velocity.y = -BALL_SPEED;

				jackState = CATCHING;

				throwSound.play();
			}

			case CATCHING:
			if (FlxG.keys.pressed.LEFT)
			{
				jack.animation.play("no_ball_walk");
				jack.velocity.x = -JACK_WALK_SPEED;
				if (ball.x < jack.x)
				{
					jack.scale.x = 4;
				}
				else
				{
					jack.scale.x = -4;
				}
			}
			else if (FlxG.keys.pressed.RIGHT)
			{
				jack.animation.play("no_ball_walk_back");
				jack.velocity.x = JACK_WALK_SPEED;

				if (ball.x < jack.x)
				{
					jack.scale.x = 4;
				}
				else
				{
					jack.scale.x = -4;
				}
			}
			else
			{
				jack.animation.play("no_ball_catch_idle");
				jack.velocity.x = 0;

				if (ball.x < jack.x)
				{
					jack.scale.x = 4;
				}
				else
				{
					jack.scale.x = -4;
				}
			}

			if (ball.overlaps(catchTrigger))
			{
				jack.animation.play("ball_idle");
				jack.velocity.x = 0;
				ball.velocity.x = ball.velocity.y = 0;
				ball.visible = false;

				jackState = WITH_BALL;

				catches++;

				catchSound.play();

				if (catches >= MAX_CATCHES)
				{
					movementEnabled = false;
					new FlxTimer(3,toBlack);
				}
			}

			case IDLE:
		}


	}


	private function handleBall():Void
	{
		if (ball.y > FlxG.height && jackState == CATCHING)
		{
			ball.visible = false;
			ball.velocity.x = 0;
			ball.velocity.y = 0;
			jackState = WITH_BALL;
			jack.velocity.x = 0;
			jack.velocity.y = 0;
			jack.animation.play("no_ball_idle");

			// lostSound.play();

			misses++;

			if (misses >= MAX_MISSES)
			{
				movementEnabled = false;
				new FlxTimer(3,toBlack);
			}
			else
			{
				jack.animation.play("ball_idle");
				jackState = WITH_BALL;
			}
		}
	}


	private function handleJack():Void
	{
		if (jack.x + jack.width * 0.5 >= FlxG.width) jack.x = FlxG.width - jack.width * 0.5;
		if (jack.x <= leftWall.x + leftWall.width * 1.4) jack.x = leftWall.x + leftWall.width * 1.4;

		if ((jack.animation.frameIndex == 3 || jack.animation.frameIndex == 9))
		{
			if (!stepSoundPlayed)
			{
				stepSound.play(true);
				stepSoundPlayed = true;
			}
		}
		else 
		{
			stepSoundPlayed = false;
		}
	}


	private function toBlack(t:FlxTimer):Void
	{
		black.visible = true;
		new FlxTimer(3,nextState);
	}



	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new MazeWalkState());
	}

}
