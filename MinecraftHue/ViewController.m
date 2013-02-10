//
//  ViewController.m
//  MinecraftHue
//
//  Created by James Rutherford on 2013-02-10.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define totalMinutes 1440
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()

@end

@implementation ViewController

@synthesize moon;

float minutesInPixel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(onPan:)];
    //[oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:panGestureRecognizer];
	
	currentMinute = 0.0f;
	[self updateTimeLabel];
	minutesInPixel = totalMinutes/ScreenWidth;
	
}

float lastX;
int currentMinute;

- (void)onPan:(UIPanGestureRecognizer *)recognizer {

	if(recognizer.state == UIGestureRecognizerStateEnded)
	{
		lastX = 0.0f;
	} else
	{
	
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
		
		NSLog(@"CurrentMinute - %i", currentMinute);
		
		lastX = currentX;
		
		[self updateTimeLabel];
	}
	
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTouched:(id)sender {
	
	
	
	
	moon.alpha = 1.0f;
	CGRect imageFrame = moon.frame;
	//Your image frame.origin from where the animation need to get start
	CGPoint viewOrigin = moon.frame.origin;
	viewOrigin.y = viewOrigin.y + imageFrame.size.height / 2.0f;
	viewOrigin.x = viewOrigin.x + imageFrame.size.width / 2.0f;
	
	moon.frame = imageFrame;
	moon.layer.position = viewOrigin;
	
	// Set up fade out effect
	CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	[fadeOutAnimation setToValue:[NSNumber numberWithFloat:0.3]];
	fadeOutAnimation.fillMode = kCAFillModeForwards;
	fadeOutAnimation.removedOnCompletion = NO;
	
	// Set up scaling
	CABasicAnimation *resizeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
	[resizeAnimation setToValue:[NSValue valueWithCGSize:CGSizeMake(40.0f, imageFrame.size.height * (40.0f / imageFrame.size.width))]];
	resizeAnimation.fillMode = kCAFillModeForwards;
	resizeAnimation.removedOnCompletion = NO;
	
	// Set up path movement
	CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	pathAnimation.calculationMode = kCAAnimationPaced;
	pathAnimation.fillMode = kCAFillModeForwards;
	pathAnimation.removedOnCompletion = NO;
	//Setting Endpoint of the animation
	CGPoint endPoint = CGPointMake(480.0f - 30.0f, 40.0f);
	//to end animation in last tab use
	//CGPoint endPoint = CGPointMake( 320-40.0f, 480.0f);
	CGMutablePathRef curvedPath = CGPathCreateMutable();
	CGPathMoveToPoint(curvedPath, NULL, viewOrigin.x, viewOrigin.y);
	CGPathAddCurveToPoint(curvedPath, NULL, endPoint.x, viewOrigin.y, endPoint.x, viewOrigin.y, endPoint.x, endPoint.y);
	pathAnimation.path = curvedPath;
	CGPathRelease(curvedPath);
	
	CAAnimationGroup *group = [CAAnimationGroup animation];
	group.fillMode = kCAFillModeForwards;
	group.removedOnCompletion = NO;
	[group setAnimations:[NSArray arrayWithObjects:fadeOutAnimation, pathAnimation, resizeAnimation, nil]];
	group.duration = 0.7f;
	group.delegate = self;
	[group setValue:moon forKey:@"imageViewBeingAnimated"];
	
	[moon.layer addAnimation:group forKey:@"savingAnimation"];
	
	
	
}
@end
