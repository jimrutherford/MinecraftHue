//
//  ViewController.m
//  MinecraftHue
//
//  Created by James Rutherford on 2013-02-10.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Sky.h"
#import	"AppDelegate.h"
#import "NVSlideMenuController.h"
#import "Toast+UIView.h"

#define totalMinutes 1440
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define minutesInDay 720.0
#define minutesInNight 504.0
#define minutesInSunrise 108.0
#define minutesInSunset 108.0

#define dayPartDay @"Daytime"
#define dayPartNight @"Nighttime"
#define dayPartSunrise @"Sunrise"
#define dayPartSunset @"Sunset"

#define arcFactor 470.0
#define verticalOffset 30

@interface ViewController ()

@end

@implementation ViewController

@synthesize moon;
@synthesize sky;
@synthesize startColors;
@synthesize endColors;
@synthesize hues;
@synthesize slideMenuController;

float minutesInPixel;


NSString *username;
NSString *host;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	slideMenuController = appDelegate.slideMenuController;
	slideMenuController.panGestureEnabled = NO;
	slideMenuController.contentViewWidthWhenMenuIsOpen = 700;
	
	self.hueErrorLogView.alpha = 0;
	
	UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(onPan:)];
    //[oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:panGestureRecognizer];
	
	currentMinute = 0.0f;
	[self updateTimeLabel];
    
	minutesInPixel = totalMinutes/ScreenWidth;

    CGRect skyRect = CGRectMake(0, 0, ScreenHeight, ScreenWidth - 200);

    sky = [[Sky alloc] initWithFrame:skyRect];
	
	NSDictionary *dict;
	startColors = [NSMutableArray array];
	endColors = [NSMutableArray array];
	hues = [NSMutableArray array];


	// 0 night
	[startColors addObject: [UIColor colorWithHue:0.84f saturation:0.68f brightness:0.00f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.66f saturation:0.71f brightness:0.04f alpha:1.00f]];
	dict = @{ @"h" : @47103, @"s" : @254, @"b" : @61 };
	[hues addObject:dict];
	
	// 1
	[startColors addObject: [UIColor colorWithHue:0.84f saturation:0.68f brightness:0.00f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.97f saturation:0.59f brightness:0.18f alpha:1.00f]];
	dict = @{ @"h" : @272, @"s" : @234, @"b" : @10 };
	[hues addObject:dict];
	
	// 2
	[startColors addObject: [UIColor colorWithHue:0.84f saturation:0.68f brightness:0.00f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.00f saturation:0.65f brightness:0.37f alpha:1.00f]];
	dict = @{ @"h" : @272, @"s" : @234, @"b" : @70 };
	[hues addObject:dict];
	
	// 3
	[startColors addObject: [UIColor colorWithHue:0.88f saturation:0.51f brightness:0.13f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.01f saturation:0.60f brightness:0.55f alpha:1.00f]];
	dict = @{ @"h" : @272, @"s" : @234, @"b" : @140 };
	[hues addObject:dict];
	
	// 4
	[startColors addObject: [UIColor colorWithHue:0.66f saturation:0.24f brightness:0.28f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.03f saturation:0.65f brightness:0.71f alpha:1.00f]];
	dict = @{ @"h" : @5237, @"s" : @242, @"b" : @180 };
	[hues addObject:dict];
	
	// 5
	[startColors addObject: [UIColor colorWithHue:0.65f saturation:0.31f brightness:0.40f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.04f saturation:0.66f brightness:0.78f alpha:1.00f]];
	dict = @{ @"h" : @4948, @"s" : @241, @"b" : @255 };
	[hues addObject:dict];
	
	// 6
	[startColors addObject: [UIColor colorWithHue:0.66f saturation:0.28f brightness:0.49f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.05f saturation:0.68f brightness:0.83f alpha:1.00f]];
	dict = @{ @"h" : @9940, @"s" : @239, @"b" : @255 };
	[hues addObject:dict];
	
	// 7
	[startColors addObject: [UIColor colorWithHue:0.64f saturation:0.32f brightness:0.60f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.06f saturation:0.69f brightness:0.86f alpha:1.00f]];
	dict = @{ @"h" : @10470, @"s" : @171, @"b" : @255 };
	[hues addObject:dict];
	
	// 8
	[startColors addObject: [UIColor colorWithHue:0.62f saturation:0.42f brightness:0.72f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.07f saturation:0.61f brightness:0.84f alpha:1.00f]];
	dict = @{ @"h" : @14958, @"s" : @241, @"b" : @255 };
	[hues addObject:dict];
	
	// 9
	[startColors addObject: [UIColor colorWithHue:0.62f saturation:0.36f brightness:0.77f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.07f saturation:0.51f brightness:0.84f alpha:1.00f]];
	dict = @{ @"h" : @14133, @"s" : @179, @"b" : @255 };
	[hues addObject:dict];
	
	// 10
	[startColors addObject: [UIColor colorWithHue:0.62f saturation:0.40f brightness:0.89f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.08f saturation:0.38f brightness:0.82f alpha:1.00f]];
	dict = @{ @"h" : @15894, @"s" : @83, @"b" : @255 };
	[hues addObject:dict];
	
	// 11
	[startColors addObject: [UIColor colorWithHue:0.62f saturation:0.39f brightness:0.98f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.08f saturation:0.11f brightness:0.81f alpha:1.00f]];
	dict = @{ @"h" : @16350, @"s" : @45, @"b" : @255 };
	[hues addObject:dict];
	
	// 12
	[startColors addObject: [UIColor colorWithHue:0.61f saturation:0.36f brightness:1.00f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.60f saturation:0.08f brightness:0.85f alpha:1.00f]];
	dict = @{ @"h" : @33837, @"s" : @10, @"b" : @255 };
	[hues addObject:dict];
	
	
	// 13
	[startColors addObject: [UIColor colorWithHue:0.61f saturation:0.41f brightness:1.00f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.61f saturation:0.19f brightness:0.93f alpha:1.00f]];
	dict = @{ @"h" : @34515, @"s" : @236, @"b" : @255 };
	[hues addObject:dict];
	
	// 14 day
	[startColors addObject: [UIColor colorWithHue:0.61f saturation:0.42f brightness:1.00f alpha:1.00f]];
	[endColors addObject: [UIColor colorWithHue:0.61f saturation:0.27f brightness:0.99f alpha:1.00f]];
	dict = @{ @"h" : @34515, @"s" : @236, @"b" : @255 };
	[hues addObject:dict];
	
    sky.startColor = [startColors objectAtIndex:14];
    sky.endColor = [endColors objectAtIndex:14];
	
    [self.view addSubview:sky];
    [self.view sendSubviewToBack:sky];

	[self positionMoon:currentMinute];
	
    self.moon.alpha = 0;
	self.sun.alpha = 0;

	[self animateMoonSun];
	
	[NSTimer scheduledTimerWithTimeInterval:.83
									 target:self
								   selector:@selector(tick)
								   userInfo:nil
									repeats:YES];
	
	
	//Hue Discovery
    [self logHueError:@"Searching for Hue..."];
	
}



