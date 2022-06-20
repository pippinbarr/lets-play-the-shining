package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxTimer;

class TypeState extends FlxState
{
	private static var SENTENCE:String = "All work and no play\nmakes Jack a dull boy.\n";
	private static var CHARS:String = "abcdefghizjklmnopqrstuvwxyz";
	private static var PUNCTUATION:String = ",. ";
	private static var MAX_LENGTH_ERRORS_PER_SENTENCE:Int = 3;

	private var sentenceIndex:Int = 0;
	private var lengthErrorsThisSentence:Int = 0;
	private var craziness:Float = 0.0;

	private var jack:FlxSprite;
	private var typing:FlxText;

	private var inputEnabled:Bool = true;

	private var typeSound:FlxSound;

	override public function create():Void
	{
		super.create();

		var bg:FlxSprite = new FlxSprite(0, 0, AssetPaths.type_bg__png);

		jack = new FlxSprite().loadGraphic(AssetPaths.type_jack_typing__png, true, 20 * 4, 19 * 4);
		jack.animation.add("idle", [0, 0], 1, false);
		jack.animation.add("typing", [1, 0, 2, 1, 2, 1, 0, 1, 2, 0, 2, 0, 1, 2, 1, 0, 1, 2], 10, true);
		jack.animation.play("idle");
		jack.x = FlxG.width / 2 - jack.width / 2;
		jack.y = 380;

		typing = new FlxText(100, 100, FlxG.width - 200, "");
		typing.setFormat(AssetPaths.Commodore__ttf, 14, 0xFF000000, "left");
		typing.wordWrap = true;

		add(bg);
		add(typing);
		add(jack);

		typeSound = new FlxSound().loadEmbedded(AssetPaths.step_hard__wav, false);
		typeSound.volume = 0.6;
	}

	override public function destroy():Void
	{
		super.destroy();

		jack.destroy();
		typing.destroy();
		typeSound.destroy();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		handleInput();
	}

	private function handleInput():Void
	{
		if (!inputEnabled)
			return;

		if (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.SPACE)
		{
			typeSound.play(true);

			jack.animation.frameIndex = (jack.animation.frameIndex + Math.floor(Math.random() * 2) + 1) % 3;

			// if (Math.random() < 1 - craziness) typing.text += SENTENCE.charAt(sentenceIndex);
			// else
			// {
			// if (Math.random() < 0.5) typing.text += " ";
			// else typing.text += (Math.random() < 0.5) ? "V" : "Y";
			// }
			// if (Math.random() < craziness) typing.text += SENTENCE.charAt(sentenceIndex);

			if (Math.random() < 1 - craziness || // SENTENCE.charAt(sentenceIndex) == ' ' ||
				SENTENCE.charAt(sentenceIndex) == '\n')
			{
				typing.text += SENTENCE.charAt(sentenceIndex);
				sentenceIndex = (sentenceIndex + 1) % SENTENCE.length;
			}
			else
			{
				// Do something to the line

				var rand:Float = Math.random();

				if (rand < 0.33 && lengthErrorsThisSentence < MAX_LENGTH_ERRORS_PER_SENTENCE)
				{
					// Double a letter by not incrementing the index
					typing.text += SENTENCE.charAt(sentenceIndex);
					lengthErrorsThisSentence++;
				}
				else if (rand < 0.66 && lengthErrorsThisSentence < MAX_LENGTH_ERRORS_PER_SENTENCE)
				{
					// Type a random letter without increment
					typing.text += CHARS.charAt(Math.floor(Math.random() * CHARS.length));
					lengthErrorsThisSentence++;
				}
				else if (rand < 0.5)
				{
					// Replace this character with a random letter
					typing.text += CHARS.charAt(Math.floor(Math.random() * CHARS.length));
					sentenceIndex = (sentenceIndex + 1) % SENTENCE.length;
				}
				else if (rand <= 1.0)
				{
					// Replace this character with punctuation
					typing.text += PUNCTUATION.charAt(Math.floor(Math.random() * PUNCTUATION.length));
					sentenceIndex = (sentenceIndex + 1) % SENTENCE.length;
				}
			}

			// lineChars++;

			if (sentenceIndex == 0)
			{
				craziness = Math.min(craziness + 0.0075, 0.05);
				lengthErrorsThisSentence = 0;
			}

			typing.drawFrame(true);

			if (typing.height > typing.y + 140 && sentenceIndex == (SENTENCE.length - 1))
			{
				// 				typing.text = "";
				// typing.height = 0;

				// typing.drawFrame(true);

				// if (craziness >= 0.05)
				// {
				inputEnabled = false;
				// FlxFlicker.flicker(typing,100,0.25);
				new FlxTimer().start(3, nextState);
				// }
			}
		}
		else
		{
			jack.animation.frameIndex = 0;
		}
	}

	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new SaturdayState());
	}
}
