//
//  UtilityFunctions.h
//  GraphKit
//
//  Created by Sunil Rao on 19/05/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilityFunctions : NSObject

+(UtilityFunctions *)sharedUtilityFunctions;

- (NSArray *)createRandomDataSetOfObjects:(int)num;

-(CAShapeLayer *)createShapeLayerWithFillColor:(UIColor *)fillColor StrokeColor:(UIColor *)strokeColor LineWidth:(CGFloat)lineWidth andPathRef:(CGPathRef)pathRef;

- (CAGradientLayer *)createGradientLayerWithStartPoint:(CGPoint)startPoint Endpoint:(CGPoint)endPoint ColorsArray:(NSArray *)colorsArray andFrame:(CGRect)gradLayerFrame;

@end