- (void) tick
{
	currentMinute = currentMinute + 1;
	if (currentMinute > totalMinutes)
	{
		currentMinute = 0;
	}
	
	[self updateTimeLabel];
	
	[self animateMoonSun];
}

float lastX;
int currentMinute;
BOOL isPanning;

- (void)onPan:(UIPanGestureRecognizer *)recognizer {

	if(recognizer.state == UIGestureRecognizerStateEnded)
	{
		lastX = 0.0f;
		isPanning = NO;
		oldIndex = -1;
		daylightSet = NO;
		nightlightSet = NO;
	}
	else
	{
		isPanning = YES;
		CGPoint point = [recognizer translationInView:self.view];
		
		float currentX = point.x;
		float changeInX = currentX - lastX;
		
		currentMinute = currentMinute + changeInX;
		if (currentMinute < 0)
		{
			currentMinute = totalMinutes;
		}
		
		if (currentMinute > totalMinutes)
		{
			currentMinute = 0;
		}
		
		//NSLog(@"CurrentMinute - %i", currentMinute);
		
		lastX = currentX;
		
		[self updateTimeLabel];
        
		[self animateMoonSun];
	}
	
}

int oldIndex = -1;
bool daylightSet = NO;
bool nightlightSet = NO;

- (void) animateMoonSun
{
	NSString *dayPart = [self timeOfDayWord];
	int minutesInto = [self secondsIntoDayPart:dayPart];
	double percentComplete = [self percentTimeComplete:dayPart withMinutesIntoDayPart:minutesInto];
	
	if ([dayPart isEqualToString:dayPartDay])
	{
		oldIndex = -1;
		self.sun.alpha = 1;
		sky.startColor = [startColors objectAtIndex:14];
		sky.endColor = [endColors objectAtIndex:14];
		[self positionSun:percentComplete];
		
		if (!daylightSet)
		{
			[self changeHueWithIndex:14];
			daylightSet = YES;
		}
		
	}
	
	if ([dayPart isEqualToString:dayPartNight])
	{
		oldIndex = -1;
		self.moon.alpha = 1;
		sky.startColor = [startColors objectAtIndex:0];
		sky.endColor = [endColors objectAtIndex:0];
		[self positionMoon:percentComplete];
		
		if (!nightlightSet)
		{
			[self changeHueWithIndex:0];
			nightlightSet = YES;
		}
	}
	
	if ([dayPart isEqualToString:dayPartSunrise]) 
	{
		
		int index = (minutesInto / 9.0) + 1;
		
		if (index != oldIndex)
		{
			[self changeHueWithIndex:index];
			oldIndex = index;
		}
		
		sky.startColor = [startColors objectAtIndex:index];
		sky.endColor = [endColors objectAtIndex:index];

		self.sun.alpha = 0;
		self.moon.alpha = 0;
		
		daylightSet = NO;
		nightlightSet = NO;
	}
	
	if ([dayPart isEqualToString:dayPartSunset])
	{
		int index = ((minutesInSunset - minutesInto) / 9.0) + 1;
		
		sky.startColor = [startColors objectAtIndex:index];
		sky.endColor = [endColors objectAtIndex:index];
		
		if (index != oldIndex)
		{
			[self changeHueWithIndex:index];
			oldIndex = index;
		}
		
		self.sun.alpha = 0;
		self.moon.alpha = 0;
		
		daylightSet = NO;
		nightlightSet = NO;
	}
	

}

