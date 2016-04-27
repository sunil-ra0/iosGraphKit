//
//  LineGraph.m
//  GraphKit
//
//  Created by Sunil Rao on 26/04/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import "LineGraph.h"

#define TOTAL_X_DIST        VIEW_BOUNDS_WIDTH * 0.90
#define TOTAL_Y_DIST        VIEW_BOUNDS_HEIGHT * 0.80
#define STARTING_X          VIEW_BOUNDS_WIDTH * 0.10
#define ENDING_X            VIEW_BOUNDS_WIDTH * 0.95
#define STARTING_Y          VIEW_BOUNDS_HEIGHT * 0.85
#define ENDING_Y            VIEW_BOUNDS_HEIGHT * 0.05

@interface LineGraph()

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) GraphScale *scale;
@property (nonatomic,strong) NSMutableArray *coordinatePointsArray;
@property (nonatomic) BOOL isLayoutNeeded;
@property (nonatomic,assign) float spacingX;
@property (nonatomic,assign) float spacingY;
@property (nonatomic,strong)NSMutableArray *xDataLable;
@property (nonatomic,strong)NSMutableArray *yDataLable;
@property (nonatomic,strong) CAShapeLayer *graphLayout;
@property (nonatomic,strong) UILabel *xAxisTitleLabel, *yAxisTitleLabel;

@end

@implementation LineGraph

//Initializing data
- (instancetype)initWithDataSource:(NSArray *)dataArray graphScale:(GraphScale *)scale andGraphLayoutNeeded:(BOOL)layoutNeeded;
{
    self =[super init];
    
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        self.dataArray = dataArray;
        self.scale = scale;
        self.isLayoutNeeded = layoutNeeded;
        [self setContentMode:UIViewContentModeRedraw];
        
        self.xDataLable = [[NSMutableArray alloc]init];
        self.yDataLable = [[NSMutableArray alloc]init];
        self.coordinatePointsArray = [[NSMutableArray alloc]init];

        
//        self.pointsArray = [[NSMutableArray alloc]init];
//        self.gradientLayer = [[CAGradientLayer alloc]init];
//        self.gradientMask = [[CAShapeLayer alloc]init];
//        self.graphPointsArray = [[NSMutableArray alloc]init];

        
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //Create graph data
    [self createGraphCoordinates];
    
    //Create Graph layout
    if (self.isLayoutNeeded)
    {
        [self createGraphLayout];
    }
    
    [self drawLineGraph];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float ix = STARTING_X;
    float iy = STARTING_Y;
    
    //Layouts for x-axis label
    for (UILabel *label in self.xDataLable)
    {
        if (ix <= (TOTAL_X_DIST + self.spacingX))
        {
            [label setFrame:CGRectMake(ix, STARTING_Y, self.spacingX, VIEW_BOUNDS_HEIGHT * 0.05)];
            label.center = CGPointMake((ix+(self.spacingX/2)), label.center.y);
            [self addSubview:label];
        }
        ix = ix + self.spacingX;
    }
    
    for (UILabel *label in self.yDataLable)
    {
        if (iy <= (TOTAL_Y_DIST + self.spacingY))
        {
            label.textAlignment = NSTextAlignmentCenter;
            [label setFrame:CGRectMake(STARTING_X - VIEW_BOUNDS_WIDTH * 0.05, iy - self.spacingY/2, VIEW_BOUNDS_WIDTH * 0.05, self.spacingY)];
            [self addSubview:label];
        }
        iy = iy - self.spacingY;
    }
}

#pragma mark - data creation methods
- (void)createGraphCoordinates
{
    self.spacingX = TOTAL_X_DIST/((self.scale.max_x - self.scale.min_x)/self.scale.x_unit);
    self.spacingY = TOTAL_Y_DIST/((self.scale.max_y - self.scale.min_y)/self.scale.y_unit);
    
    for (GraphData *data in self.dataArray)
    {
        CGPoint coordinate;
        coordinate.x = (STARTING_X*self.scale.x_unit + (data.x_point * self.spacingX) + self.spacingX/1.5)/self.scale.x_unit;
        coordinate.y = (STARTING_Y*self.scale.y_unit - (data.y_point * self.spacingY))/self.scale.y_unit;
        
        [self.coordinatePointsArray addObject:[NSValue valueWithCGPoint:coordinate]];
    }
}

#pragma  mark - graph drawing methods
- (void)createGraphLayout
{
    //Clear old graph layout
    [self.graphLayout removeFromSuperlayer];
    
    //Creating gaph layout path (Border)
    UIBezierPath *graphPath = [[UIBezierPath alloc]init];
    
    [graphPath setLineWidth:LAYOUT_BORDER_THICKNESS];
    [[UIColor blackColor] setStroke];
    [graphPath moveToPoint:CGPointMake(ENDING_X, STARTING_Y)];
    [graphPath addLineToPoint:CGPointMake(STARTING_X, STARTING_Y)];
    [graphPath addLineToPoint:CGPointMake(STARTING_X, ENDING_Y)];
    
    //Creating graph layout
    self.graphLayout = [CAShapeLayer layer];
    self.graphLayout.fillColor = [[UIColor clearColor] CGColor];
    self.graphLayout.strokeColor = [GRAPH_LAYOUT_COLOR CGColor];
    self.graphLayout.lineWidth = GRAPH_LAYOUT_LINE_THICKNESS;
    self.graphLayout.path = [graphPath CGPath];
    [self.layer addSublayer:self.graphLayout];
    
    //Remove old label data
    for (UILabel *label in self.xDataLable)
    {
        [label removeFromSuperview];
    }
    for (UILabel *label in self.yDataLable)
    {
        [label removeFromSuperview];
    }

    [self.xDataLable removeAllObjects];
    [self.yDataLable removeAllObjects];
    
    //creating x-axis data label
    for (float i = self.scale.min_x; i <= self.scale.max_x; i = i + self.scale.x_unit)
    {
        [self.xDataLable addObject:[self createGraphLayoutLabelMarkingsWithValue:i]];
    }
    
    //creating y-axis data label
    for (float i = self.scale.min_y; i <= self.scale.max_y; i = i + self.scale.y_unit)
    {
        [self.yDataLable addObject:[self createGraphLayoutLabelMarkingsWithValue:i]];
    }
}

- (UILabel *)createGraphLayoutLabelMarkingsWithValue:(float)i
{
    UILabel *marking = [[UILabel alloc] init];
    marking.textColor = GRAPH_LABEL_COLOR;
    marking.textAlignment = NSTextAlignmentLeft;
    marking.text = [NSString stringWithFormat:@"%.0f",i];
    [marking setFont:[UIFont fontWithName:GRAPH_LABEL_FONT_STYLE size:GRAPH_LABEL_FONT_SIZE]];
    return marking;
}

- (void)drawLineGraph
{
    
}

@end
