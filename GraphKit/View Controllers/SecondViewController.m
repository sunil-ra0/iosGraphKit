//
//  SecondViewController.m
//  GraphKit
//
//  Created by Sunil Rao on 02/05/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import "SecondViewController.h"
#import "GraphScale.h"
#import "GraphData.h"
#import "BarGraph.h"

@interface SecondViewController ()

@property (nonatomic,strong) BarGraph *barGraphView;

@end

@implementation SecondViewController

- (void)loadView
{
    [super loadView];
    
    [self.tabBarItem setTitle:@"Bar Graph"];
    
    //Creating data for graph
    GraphScale *graphScale = [[GraphScale alloc] init];
    graphScale.x_unit = 1;
    graphScale.y_unit = 1;
    graphScale.min_x = 0;
    graphScale.max_x = 10;
    graphScale.min_y = 0;
    graphScale.max_y = 20;
    
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    
    for (float a = 0; a < (graphScale.max_x - graphScale.min_x); a++)
    {
        GraphData *data = [[GraphData alloc] init];
        data.x_point = a;
        data.y_point = a * 2;
        
        [dataSource addObject:(id)data];
    }
    
    self.barGraphView = [[BarGraph alloc] initWithDataSource:dataSource graphScale:graphScale andGraphLayoutNeeded:YES];
    [self.view addSubview:self.barGraphView];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.barGraphView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height);
}

@end
