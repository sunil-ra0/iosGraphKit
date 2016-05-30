//
//  ThirdViewController.m
//  GraphKit
//
//  Created by Sunil Rao on 19/05/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import "ThirdViewController.h"
#import "PieGraphView.h"
#import "GraphData.h"

@interface ThirdViewController ()

@property (nonatomic,strong) PieGraphView *pieGraphView;

@end

@implementation ThirdViewController

-(void)loadView
{
    self.view = [[UIView alloc] init];
    
    [self.tabBarItem setTitle:@"Pie Graph"];
    
    /********** creating pie chart data ******/
    NSArray *dataSource = [[UtilityFunctions sharedUtilityFunctions] createRandomDataSetOfObjects:10];
    
    self.pieGraphView = [[PieGraphView alloc] initWithPieDataArray:[dataSource copy]];
    [self.view addSubview:self.pieGraphView];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.pieGraphView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height);
}

@end
