//
//  PieChart.m
//  GraphKit
//
//  Created by Sunil Rao on 02/06/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import "PieChart.h"
#import "GraphData.h"
#import "PieSlice.h"

@implementation PieChart
{
    NSArray *percentageDataArray;
    NSString *pieChartTitle;
}

- (instancetype)initWithData:(NSArray *)pieChartDataArray withTitle:(NSString *)title
{
    self = [super init];
    
    if (self)
    {
        percentageDataArray = [self convertDataToPercentagesFromDataArray:pieChartDataArray];
        pieChartTitle = title;
        
        self.pieSlicesArray = [self createPieSlicesForPercentagesArray:percentageDataArray];
    }

    return self;
}

//Converting x and y coordinates to percentage values
- (NSArray *)convertDataToPercentagesFromDataArray:(NSArray *)dataArray
{
    NSMutableArray *percentageArray = [[NSMutableArray alloc] init];
    
    CGFloat totalSum = 0;
    
    for (GraphData *graphData in dataArray)
        totalSum += graphData.y_point;
    
    for (GraphData *graphData in dataArray)
    {
        GraphData *centData = [[GraphData alloc] init];
        centData.x_point = graphData.x_point;
        centData.y_point = graphData.y_point/totalSum * 100.0;
        centData.xAxisName = graphData.xAxisName;
        centData.yAxisName = graphData.yAxisName;
        centData.valueColor = graphData.valueColor;
        centData.valueDescription = graphData.valueDescription;
        [percentageArray addObject:(id)centData];
    }
    
    return [percentageArray copy];
}

- (NSArray *)createPieSlicesForPercentagesArray:(NSArray *)perData
{
    NSMutableArray *slicesArray = [[NSMutableArray alloc] init];
    
    for (GraphData *slicesData in perData)
    {
        PieSlice *slice = [[PieSlice alloc] initWithPercentage:slicesData.y_point addTitle:slicesData.yAxisName addDescription:slicesData.valueDescription andColor:slicesData.valueColor];
        [slicesArray addObject:slice];
    }
    
    return slicesArray;
}

@end
