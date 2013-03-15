//
//  SettingsViewController.m
//  MinecraftHue
//
//  Created by James Rutherford on 2013-03-04.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "NVSlideMenuController.h"
#import "Toast+UIView.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize slideMenuController;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	slideMenuController = appDelegate.slideMenuController;
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calibrateTimeButtonTapped:(UIButton *)sender {

	int ticks = 0;
	int minutes = 0;
	
	
	switch (sender.tag) {
		case 0:
			//day
			ticks = 0;
			minutes = dayStart;
			break;
		case 1:
			//night
			ticks = 1400;
			minutes = nightStart;
			break;
		case 2:
			//noon
			ticks = 6000;
			minutes = noonStart;
			break;
		case 3:
			//midnight
			ticks = 18000;
			minutes = midnightStart;
			break;
		case 4:
			//sunset
			ticks = 12000;
			minutes = sunsetStart;
			break;
		case 5:
			//sunrise
			ticks = 23000;
			minutes = sunriseStart;
			break;
		default:
			break;
	}
	
	SEL didChangeTimeSelector = @selector(didChangeTime:);
	if (self.delegate && [self.delegate respondsToSelector:didChangeTimeSelector]) {
		[self.delegate didChangeTime:minutes];
	}
	
	[slideMenuController showContentViewControllerAnimated:YES completion:^(BOOL finished){
		slideMenuController.panGestureEnabled = NO;
		[slideMenuController.view makeToast:[NSString stringWithFormat:@"/time set %i", ticks]
								   duration:8.0
								   position:[NSValue valueWithCGPoint:CGPointMake(512, 384)]
									  title:@"Calibrate Time in Minecraft"
									  image:[UIImage imageNamed:@"toastIcon"]];
	}];
	
	
}

- (IBAction)closeButtonTapped:(UIButton *)sender {
	
	[slideMenuController showContentViewControllerAnimated:YES completion:^(BOOL finished){
		slideMenuController.panGestureEnabled = NO;
	}];
	
}
- (IBAction)hueLogButtonTapped:(UIButton *)sender {
	[slideMenuController showContentViewControllerAnimated:YES completion:^(BOOL finished){
		slideMenuController.panGestureEnabled = NO;
		SEL didRequestDisplayHueLogSelector = @selector(didRequestDisplayHueLog);
		if (self.delegate && [self.delegate respondsToSelector:didRequestDisplayHueLogSelector]) {
			[self.delegate didRequestDisplayHueLog];
		}
	}];
	
	
}

#pragma mark - Rotation

- (BOOL)shouldAutorotate
{
	return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
	return UIInterfaceOrientationLandscapeRight;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
