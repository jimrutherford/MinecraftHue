//
//  Sky.m
//  MinecraftHue
//
//  Created by Jim Rutherford on 2013-02-10.
//  Copyright (c) 2013 Braxio Interactive. All rights reserved.
//

#import "Sky.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation Sky

CGGradientRef _gradientRef;

@synthesize startColor;
@synthesize endColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint start = rect.origin;
    start.y = 0;
    CGPoint end = CGPointMake(rect.origin.x, rect.size.height);
    CGContextDrawLinearGradient(context, _gradientRef, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);

    [super drawRect:rect];
}

-(void) setStartColor:(UIColor *)theStartColor
{
    startColor = theStartColor;
    [self setupGradient];
}

-(void) setEndColor:(UIColor *)theEndColor
{
    endColor = theEndColor;
    [self setupGradient];
}

-(void) setupGradient
{

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSArray *gradientColors = [NSArray arrayWithObjects:
                       (id)startColor.CGColor, (id)endColor.CGColor, nil];
    _gradientRef = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) gradientColors, NULL);
    
    CGColorSpaceRelease(colorSpace);
    [self setNeedsDisplay];
}

@end
