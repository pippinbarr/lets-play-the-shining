package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;


class DriveState extends FlxState
{
	// private static var CAR_ROTATION:Int = 15;
	// private static var CAR_TURN_DELAY:Float = 0.1;
	private static var CAR_SPEED:Int = 100;
	private static var MIN_TRAVEL_SCREENS:Int = 6;

	private var bg:FlxSprite;
	private var lake:FlxSprite;
	private var lake2:FlxSprite;
	private var road:FlxSprite;
	private var car:FlxSprite;

	private var leftTrigger:FlxSprite;
	private var rightTrigger:FlxSprite;
	private var upTrigger:FlxSprite;
	private var downTrigger:FlxSprite;

	private var arrivalTrigger:FlxSprite;

	private var currentLandscape:String = "lake";
	private var travelScreens:Int = 0;
	private var totalScreens:Int = 0;
	private var completed:Bool = false;

	private var themeMusic:FlxSound;

	private var titleTrigger:FlxSprite;
	private var checkTitleTrigger:Bool = false;
	private var superTitleText:FlxText;
	private var subTitleText:FlxText;
	private var titleText:FlxText;
	private var titleIn:Bool = false;

	private var movementEnabled = true;


	override public function create():Void
	{
		super.create();

		FlxG.camera.antialiasing = false;

		themeMusic = new FlxSound().loadEmbedded(AssetPaths.shining_theme__wav,true);
		themeMusic.play();

		bg = new FlxSprite(0,0,"assets/images/1_Drive/trees_green_bg.png");
		// bg = new FlxSprite(0,0,"assets/images/1_Drive/end_bg.png");
		bg.origin.x = bg.origin.y = 0; 
		add(bg);

		lake = new FlxSprite(0,0,"assets/images/1_Drive/lake_left.png");
		lake2 = new FlxSprite(0,0,"assets/images/1_Drive/lake_left.png");
		add(lake);
		add(lake2);

		road = new FlxSprite(0,0,"assets/images/1_Drive/b_u_road.png");
		// road = new FlxSprite(0,0,"assets/images/1_Drive/end_road.png");
		add(road);

		leftTrigger = new FlxSprite(0,0);
		leftTrigger.makeGraphic(10, Std.int(FlxG.height/3),0xFF00FF00);
		leftTrigger.x = -leftTrigger.width;
		leftTrigger.y = FlxG.height/3;
		add(leftTrigger);

		rightTrigger = new FlxSprite(0,0);
		rightTrigger.makeGraphic(10, Std.int(FlxG.height/3),0xFF00FF00);
		rightTrigger.x = FlxG.width;
		rightTrigger.y = FlxG.height/3;
		add(rightTrigger);

		upTrigger = new FlxSprite(0,0);
		upTrigger.makeGraphic(Std.int(FlxG.width/3),10,0xFF00FF00);
		upTrigger.x = FlxG.width/3;
		upTrigger.y = -upTrigger.height;
		add(upTrigger);

		downTrigger = new FlxSprite(0,0);
		downTrigger.makeGraphic(Std.int(FlxG.width/3),10,0xFF00FF00);
		downTrigger.x = FlxG.width/3;
		downTrigger.y = FlxG.height;
		add(downTrigger);

		car = new FlxSprite(244,400,AssetPaths.car__png);
		car.angle = 270;
		add(car);

		titleTrigger = new FlxSprite().makeGraphic(64,8,0xFFFF0000);
		titleTrigger.x = 13*16;
		titleTrigger.y = 20*16;
		add(titleTrigger);
		titleTrigger.visible = false;

		superTitleText = new FlxText(0,0,FlxG.width,"LET'S PLAY:");
		superTitleText.setFormat("Square",24,0xFF2255FF,"center");
		superTitleText.y = 60;
		superTitleText.moves = true;
		superTitleText.visible = false;
		// superTitleText.velocity.y = -60;

		titleText = new FlxText(0,0,FlxG.width,"THE SHINING");
		titleText.setFormat("Square",48,0xFF2255FF,"center");
		titleText.y = FlxG.height;
		// titleText.y = superTitleText.y + superTitleText.height + superTitleText.height*0.5;
		titleText.moves = true;
		// titleText.velocity.y = -60;

		subTitleText = new FlxText(0,0,FlxG.width,"A PIPPIN BARR GAME");
		subTitleText.setFormat("Square",18,0xFF2255FF,"center");
		// subTitleText.y = 60;
		subTitleText.moves = false;
		subTitleText.visible = false;


		add(superTitleText);
		add(titleText);
		add(subTitleText);
	}
	


	override public function destroy():Void
	{
		super.destroy();

		bg.destroy();
		lake.destroy();
		lake2.destroy();
		road.destroy();
		car.destroy();
		leftTrigger.destroy();
		rightTrigger.destroy();
		upTrigger.destroy();
		downTrigger.destroy();
		arrivalTrigger.destroy();

		themeMusic.destroy();

		superTitleText.destroy();
		subTitleText.destroy();
		titleText.destroy();
	}



	override public function update():Void
	{

		super.update();

		if (!road.pixelsOverlapPoint(new FlxPoint(car.x + car.width/2,car.y + car.height/2)))
		{
			car.x -= 2 * (car.velocity.x * FlxG.elapsed);
			car.y -= 2 * (car.velocity.y * FlxG.elapsed);
		}
		else
		{
			moveLinear();
		}

		checkTriggers();
		checkTitle();
	}	


