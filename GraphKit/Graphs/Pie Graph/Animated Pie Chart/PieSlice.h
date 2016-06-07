//
//  PieSlice.h
//  GraphKit
//
//  Created by Sunil Rao on 02/06/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PieSlice : NSObject

@property(nonatomic) float slicePercentage;
@property(nonatomic,strong) NSString *sliceTitle, *sliceDescrip;
@property(nonatomic,strong) UIColor *sliceColor;

-(instancetype)initWithPercentage:(float)percentage addTitle:(NSString *)title addDescription:(NSString *)descrip andColor:(UIColor *)color;

@end