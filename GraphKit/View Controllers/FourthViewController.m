//
//  FourthViewController.m
//  GraphKit
//
//  Created by Sunil Rao on 02/06/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import "FourthViewController.h"
#import "GraphData.h"
#import "PieChartView.h"

#define PIE_CHART_DIA           self.view.frame.size.width * 0.80

@implementation FourthViewController
{
    PieChartView *pieChartView;
    UILabel *pieChartTitleLabel;
    NSTimer *timer;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.tabBarController.tabBar.frame.size.height)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tabBarItem setTitle:@"Animated Pie Chart"];

    /********** creating pie chart data ******/
    NSArray *dataSource = [[UtilityFunctions sharedUtilityFunctions] createRandomDataSetOfObjects:10];
    pieChartView = [[PieChartView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.self.frame.size.height) andPieChartData:dataSource];
//    pieChartView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - self.view.frame.size.width/2);
    [self.view addSubview:pieChartView];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1/30.0 target:self selector:@selector(nextFrame) userInfo:NULL repeats:YES];

    //Initializing pie chart title label
    pieChartTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height* 0.10)];
    pieChartTitleLabel.textAlignment = NSTextAlignmentCenter;
    pieChartTitleLabel.text = @"Animated Pie Chart";
    [pieChartTitleLabel setFont:[UIFont systemFontOfSize:20]];
    [self.view addSubview:pieChartTitleLabel];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    [pieChartView touchedPoint:[t locationInView:pieChartView]];
}

- (void)nextFrame
{
    [pieChartView tick];
    [pieChartView setNeedsDisplay];
}

@end
