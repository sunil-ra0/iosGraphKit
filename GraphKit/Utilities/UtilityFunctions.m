//
//  UtilityFunctions.m
//  GraphKit
//
//  Created by Sunil Rao on 19/05/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import "UtilityFunctions.h"

@implementation UtilityFunctions

static UtilityFunctions *sharedUtilityFunctionObject = nil;

+(UtilityFunctions *)sharedUtilityFunctions
{
    if (sharedUtilityFunctionObject == nil)
    {
        sharedUtilityFunctionObject = [[UtilityFunctions alloc] init];
    }
    
    return sharedUtilityFunctionObject;
}

/// Method to create Prototype of CAShapeLayer
-(CAShapeLayer *)createShapeLayerWithFillColor:(UIColor *)fillColor StrokeColor:(UIColor *)strokeColor LineWidth:(CGFloat)lineWidth andPathRef:(CGPathRef)pathRef
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [fillColor CGColor];
    shapeLayer.strokeColor = [strokeColor CGColor];
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.path = pathRef;

    return shapeLayer;
}

///Method to create Prototype for CAGradientLayer

- (CAGradientLayer *)createGradientLayerWithStartPoint:(CGPoint)startPoint Endpoint:(CGPoint)endPoint ColorsArray:(NSArray *)colorsArray andFrame:(CGRect)gradLayerFrame
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.masksToBounds = YES;
    gradientLayer.colors = colorsArray;
    gradientLayer.frame = gradLayerFrame;
    
    return gradientLayer;
}


@end
