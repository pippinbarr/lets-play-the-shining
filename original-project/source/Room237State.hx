package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxTimer;
import flixel.util.FlxAngle;
import flixel.system.FlxSound;
import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import flixel.tweens.FlxTween;


class Room237State extends FlxState
{
	private static var WALK_SPEED:Int = 50;
	private static var LADY_SPEED:Int = 30;

	private var bg:FlxSprite;
	private var bgHit:FlxSprite;
	private var jack:FlxSprite;
	private var jackHit:FlxSprite;
	private var lady:FlxSprite;

	private var ladyFollow:Bool = false;

	private var exitTrigger:FlxSprite;

	private var inputEnabled = true;


	private var laughSound:FlxSound;
	private var scareSound:FlxSound;


	override public function create():Void
	{
		super.create();


		FlxG.camera.antialiasing = false;

		bg = new FlxSprite(0,0,"assets/images/6_Room_237/room_237_bg.png");
		bg.origin.x = bg.origin.y = 0; 
		add(bg);

		bgHit = new FlxSprite(0,0,"assets/images/6_Room_237/room_237_hitmap.png");
		bgHit.visible = false;
		add(bgHit);

		exitTrigger = new FlxSprite().makeGraphic(20,96,0xFFFF0000);
		exitTrigger.x = FlxG.width - 12;
		exitTrigger.y = 80;
		exitTrigger.visible = false;
		add(exitTrigger);

		jack = new FlxSprite().loadGraphic("assets/images/6_Room_237/room_237_jack_walk.png",true,10*4,21*4);
		jack.animation.add("idle",[0,0],1,false);
		jack.animation.add("walk",[1,2,3,4,5,6],5,true);
		jack.x = 90;
		jack.y = 90;
		add(jack);

		jackHit = new FlxSprite().makeGraphic(Std.int(jack.width),Std.int(jack.height),0xFFFF0000);
		jackHit.x = jack.x;
		jackHit.y = jack.y;
		jackHit.visible = false;
		add(jackHit);

		lady = new FlxSprite().loadGraphic("assets/images/6_Room_237/room_237_lady_walk.png",true,10*4,21*4);
		lady.animation.add("idle",[0,0],1,false);
		lady.animation.add("walk",[1,2,3],10,true);
		lady.animation.play("walk");
		lady.x = 30;
		lady.y = 90;
		add(lady);

		new FlxTimer(2.5,ladyFollowUpdate);
		new FlxTimer(1,playLaugh);

		laughSound = new FlxSound().loadEmbedded(AssetPaths.laugh__wav,false);
		laughSound.volume = 0.6;
		scareSound = new FlxSound().loadEmbedded(AssetPaths.scare__wav,false);
	}



	private function ladyFollowUpdate(t:FlxTimer):Void
	{
		ladyFollow = true;
		lady.animation.play("walk");
	}
	


	override public function destroy():Void
	{
		super.destroy();

		bg.destroy();
		bgHit.destroy();
		jack.destroy();
		jackHit.destroy();
		lady.destroy();
		exitTrigger.destroy();
		laughSound.destroy();
		scareSound.destroy();
	}



	override public function update():Void
	{

		super.update();

		jackHit.x = jack.x;
		jackHit.y = jack.y;

		// if (maze.pixelsOverlapPoint(new FlxPoint(jack.x + jack.width/2,jack.y + jack.height/2)))
		if (FlxG.pixelPerfectOverlap(bgHit,jackHit))
		{
			jack.x -= 2 * (jack.velocity.x * FlxG.elapsed);
			jack.y -= 2 * (jack.velocity.y * FlxG.elapsed);
		}
		else
		{
			handleInput();
		}
		handleLady();

		checkTriggers();
	}	


	private function handleInput():Void
	{
		if (!inputEnabled) return;

		if (FlxG.keys.pressed.RIGHT)
		{
			jack.velocity.x = -WALK_SPEED;
			jack.velocity.y = 0;
			jack.facing = FlxObject.LEFT;
			// jack.scale.x = 1;
		}
		else if (FlxG.keys.pressed.LEFT)
		{
			jack.angle = 0;
			jack.velocity.x = WALK_SPEED;
			jack.velocity.y = 0;
			jack.facing = FlxObject.RIGHT;
			// jack.scale.x = -1;
		}	
		else if (FlxG.keys.pressed.DOWN)
		{
			jack.velocity.x = 0;
			jack.velocity.y = -WALK_SPEED;
		}	
		else if (FlxG.keys.pressed.UP)
		{
			jack.velocity.x = 0;
			jack.velocity.y = WALK_SPEED;
		}
		else
		{
			jack.velocity.x = jack.velocity.y = 0;
		}

		if (jack.velocity.x != 0 || jack.velocity.y != 0)
		{
			jack.animation.play("walk");
			if (jack.x < lady.x) jack.scale.x = -1;
			else jack.scale.x = 1;
		}
		else
		{
			jack.animation.play("idle");
			if (jack.x < lady.x) jack.scale.x = -1;
			else jack.scale.x = 1;
		}
	}


	private function checkTriggers():Void
	{		
		if (jack.overlaps(exitTrigger) && inputEnabled)
		{
			jack.velocity.x = 0;
			jack.velocity.y = 0;
			jack.animation.play("idle");
			if (jack.facing == FlxObject.LEFT) jack.scale.x = -1;
			else jack.scale.x = 1;

			inputEnabled = false;
			jack.visible = false;
			// FlxFlicker.flicker(lady,10,0.25);

			laughSound.stop();
			scareSound.stop();

			// ladyTween.cancel();

			ladyFollow = false;
			lady.animation.play("idle");
			lady.velocity.x = lady.velocity.y = 0;

			new FlxTimer(2,nextState);

			// lady.animation.play("idle");
			// ladyTween.cancel();
			// new FlxTimer(2,startTitle);
		}
	}


	private function handleLady():Void
	{
		if (ladyFollow)
		{
			var theAngle:Float = FlxAngle.angleBetween(lady,jack,false);
			lady.velocity.x = Math.cos(theAngle) * LADY_SPEED;
			lady.velocity.y = Math.sin(theAngle) * LADY_SPEED;
		}

		if (jack.x < lady.x) lady.scale.x = -1;
		else lady.scale.x = 1;
		

		if (lady.overlapsPoint(new FlxPoint(jackHit.x + jackHit.width/2,jackHit.y + jackHit.height/2)) && inputEnabled)
		{
			inputEnabled = false;
			ladyFollow = false;

			jack.animation.play("idle");
			jack.velocity.x = jack.velocity.y = 0;
			lady.velocity.x = lady.velocity.y = 0;

			// FlxFlicker.flicker(jack,10,0.25);
			scareSound.play();
			laughSound.stop();

			new FlxTimer(3,nextState);
		}

	}


	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new EightAMState());
	}


	private function playLaugh(t:FlxTimer):Void
	{
		if (!inputEnabled) return;

		laughSound.play();
		new FlxTimer(2 + Math.random() * 2,playLaugh);
	}

}