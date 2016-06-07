//
//  PieSlice.m
//  GraphKit
//
//  Created by Sunil Rao on 02/06/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import "PieSlice.h"

@implementation PieSlice

-(instancetype)initWithPercentage:(float)percentage addTitle:(NSString *)title addDescription:(NSString *)descrip andColor:(UIColor *)color
{
    self = [super init];
    if (self)
    {
        self.slicePercentage = percentage;
        self.sliceTitle = title;
        self.sliceDescrip = descrip;
        self.sliceColor = color;
    }
    
    return self;
}
@end
