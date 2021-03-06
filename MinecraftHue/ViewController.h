//
//  ViewController.h
//  MinecraftHue
//
//  Created by James Rutherford on 2013-02-10.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sky.h"
#import <DPHue/DPHueDiscover.h>
#import <DPHue/DPHue.h>
#import "NVSlideMenuController.h"
#import "SettingsViewController.h"

@interface ViewController : UIViewController<DPHueDiscoverDelegate, SettingsViewControllerDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) DPHueDiscover *dhd;
@property (nonatomic, strong) DPHue *touchlinkHue;

@property (nonatomic, strong) NSString *foundHueHost;

@property (weak, nonatomic) IBOutlet UIImageView *moon;
@property (weak, nonatomic) IBOutlet UIImageView *sun;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) NSMutableArray *startColors;
@property (nonatomic, strong) NSMutableArray *endColors;
@property (nonatomic, strong) NSMutableArray *hues;
@property (strong, nonatomic) Sky *sky;

@property (weak, nonatomic) IBOutlet UIButton *configButton;
- (IBAction)configButtonTouched:(UIButton *)sender;

@property (strong, nonatomic)  NVSlideMenuController *slideMenuController;

@property (weak, nonatomic) IBOutlet UIView *hueErrorLogView;
@property (weak, nonatomic) IBOutlet UITextView *hueErrorLogTextView;
- (IBAction)closeHueLogButtonTapped:(UIButton *)sender;

@end
