//
//  SettingsViewController.h
//  MinecraftHue
//
//  Created by James Rutherford on 2013-03-04.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NVSlideMenuController.h"

@protocol SettingsViewControllerDelegate <NSObject>

- (void) didChangeTime:(int)minutes;
- (void) didRequestDisplayHueLog;

@end

@interface SettingsViewController : UIViewController

@property (nonatomic, assign) id<SettingsViewControllerDelegate> delegate;

- (IBAction)calibrateTimeButtonTapped:(UIButton *)sender;
- (IBAction)closeButtonTapped:(UIButton *)sender;

@property (strong, nonatomic)  NVSlideMenuController *slideMenuController;

@property (weak, nonatomic) IBOutlet UIButton *hueLogButton;
- (IBAction)hueLogButtonTapped:(UIButton *)sender;


@end
