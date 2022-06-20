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
import flixel.tweens.FlxTween;



class FinalState extends FlxState
{
	private var jack:FlxSprite;

	private var caption:FlxText;

	private var black:FlxSprite;

	private var credits:FlxText;
	private var creditsMusic:FlxSound;

	private var creditsTexts:Array<String> = [
	"THE SHINING",
	"Based on the Film by\n\nSTANLEY KUBRICK",
	"From the Novel by\n\nSTEPHEN KING",
	"Graphics Editor\n\nPIXEN",
	"Programming Language\n\nHAXE",
	"Text Editor\n\nSUBLIME TEXT",
	"Game Library\n\nHAXEFLIXEL",
	"Flash Library\n\nOPENFL",
	"Sound Effects\n\nBFXR",
	"Sound Editor\n\nAUDACITY",
	"Music Editor\n\nBOSCA CEOIL",
	"Production Management\n\nEVERNOTE\nWRITEROOM",
	"Advisors to the Director\n\nRILLA KHALED\nJIM BARR\nMARY BARR",
	"THE END"
	];
	private var creditIndex:Int = 0;

	private var scareSound:FlxSound;


	override public function create():Void
	{		
		super.create();
		
		jack = new FlxSprite().loadGraphic(AssetPaths.final_jack__png,true,480,480);
		jack.animation.frameIndex = 1;
		// jack.origin.x = jack.origin.y = 0;
		// jack.scale.x = jack.scale.y = 4;

		caption = new FlxText(0,0,FlxG.width,"Overlook Hotel\nJuly 4th Ball\n1921");
		caption.setFormat("Square",36,0xFF888888,"center");
		caption.y = 3 * FlxG.height / 4;
		caption.visible = false;

		credits = new FlxText(0,0,FlxG.width,creditsTexts[0]);
		credits.setFormat("Square",20,0xFFFFFFFF,"center");
		credits.y = FlxG.height / 2 - credits.height/2;
		credits.visible = false;

		black = new FlxSprite().makeGraphic(FlxG.width,FlxG.height,0xFF000000);
		black.visible = false;

		add(jack);
		add(caption);
		add(black);
		add(credits);


		creditsMusic = new FlxSound().loadEmbedded(AssetPaths.midnight__wav,true);

		scareSound = new FlxSound().loadEmbedded(AssetPaths.scare__wav,false);
		scareSound.play();


		new FlxTimer(5,snowToBlack);
		// new FlxTimer(0.1,snowToBlack);
	}


	override public function destroy():Void
	{
		super.destroy();

		jack.destroy();
		caption.destroy();
		black.destroy();
		credits.destroy();
		creditsMusic.destroy();
		scareSound.destroy();
	}


	override public function update():Void
	{
		super.update();
	}


	private function snowToBlack(t:FlxTimer):Void
	{
		black.visible = true;
		new FlxTimer(3,blackToEnd);
		// new FlxTimer(0.1,blackToEnd);
	}


	private function blackToEnd(t:FlxTimer):Void
	{
		black.visible = false;
		FlxG.camera.fade(0xFF000000,4,true);
		jack.animation.frameIndex = 0;
		caption.visible = true;
		new FlxTimer(10,endToBlack);
		// new FlxTimer(0.1,endToBlack);

		creditsMusic.play();
		creditsMusic.volume = 0.4;
		// FlxTween.tween(creditsMusic, {volume: 1}, 8);

	}


	private function endToBlack(t:FlxTimer):Void
	{
		FlxG.camera.fade(0xFF000000,4);
		new FlxTimer(8,showCredits);
		// new FlxTimer(0.1,showCredits);
	}


	private function showCredits(t:FlxTimer):Void
	{
		FlxG.camera.stopFX();
		black.visible = true;
		credits.visible = true;
		new FlxTimer(3,nextCredit);
		// new FlxTimer(0.1,nextCredit);
	}

	private function nextCredit(t:FlxTimer):Void
	{
		creditIndex++;
		if (creditIndex < creditsTexts.length)
		{
			credits.text = creditsTexts[creditIndex];
			new FlxTimer(3,nextCredit);		
			// new FlxTimer(0.1,nextCredit);		
		}
		else {
			new FlxTimer(5,newGame);
		}
	}

	private function newGame(t:FlxTimer):Void
	{
		FlxG.switchState(new InstructionsState());
	}
}
