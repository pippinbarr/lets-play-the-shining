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

enum BatStateState
{
	START;
	STEPPING;
	BATTING;
	HEAD_HIT;
	JACK_CATCH;
	END;
	NEXT_STATE;
	NONE;
}

class BatState extends FlxState
{
	private static var STEP_TIME:Float = 4;
	private static var REACH_TIME_MIN:Float = 1;
	private static var REACH_TIME_RANGE:Float = 1;

	private static var BOW_TIME_MIN:Float = 0.5;
	private static var BOW_TIME_RANGE:Float = 1;

	private static var MAX_HAND_HITS:Int = 3;

	private var jack:FlxSprite;
	private var wendy:FlxSprite;

	private var inputEnabled:Bool = true;

	private var stepTimer:FlxTimer;
	private var reachTimer:FlxTimer;
	private var headTimer:FlxTimer;

	private var state:BatStateState = BATTING;
	private var handHits:Int = 0;

	private var swingSound:FlxSound;
	private var handHitSound:FlxSound;
	private var reachSound:FlxSound;
	private var hitSound:FlxSound;
	private var scareSound:FlxSound;
	private var stepSound:FlxSound;

	override public function create():Void
	{
		super.create();

		var bg:FlxSprite = new FlxSprite(0, 0, AssetPaths.bat_bg__png);

		wendy = new FlxSprite().loadGraphic(AssetPaths.bat_wendy__png, true, 17 * 4, 35 * 4);
		wendy.animation.add("step_back", [0, 1, 2], 10, false);
		wendy.animation.add("swing_down", [2, 3, 4], 20, false);
		wendy.animation.add("swing_up", [4, 3, 2], 20, false);

		wendy.animation.frameIndex = 2;
		wendy.x = FlxG.width - wendy.width * 3 + 12 + 32;
		wendy.y = 228 + 16;

		jack = new FlxSprite().loadGraphic(AssetPaths.bat_jack__png, true, 15 * 4, 25 * 4);
		jack.animation.add("step_up", [0, 3, 4], 5, false);
		jack.animation.add("hand_reach", [1, 0], 4, false);
		jack.animation.add("hand_react", [5], 30, false);
		jack.animation.add("head_bow", [2], 2, false);
		jack.animation.add("head_hit", [6, 2], 8, false);
		jack.animation.add("knocked_out", [8, 8], 10, false);

		jack.x = FlxG.width - jack.width * 2 - 12;
		jack.y = 300;

		add(bg);
		add(wendy);
		add(jack);

		stepTimer = new FlxTimer().start(STEP_TIME, stepBack);
		reachTimer = new FlxTimer().start(REACH_TIME_MIN + Math.random() * REACH_TIME_RANGE, reach);
		headTimer = new FlxTimer().start();

		swingSound = new FlxSound().loadEmbedded(AssetPaths.bat_swing__wav, false);
		swingSound.volume = 0.5;
		handHitSound = new FlxSound().loadEmbedded(AssetPaths.bat_hit_high__wav, false);
		hitSound = new FlxSound().loadEmbedded(AssetPaths.bat_hit__wav, false);
		scareSound = new FlxSound().loadEmbedded(AssetPaths.scare__wav, false);
		reachSound = new FlxSound().loadEmbedded(AssetPaths.ball_bounce__wav, false);
		reachSound.volume = 0.6;
		stepSound = new FlxSound().loadEmbedded(AssetPaths.ball_throw__wav, false);
		stepSound.volume = 0.3;
	}

	override public function destroy():Void
	{
		super.destroy();

		jack.destroy();
		wendy.destroy();
		stepTimer.destroy();
		reachTimer.destroy();
		headTimer.destroy();
		swingSound.destroy();
		handHitSound.destroy();
		reachSound.destroy();
		hitSound.destroy();
		scareSound.destroy();
		stepSound.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		switch (state)
		{
			case START:

			case STEPPING:
				if (wendy.animation.finished && jack.animation.finished)
				{
					state = BATTING;
					inputEnabled = true;
					jack.x -= 32;
					jack.y -= 16;
					jack.animation.frameIndex = 0;

					stepTimer.start(STEP_TIME, stepBack);
				}

			case BATTING:
				if (FlxG.keys.justPressed.SPACE && wendy.animation.finished)
				{
					wendy.animation.play("swing_down");
					swingSound.play();
				}

				if (wendy.animation.finished && wendy.animation.name == "swing_down")
				{
					wendy.animation.play("swing_up");
				}

				if (wendy.animation.frameIndex == 3 && wendy.animation.name == "swing_down" && jack.animation.frameIndex == 1)
				{
					// Hit the hand
					stepTimer.cancel();
					reachTimer.cancel();

					handHits++;

					swingSound.stop();
					handHitSound.play();

					// flixel.effects.FlxFlicker.flicker(jack,0.5,0.1);
					jack.animation.play("hand_react");
					new FlxTimer().start(1, bowHead);
				}
				else if (wendy.animation.frameIndex == 3 && wendy.animation.name == "swing_down" && jack.animation.frameIndex == 2)
				{
					// Hit the head

					stepTimer.cancel();
					reachTimer.cancel();

					swingSound.stop();
					hitSound.play();

					jack.animation.play("head_hit");

					inputEnabled = false;

					state = NONE;

					headTimer.start(1, knockOut);
				}

			case HEAD_HIT:
				if (jack.animation.finished && headTimer.finished)
				{
					jack.animation.play("knocked_out");
					jack.angle = 90;
					jack.x += 32;
					jack.y += 20;
					// flixel.effects.FlxFlicker.flicker(jack,100,0.25);
					state = END;

					hitSound.play();

					// jack.velocity.x = 60;
					// jack.velocity.y = 30;
				}

			case JACK_CATCH:
				if (jack.animation.finished && jack.y + jack.height > 68 * 4)
				{
					jack.x -= 32;
					jack.y -= 16;
					jack.animation.play("step_up");
				}
				else if (jack.animation.finished)
				{
					jack.x -= 32;
					jack.y -= 16;
					jack.animation.frameIndex = 1;
					// flixel.effects.FlxFlicker.flicker(wendy,100,0.25);
					state = END;

					scareSound.play();
				}

			case END:
				new FlxTimer().start(3, nextState);
				state = NEXT_STATE;

			case NONE:

			case NEXT_STATE:
		}
	}

	private function stepBack(t:FlxTimer):Void
	{
		reachTimer.cancel();

		state = STEPPING;
		wendy.x -= 32;
		wendy.y -= 16;
		wendy.animation.play("step_back");
		jack.animation.play("step_up");
		stepSound.play();

		if (wendy.y + wendy.height <= 64 * 4)
		{
			stepTimer.cancel();
			state = JACK_CATCH;
		}
		else
		{
			reachTimer.start(REACH_TIME_MIN + Math.random() * REACH_TIME_RANGE, reach);
		}
	}

	private function reach(t:FlxTimer):Void
	{
		if (handHits <= MAX_HAND_HITS)
		{
			jack.animation.play("hand_reach");
			reachSound.play();
		}

		reachTimer.start(REACH_TIME_MIN + Math.random() * REACH_TIME_RANGE, reach);
	}

	private function bowHead(t:FlxTimer):Void
	{
		stepTimer.start(BOW_TIME_MIN + Math.random() * BOW_TIME_RANGE, stepBack);
		jack.animation.play("head_bow");
	}

	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new FourPMState());
	}

	private function knockOut(t:FlxTimer):Void
	{
		state = HEAD_HIT;
	}
}