	private function moveLinear():Void
	{
		if (!movementEnabled) return;

		if (FlxG.keys.pressed.LEFT)
		{
			car.angle = 180;
			car.velocity.x = -CAR_SPEED;
			car.velocity.y = 0;
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			car.angle = 0;
			car.velocity.x = CAR_SPEED;
			car.velocity.y = 0;
		}	
		else if (FlxG.keys.pressed.UP)
		{
			car.angle = 270;
			car.velocity.x = 0;
			car.velocity.y = -CAR_SPEED;
		}	
		else if (FlxG.keys.pressed.DOWN)
		{
			car.angle = 90;
			car.velocity.x = 0;
			car.velocity.y = CAR_SPEED;
		}
		else
		{
			car.velocity.x = car.velocity.y = 0;
		}
	}


	private function checkTriggers():Void
	{
		var nextRoad:String = "";

		if (car.overlaps(leftTrigger))
		{
			car.x = FlxG.width - 2*car.width;
			nextRoad = (Math.random() > 0.7) ? "r_l" : "r_u";
			if (completed) nextRoad = "r_u";
			if (arrivalTrigger != leftTrigger || totalScreens > MIN_TRAVEL_SCREENS) travelScreens++;
			arrivalTrigger = rightTrigger;
		}
		else if (car.overlaps(rightTrigger))
		{
			car.x = 0 + 2*car.width;
			nextRoad = "l_u";
			if (arrivalTrigger != rightTrigger || totalScreens > MIN_TRAVEL_SCREENS) travelScreens++;
			arrivalTrigger = leftTrigger;
		}
		else if (car.overlaps(upTrigger))
		{
			car.y = FlxG.height - 2*car.height;

			if (!completed)
			{
				nextRoad = (Math.random() > 0.7) ? "b_u" : "b_l";
			}
			else
			{
				nextRoad = "end";
			}
			if (arrivalTrigger != upTrigger || totalScreens > MIN_TRAVEL_SCREENS) travelScreens++;
			arrivalTrigger = downTrigger;
		}
		else if (car.overlaps(downTrigger))
		{
			car.y = 0 + 2*car.width;
			nextRoad = "l_u";
			if (arrivalTrigger != downTrigger || totalScreens > MIN_TRAVEL_SCREENS) travelScreens++;
			arrivalTrigger = upTrigger;
		}
		else if (car.overlaps(titleTrigger) && movementEnabled && checkTitleTrigger)
		{
			car.velocity.x = 0;
			car.velocity.y = 0;
			movementEnabled = false;
			new FlxTimer(2,startTitle);
		}


		if (travelScreens >= MIN_TRAVEL_SCREENS-1) completed = true;

		if (travelScreens >= 2 * MIN_TRAVEL_SCREENS/3)
		{
			currentLandscape = "snow";
			lake.visible = false;
			lake2.visible = false;
		}
		else if (travelScreens >= MIN_TRAVEL_SCREENS/3)
		{
			currentLandscape = "green";
			lake.visible = false;
			lake2.visible = false;
		}
		else
		{
			currentLandscape = "lake";
		}

		if (nextRoad == "") return;
		
		totalScreens++;

		if (nextRoad == "end")
		{
			bg.loadGraphic("assets/images/1_Drive/" + "end_bg" + ".png");
			road.loadGraphic("assets/images/1_Drive/" + "end_road" + ".png");
			checkTitleTrigger = true;
		}
		else
		{
			bg.loadGraphic("assets/images/1_Drive/" + "trees_" + currentLandscape + "_bg" + ".png");
			road.loadGraphic("assets/images/1_Drive/" + nextRoad + "_road" + ".png");
			
			if (currentLandscape == "lake")
			{
				lake.visible = false;
				lake2.visible = false;

				if (nextRoad == "b_l")
				{
					lake.loadGraphic("assets/images/1_Drive/lake_bottom_left.png");
					lake.visible = true;
				}
				else if (nextRoad == "r_l")
				{
					lake.loadGraphic("assets/images/1_Drive/lake_bottom.png");
					lake.visible = true;
				}
				else if (nextRoad == "b_u")
				{
					lake.loadGraphic("assets/images/1_Drive/lake_left.png");
					lake.visible = true;
				}
				else if (nextRoad == "r_u")
				{
					lake.loadGraphic("assets/images/1_Drive/lake_bottom.png");	
					lake2.loadGraphic("assets/images/1_Drive/lake_left.png");			
					lake.visible = true;
					lake2.visible = true;
				}
			}
		}

		bg.origin.x = bg.origin.y = 0; 



	}


	private function startTitle(t:FlxTimer):Void
	{
		titleIn = true;
		titleText.velocity.y = -60;
	}


	private function checkTitle():Void
	{
		if (!titleIn) return;

		if (titleText.y <= superTitleText.y + superTitleText.height + superTitleText.height*0.5)
		{
			// titleText.y = superTitleText.y + superTitleText.height + superTitleText.height*0.5;
			titleText.velocity.y = 0;
			displaySuperTitle(null);
			titleIn = false;
		}
	}


	private function displaySuperTitle(t:FlxTimer):Void
	{
		superTitleText.visible = true;

		new FlxTimer(2,displaySubTitle);
	}


	private function displaySubTitle(t:FlxTimer):Void
	{
		subTitleText.y = titleText.y + titleText.height;
		subTitleText.visible = true;

		new FlxTimer(3,nextState);
		FlxTween.tween(themeMusic, {volume: 0}, 3);
	}


	private function nextState(t:FlxTimer):Void
	{
		FlxG.switchState(new MonthLaterState());
	}

}