//
//  UIView+NKParrallaxEffect.m
//
//  Created by Nikola Kirev on 9/23/13.
//  Copyright (c) 2013 Nikola Kirev. All rights reserved.
//

#define kDefaultXAmplitude 10.0f
#define kDefaultYAmplitude 10.0f

#import "UIView+NKParrallaxEffect.h"

@implementation UIView (NKParrallaxEffect)

#pragma mark - Private Helper Methods

- (UIInterpolatingMotionEffect *)interpolatingParallaxWithType:(UIInterpolatingMotionEffectType)type amplitude:(CGFloat)amplitude {
    
    NSString *axisKeyPath;
    if (type == UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis) {
        axisKeyPath = @"center.x";
    } else if (type == UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis) {
        axisKeyPath = @"center.y";
    }
    
    UIInterpolatingMotionEffect *axisMotion = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:axisKeyPath
                                                                                               type:type];
    [axisMotion setMinimumRelativeValue:@(-amplitude)];
    [axisMotion setMaximumRelativeValue:@(amplitude)];
    
    return axisMotion;
}

#pragma mark - Public Methods for Adding Parallax Effect

- (void)addParallaxWithHorizontalRelativeAmplitude:(CGFloat)horizontalAmplitude
                         verticalRelativeAmplitude:(CGFloat)verticalAmplitude
                                          inverted:(BOOL)inverted {
    
    CGFloat xAmplitude = inverted ? horizontalAmplitude*(-1.0f) : horizontalAmplitude;
    CGFloat yAmplitude = inverted ? verticalAmplitude*(-1.0f) : verticalAmplitude;
    
    UIInterpolatingMotionEffect *xMotion = [self interpolatingParallaxWithType:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis amplitude:xAmplitude];
    UIInterpolatingMotionEffect *yMotion = [self interpolatingParallaxWithType:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis amplitude:yAmplitude];
    
    UIMotionEffectGroup *motionGroup = [[UIMotionEffectGroup alloc] init];
    motionGroup.motionEffects = @[xMotion, yMotion];
    [self addMotionEffect:motionGroup];
}

- (void)addParallaxWithType:(NKParallaxType)parallaxType relativeAmplitude:(CGFloat)relativeAmplitude inverted:(BOOL)inverted {
    
    if (relativeAmplitude == 0.0f) {
        return;
    }
    
    switch (parallaxType) {
        case NKParallaxTypeHorizontalAxis:{
            CGFloat xAmplitude = inverted ? relativeAmplitude*(-1.0f) : relativeAmplitude;
            [self addMotionEffect:[self interpolatingParallaxWithType:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis amplitude:xAmplitude]];
        }
            break;
        case NKParallaxTypeVerticalAxis:{
            CGFloat yAmplitude = inverted ? relativeAmplitude*(-1.0f) : relativeAmplitude;
            [self addMotionEffect:[self interpolatingParallaxWithType:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis amplitude:yAmplitude]];
        }
            break;
        case NKParallaxTypeMultiAxis:
            [self addParallaxWithHorizontalRelativeAmplitude:relativeAmplitude verticalRelativeAmplitude:relativeAmplitude inverted:inverted];
            break;
        default:
            break;
    }
}

- (void)addParallaxWithType:(NKParallaxType)parallaxType inverted:(BOOL)inverted {
    
    switch (parallaxType) {
        case NKParallaxTypeHorizontalAxis:
            [self addParallaxWithType:parallaxType relativeAmplitude:kDefaultXAmplitude inverted:inverted];
            break;
        case NKParallaxTypeVerticalAxis:
            [self addParallaxWithType:parallaxType relativeAmplitude:kDefaultYAmplitude inverted:inverted];
            break;
        case NKParallaxTypeMultiAxis:
            [self addParallaxWithHorizontalRelativeAmplitude:kDefaultXAmplitude verticalRelativeAmplitude:kDefaultYAmplitude inverted:inverted];
            break;
        default:
            break;
    }
}

- (void)addParallaxInverted:(BOOL)inverted {
    
    [self addParallaxWithType:NKParallaxTypeMultiAxis inverted:inverted];
}

- (void)addParallaxToView {
    
    [self addParallaxInverted:NO];
}

@end
