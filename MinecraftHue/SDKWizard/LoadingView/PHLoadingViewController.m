//
//  PHLoadingViewController.m
//  SDK3rdApp
//
//  Created by Michael de Vries on 31-10-12.
//  Copyright (c) 2012 Philips. All rights reserved.
//

#import "PHLoadingViewController.h"

@interface PHLoadingViewController ()

@end

@implementation PHLoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Make sure it stays fullscreen
        self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	NSMutableArray * sequence = [NSMutableArray array];
	
	for (int i = 1; i <= 12; i++) {
		[sequence addObject:[UIImage imageNamed:[NSString stringWithFormat:@"searching%i",i]]];
	}
	for (int j = 11; j >= 2; j--) {
		[sequence addObject:[sequence objectAtIndex:j-1]];  // -1 since arrays are 0-based
	}
	
	self.searchingImageView.animationImages = sequence;
	self.searchingImageView.animationDuration = 1.0;
	self.searchingImageView.animationRepeatCount = 0;
	[self.searchingImageView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSearchingImageView:nil];
    [super viewDidUnload];
}
@end
