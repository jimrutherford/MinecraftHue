//
//  AppDelegate.h
//  MinecraftHue
//
//  Created by James Rutherford on 2013-02-10.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NVSlideMenuController.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *menuViewController;
@property (strong, nonatomic) UIViewController *contentViewController;
@property (strong, nonatomic)  NVSlideMenuController *slideMenuController;

@end
