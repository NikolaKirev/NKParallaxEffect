//
//  UIView+NKParrallaxEffect.h
//
//  Created by Nikola Kirev on 9/23/13.
//  Copyright (c) 2013 Nikola Kirev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NKParallaxType){
    NKParallaxTypeHorizontalAxis,
    NKParallaxTypeVerticalAxis,
    NKParallaxTypeMultiAxis
};

@interface UIView (NKParrallaxEffect)

/**
 NOTE: The term AMPLITUDE used bellow refers to "peak amplitede". This is the deviation from the center.
 For example, of the amplitude is 10, the view will move 10 points on both sides. Its whole amplitude (peak-to-peak amplitude) will be 20 points.
 */

/**
 Adds parallax effect to your view. Has custom values amplitudes for both X and Y axis and has the option to be inverted.
 Using this method, you can add parallax effect for both X and Y axis with different custom values.

 @param Value for the custom horizontal amplitude of the parallax effect.

 @param Value for the custom vertical amplitude of the parallax effect.

 @param Boolean value that indicates if the parallax effect should be inverted.
*/
- (void)addParallaxWithHorizontalRelativeAmplitude:(CGFloat)horizontalAmplitude
                         verticalRelativeAmplitude:(CGFloat)verticalAmplitude
                                          inverted:(BOOL)inverted;

/**
 Adds parallax effect to your view. Has a custom value amplitude for X and/or Y axis and has the option to be inverted.
 
 @param Indicates the axis type of the effect - horizontal, vertical or both.
 
 @param Value for the custom amplitude of the parallax effect.
 
 @param Boolean value that indicates if the parallax effect should be inverted.
 */
- (void)addParallaxWithType:(NKParallaxType)parallaxType relativeAmplitude:(CGFloat)relativeAmplitude inverted:(BOOL)inverted;

/**
 Adds parallax effect to your view. Has 10.0f amplitude on X and/or Y axis and has the option to be inverted.
 
 @param Indicates the axis type of the effect - horizontal, vertical or both.
 
 @param Boolean value that indicates if the parallax effect should be inverted.
 */
- (void)addParallaxWithType:(NKParallaxType)parallaxType inverted:(BOOL)inverted;

/**
 Adds default parallax effect to your view. Has 10.0f amplitude on X and Y axis and has the option to be inverted.
 
 @param Boolean value that indicates if the parallax effect should be inverted.
 */
- (void)addParallaxInverted:(BOOL)inverted;

/**
 Adds default parallax effect to your view. Has 10.0f amplitude on X and Y axis and is not inverted.
 */
- (void)addParallaxToView;

@end
