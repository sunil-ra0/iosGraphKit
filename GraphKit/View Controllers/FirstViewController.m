//
//  FirstViewController.m
//  GraphKit
//
//  Created by Sunil Rao on 27/04/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import "FirstViewController.h"
#import "LineGraph.h"

@interface FirstViewController ()

@property (nonatomic,strong) LineGraph *lineGraphView;

@end

@implementation FirstViewController

- (void)loadView
{
    self.view = [[UIView alloc] init];
    
    [self.tabBarItem setTitle:@"Line Graph"];
    
    //Creating data for graph
    GraphScale *graphScale = [[GraphScale alloc] init];
    graphScale.x_unit = 5;
    graphScale.y_unit = 1;
    graphScale.min_x = 0;
    graphScale.max_x = 30;
    graphScale.min_y = 0;
    graphScale.max_y = 20;
    
    NSArray *dataSource = [[UtilityFunctions sharedUtilityFunctions] createRandomDataSetOfObjects:30];
    
    self.lineGraphView = [[LineGraph alloc] initWithDataSource:dataSource graphScale:graphScale andGraphLayoutNeeded:YES];
    [self.view addSubview:self.lineGraphView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.lineGraphView animateLineGraph];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.lineGraphView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height);
    
}
@end
