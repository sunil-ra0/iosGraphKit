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
    [super loadView];
    
    [self.tabBarItem setTitle:@"Line Graph"];
    
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
    
    self.lineGraphView = [[LineGraph alloc] initWithDataSource:dataSource graphScale:graphScale andGraphLayoutNeeded:YES];
    [self.view addSubview:self.lineGraphView];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.lineGraphView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
