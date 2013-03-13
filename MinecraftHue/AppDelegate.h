//
//  AppDelegate.h
//  MinecraftHue
//
//  Created by James Rutherford on 2013-02-10.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NVSlideMenuController.h"
#import "SettingsViewController.h"

#import "PHBridgeSelectionViewController.h"
#import "PHBridgePushLinkViewController.h"
#import "PHSoftwareUpdateManager.h"

@class AppDelegate;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate, PHBridgeSelectionViewControllerDelegate, PHBridgePushLinkViewControllerDelegate, PHSoftwareUpdateManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SettingsViewController *menuViewController;
@property (strong, nonatomic) UIViewController *contentViewController;
@property (strong, nonatomic)  NVSlideMenuController *slideMenuController;

@property (nonatomic, strong) PHHueSDK *phHueSDK;

#pragma mark - HueSDK

/**
 Starts the local heartbeat
 */
- (void)enableLocalHeartbeat;

/**
 Stops the local heartbeat
 */
- (void)disableLocalHeartbeat;

/**
 Starts a search for a bridge
 */
- (void)searchForBridgeLocal;

@end