- (void) changeHueWithIndex:(int)index
{
	
	if (!isPanning)
	{
//		DPHue *someHue = [[DPHue alloc] initWithHueHost:host username:username];
//		[someHue readWithCompletion:^(DPHue *hue, NSError *err) {
//
//			NSDictionary *dict = [hues objectAtIndex:index];
//			
//			for (DPHueLight *light in hue.lights)
//			{
//				light.hue = [dict objectForKey:@"h"];
//				light.saturation = [dict objectForKey:@"s"];
//				light.brightness = [dict objectForKey:@"b"];
//				[light write];
//			}
//			
//		}];
	}
	
}

-(void) positionSun:(double)percentComplete
{
	CGRect sunFrame = self.sun.frame;
	
	
	double x = ((arcFactor * 2) * percentComplete) - arcFactor;
	
	double y = (0.05 * x) * (0.05 * x);
	
	//NSLog(@"x: %f   y:%f", x, y);
	
	sunFrame.origin.x = (x + 512) - (sunFrame.size.width / 2);
	sunFrame.origin.y = y - (sunFrame.size.height / 2) + verticalOffset;
	
	self.sun.frame = sunFrame;
	
	
}

-(void) positionMoon:(double)percentComplete
{
	CGRect moonFrame = self.moon.frame;
	
	double x = ((arcFactor * 2) * percentComplete) - arcFactor;
	
	double y = (0.05 * x) * (0.05 * x);
	
	//NSLog(@"x: %f   y:%f", x, y);
	
	moonFrame.origin.x = (x + 512) - (moonFrame.size.width / 2);
	moonFrame.origin.y = y - (moonFrame.size.height / 2) + verticalOffset;
	
	self.moon.frame = moonFrame;
	
}



- (int) secondsIntoDayPart:(NSString*)dayPart
{
	if ([dayPart isEqualToString:dayPartDay])
	{
		return currentMinute - dayStart;
	}
	
	if ([dayPart isEqualToString:dayPartSunset])
	{
		return currentMinute - sunsetStart;
	}
	
	if ([dayPart isEqualToString:dayPartSunrise])
	{
		return currentMinute - sunriseStart;
	}
	
	if ([dayPart isEqualToString:dayPartNight])
	{
		
		if (currentMinute >= nightStart)
		{
			return currentMinute - nightStart;
		}
		
		if (currentMinute < sunriseStart)
		{
			return currentMinute + 252;
		}
		
	}
	return 0;
}


- (double) percentTimeComplete:(NSString*)dayPart withMinutesIntoDayPart:(int)minutesInto
{
	double result;
	
	if ([dayPart isEqualToString:dayPartDay])
	{
		result = minutesInto/minutesInDay;
	}
	
	if ([dayPart isEqualToString:dayPartSunset])
	{
		result = minutesInto/minutesInSunset;
	}
	
	if ([dayPart isEqualToString:dayPartSunrise])
	{
		result = minutesInto/minutesInSunrise;
	}
	
	if ([dayPart isEqualToString:dayPartNight])
	{
		result = minutesInto/minutesInNight;
	}
	
	
	result = result;
	
	return result;
	
}

