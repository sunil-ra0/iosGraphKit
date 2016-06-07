//
//  PieChart.h
//  GraphKit
//
//  Created by Sunil Rao on 02/06/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PieChart : NSObject

@property (nonatomic,strong) NSArray *pieSlicesArray;

- (instancetype)initWithData:(NSArray *)pieChartDataArray withTitle:(NSString *)title;

@end
