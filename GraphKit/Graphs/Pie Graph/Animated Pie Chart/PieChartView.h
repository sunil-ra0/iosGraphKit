//
//  PieChartView.h
//  GraphKit
//
//  Created by Sunil Rao on 02/06/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartView : UIView

- (instancetype)initWithFrame:(CGRect)frame andPieChartData:(NSArray *)pieChartData;
- (void)tick;
- (void)touchedPoint:(CGPoint)touchPoint;
@end
