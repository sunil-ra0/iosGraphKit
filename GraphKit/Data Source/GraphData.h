//
//  GraphData.h
//  GraphKit
//
//  Created by Sunil Rao on 26/04/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface GraphData : NSObject

@property (nonatomic) CGFloat x_point;
@property (nonatomic) CGFloat y_point;
@property (nonatomic,strong) NSString *xAxisName;
@property (nonatomic,strong) NSString *yAxisName;
@property (nonatomic,strong) UIColor *valueColor;

@end