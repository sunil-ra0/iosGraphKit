//
//  PieGraphView.m
//  GraphKit
//
//  Created by Sunil Rao on 19/05/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import "PieGraphView.h"
#import "GraphData.h"

@interface PieGraphView()

@property (nonatomic,strong) NSArray *dataArray, *centDataArray;

@end

@implementation PieGraphView

- (instancetype)initWithPieDataArray:(NSArray *)dataArray
{
    self = [super init];
    
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.dataArray = dataArray;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.centDataArray = [self convertDataToPercentagesFromDataArray:self.dataArray];
    
    CGFloat startAngel = 0;
    CGFloat endAngle;
    
    for (GraphData *graphData in self.centDataArray)
    {
        endAngle = startAngel + (graphData.y_point*3.6*M_PI)/180;
        
        UIBezierPath *pieSlicePath = [[UIBezierPath alloc] init];
        [pieSlicePath moveToPoint:self.center];
        [pieSlicePath addArcWithCenter:self.center radius:self.frame.size.width/2  startAngle:startAngel endAngle:endAngle clockwise:YES];
        
        CAShapeLayer *pieSliceShapeLayer = [CAShapeLayer layer];
        pieSliceShapeLayer.path = [pieSlicePath CGPath];
        //        pieSliceShapeLayer.fillColor = [(UIColor *)[self.colorsArray objectAtIndex:a] CGColor];
        pieSliceShapeLayer.fillColor = (__bridge CGColorRef _Nullable)((UIColor *)graphData.valueColor.CGColor);
        pieSliceShapeLayer.lineWidth = 0;
        [self.layer addSublayer:pieSliceShapeLayer];
        startAngel = endAngle;

    }
}

// Converting Raw data to percentage data

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
        [percentageArray addObject:(id)centData];
    }
    
    return [percentageArray copy];
}

@end
