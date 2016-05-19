//
//  LineGraph.h
//  GraphKit
//
//  Created by Sunil Rao on 26/04/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphData.h"
#import "GraphScale.h"

@interface LineGraph : UIView

- (instancetype)initWithDataSource:(NSArray *)dataArray graphScale:(GraphScale *)scale andGraphLayoutNeeded:(BOOL)layoutNeeded;

@end
