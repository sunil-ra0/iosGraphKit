//
//  BarGraph.h
//  GraphKit
//
//  Created by Sunil Rao on 02/05/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphScale.h"
#import "GraphData.h"

@interface BarGraph : UIView

- (instancetype)initWithDataSource:(NSArray *)dataArray graphScale:(GraphScale *)scale andGraphLayoutNeeded:(BOOL)layoutNeeded;

- (void)animateBarGraph;
@end