- (NSString *) timeOfDayWord
{
	NSString *result = [NSString string];
	
	if (currentMinute > nightStart || currentMinute < sunriseStart)
	{
		return dayPartNight;
	}
	
	if (currentMinute >= sunriseStart && currentMinute < dayStart)
	{
		return dayPartSunrise;
	}
	if (currentMinute >= dayStart && currentMinute < sunsetStart)
	{
		return dayPartDay;
	}
	if (currentMinute >= sunsetStart && currentMinute < nightStart)
	{
		return dayPartSunset;
	}
	
	
	return result;
}


- (void) updateTimeLabel
{
	NSString *minutes = [NSString string];
	if (currentMinute % 60 < 10)
	{
		minutes = [NSString stringWithFormat:@"0%i", currentMinute % 60];
	} else {
		minutes = [NSString stringWithFormat:@"%i", currentMinute % 60];
	}
	
	self.timeLabel.text = [NSString stringWithFormat:@"%i:%@",currentMinute/60, minutes];
}



#pragma mark - DPHueDiscover delegate

- (void)foundHueAt:(NSString *)host discoveryLog:(NSMutableString *)log {
	
	username = @"D91B68EFF1606584721584082E415C0E"; //[DPHue generateUsername];
	
	[self logHueError:@"Starting Hue discovery..."];
//    DPHue *someHue = [[DPHue alloc] initWithHueHost:host username:username];
//    [someHue readWithCompletion:^(DPHue *hue, NSError *err) {
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(createUsernameAt:) userInfo:host repeats:YES];
//    }];
}

- (void)createUsernameAt:(NSTimer *)timer {
    host = timer.userInfo;
	[self logHueError:[NSString stringWithFormat:@"Attempting to authenticate to %@\n", host]];

//    DPHue *someHue = [[DPHue alloc] initWithHueHost:host username:username];
//    [someHue readWithCompletion:^(DPHue *hue, NSError *err) {
//        if (hue.authenticated) {
//            [self logHueError:@"Successfully authenticated"];
//            [self.timer invalidate];
//			
//            self.foundHueHost = hue.host;
//            [self logHueError:[NSString stringWithFormat:@"Found Hue at %@, named '%@'!", hue.host, hue.name]];
//			
//			[slideMenuController.view makeToast:@"Connected to Phillips Hue!"
//									   duration:8.0
//									   position:[NSValue valueWithCGPoint:CGPointMake(512, 384)]
//										  title:@"Phillips Hue"
//										  image:[UIImage imageNamed:@"toastIconHue"]];
//			
//			[self animateMoonSun];
//			[self changeHueWithIndex:0];
//        } else {
//            [self logHueError:@"Authentication failed, will try to create username"];
//            [someHue registerUsername];
//        }
//    }];
}




- (void)discoveryTimeHasElapsed {
//    self.dhd = nil;
//    [self.timer invalidate];
//    if (!self.foundHueHost) {
//        [self logHueError:@"Failed to find Hue"];
//		[slideMenuController.view makeToast:@"Failed to connect to Phillips Hue.\nOpen settings panel to view log."
//								   duration:8.0
//								   position:[NSValue valueWithCGPoint:CGPointMake(512, 384)]
//									  title:@"Phillips Hue"
//									  image:[UIImage imageNamed:@"toastIconHueError"]];
//    }
}


- (void) logHueError:(NSString*)message
{
	NSLog(@"%@: %@\n", [NSDate date], message);
	self.hueErrorLogTextView.text = [NSString stringWithFormat:@"%@\n%@", self.hueErrorLogTextView.text, message];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didChangeTime:(int)minutes
{
	currentMinute = minutes;
	oldIndex = -1;
	daylightSet = NO;
	nightlightSet = NO;
	[self positionMoon:0];
	[self positionSun:0];
	[self animateMoonSun];
}

- (void) didRequestDisplayHueLog
{
	self.hueErrorLogView.alpha = 1;
}

- (IBAction)configButtonTouched:(UIButton *)sender {
	
	if (slideMenuController.isMenuOpen)
	{
		[slideMenuController showContentViewControllerAnimated:YES completion:^(BOOL finished){
			slideMenuController.panGestureEnabled = NO;
		}];
	} else {
		[slideMenuController showMenuAnimated:YES completion:nil];
	}
}
- (IBAction)closeHueLogButtonTapped:(UIButton *)sender {
	self.hueErrorLogView.alpha = 0;
}
@end
