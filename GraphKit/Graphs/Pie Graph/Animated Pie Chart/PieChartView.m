//
//  PieChartView.m
//  GraphKit
//
//  Created by Sunil Rao on 02/06/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#import "PieChartView.h"
#import "PieSlice.h"
#import "PieChart.h"

#define ROTATING_ANI_FRAME                  20
#define SEPERATING_ANI_FRAME                15
#define JOINING_ANI_FRAME                   15

#define SELECTED_SLICE_RADIUS               60
#define SELECTED_SLICE_Y_POS                20
#define LOWER_PIE_Y_POS                     40

typedef enum
{
    STATE_IDEL,
    STATE_ROTATING,
    STATE_SEPARATING,
    STATE_SEPARATED,
    STATE_JOINING
}state;

@implementation PieChartView
{
    float xPos, yPos, radius, selectionRadius, selectedYPos, pieLoweredYPos;
    float rotationAngle, startAngle, destAngle;
    float totalAniFrames, currentFrame;
    
    state animationState;
    BOOL isAnimating;
    
    PieChart *pieChart;
    PieSlice *nextSelectedSlice, *selectedSlice;
    NSArray *dataArray;
}
- (instancetype)initWithFrame:(CGRect)frame andPieChartData:(NSArray *)pieChartData;
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.frame = frame;
        
        //Creating Pie chart object
        pieChart = [[PieChart alloc] initWithData:pieChartData withTitle:@"Statics"];
        dataArray = pieChartData;
        
        //Initializations
        radius = self.frame.size.width/3;
        xPos = self.frame.size.width/2;
        yPos = self.frame.size.height - radius - LOWER_PIE_Y_POS;
        startAngle = rotationAngle = destAngle = 0;
        nextSelectedSlice = nil;
        
        [self setState:STATE_IDEL];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //Getting the present context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Drawing pie chart
    [self drawPieChart:context];
}

#pragma mark - drawing methods
/// Method to draw pie chart
- (void)drawPieChart:(CGContextRef)context
{
    //Clear the screen
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    
    //draw all slices
    float a = rotationAngle;
    
    for (PieSlice *slice in pieChart.pieSlicesArray)
    {
        [self drawPieSlice:slice withStartingAngle:a withContext:context];
        a += (slice.slicePercentage/100) * (M_PI * 2);
    }
    
}

///Method to draw pie slices
- (void)drawPieSlice:(PieSlice *)slice withStartingAngle:(float)startingAngle withContext:(CGContextRef)context
{
    //Initializing drawing parameters.
    float endAngle = startingAngle + (slice.slicePercentage/100) * (M_PI * 2);
    float adjY = yPos;
    float rad = radius;
    
    if (slice == selectedSlice && animationState != STATE_ROTATING)
    {
        adjY = selectedYPos;
        rad = selectionRadius;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowOpacity = 0.75;
        self.layer.shadowRadius = rad/32;
    }
    
    else if (selectedSlice != nil && animationState != STATE_ROTATING)
        adjY = pieLoweredYPos;
    
    //removing the shadow when pie slice is not seperated
    else
        self.layer.shadowOpacity = 0;
    
    //Setting up the drawing environment
    CGContextSetFillColorWithColor(context, slice.sliceColor.CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xPos, adjY);
    CGContextAddArc(context, xPos, adjY, rad, startingAngle, endAngle, 0);
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathEOFillStroke);
    
    //Adding percentage and animation to the slices
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    float fontSize = 0.10 * rad;
    CGContextSelectFont(context, "Helvetica", fontSize, kCGEncodingMacRoman);
    CGContextSetTextMatrix(context, CGAffineTransformMake(1, 0, 0, -1, 0, 0));
    CGContextSetTextDrawingMode(context, kCGTextFill);
    char s[100];
    
    sprintf(s, "%d%%", (int)slice.slicePercentage);
    
    float r = rad - 36;
    float tx = xPos + sinf(M_PI/2 + startingAngle + (endAngle - startingAngle)/2.0) * r - 20;
    float ty = adjY + cosf(M_PI/2 + startingAngle + (endAngle - startingAngle)/2.0) * -r + 10;
    CGContextShowTextAtPoint(context, tx, ty, s, strlen(s));
}

#pragma  mark - animation methods

- (void)setState:(state)newState
{
    animationState = newState;
    
    switch (newState)
    {
        case STATE_IDEL:
            isAnimating = NO;
            break;
            
        case STATE_ROTATING:
            isAnimating =YES;
            totalAniFrames = ROTATING_ANI_FRAME;
            currentFrame = 1;
            break;
            
        case STATE_SEPARATING:
            isAnimating = YES;
            startAngle = rotationAngle = destAngle;
            totalAniFrames = SEPERATING_ANI_FRAME;
            currentFrame = 1;
            pieLoweredYPos = yPos;
            selectionRadius = radius;
            break;
            
        case STATE_SEPARATED:
            isAnimating = NO;
            break;
            
        case STATE_JOINING:
            isAnimating = YES;
            totalAniFrames = JOINING_ANI_FRAME;
            currentFrame = 1;
            break;
            
        default:
            break;
    }
}

- (void)tick
{
    switch (animationState)
    {
        case STATE_ROTATING:
            if (currentFrame > totalAniFrames)
            {
                [self setState:STATE_SEPARATING];
            }
            else
            {
                
            // NOTE : t-current time; b- beginning time; c-change in value; d-duration

                rotationAngle = easeInOutBack(currentFrame ++, startAngle, (destAngle - startAngle), totalAniFrames);
            }
            
            break;
            
        case STATE_SEPARATING:
            if (currentFrame > totalAniFrames)
                [self setState:STATE_SEPARATED];
            
            else
            {
                selectedYPos = easeOutBounce(currentFrame, yPos, -SELECTED_SLICE_Y_POS, totalAniFrames);
                pieLoweredYPos = easeOutBounce(currentFrame, yPos, LOWER_PIE_Y_POS, totalAniFrames);
                selectionRadius = easeOutBounce(currentFrame, radius, SELECTED_SLICE_RADIUS, totalAniFrames);
                currentFrame ++;
            }
            break;
            
        case STATE_SEPARATED:
            isAnimating = NO;
            break;
            
        case STATE_JOINING:
            if (currentFrame > totalAniFrames)
            {
                selectedSlice = nextSelectedSlice;
                
                if (selectedSlice == nil)
                    [self setState:STATE_IDEL];
                
                else
                    [self setState:STATE_ROTATING];
            }
            
            else
            {
                selectedYPos = easeOutBounce(currentFrame, yPos - SELECTED_SLICE_Y_POS, SELECTED_SLICE_Y_POS, totalAniFrames);
                pieLoweredYPos = easeOutBounce(currentFrame, yPos +LOWER_PIE_Y_POS, -LOWER_PIE_Y_POS, totalAniFrames);
                selectionRadius = easeOutBounce(currentFrame, radius + SELECTED_SLICE_RADIUS, -SELECTED_SLICE_RADIUS, totalAniFrames);
                currentFrame ++;
            }
            break;
            
        default:
            break;
    }

}

#pragma mark - Animation Easing functions
/*
 NOTE : t-current time; b- beginning time; c-change in value; d-duration
*/

float easeInOutBack(float t,float b,float c,float d)
{
    float s =1.70158;
    if ((t/=d/2)<1)
        return c/2*(t*t*(((s *=(1.525))+1)*t - s)) + b;
    
    return c/2*((t-=2)*t*(((s*=(1.525))+1)*t+s)+2)+b;
}

float easeOutBounce(float t,float b,float c,float d)
{
    if ((t/=d)<(1/2.75))
        return c*(7.5625*t*t)+b;
    
    else if (t<(2/2.75))
        return c*(7.5625*(t-=(1.5/2.75))*t + 0.75) + b;
    
    else if (t < (2.5/2.75))
        return c*(7.5625*(t-=(2.25/2.75))*t + 0.9375) + b;
    
    return  c*(7.5625*(t-=(2.626/2.75))*t + 0.984375) + b;
}

float BounceEaseOut(float p)
{
    if(p < 4/11.0)
    {
        return (121 * p * p)/16.0;
    }
    else if(p < 8/11.0)
    {
        return (363/40.0 * p * p) - (99/10.0 * p) + 17/5.0;
    }
    else if(p < 9/10.0)
    {
        return (4356/361.0 * p * p) - (35442/1805.0 * p) + 16061/1805.0;
    }
    else
    {
        return (54/5.0 * p * p) - (513/25.0 * p) + 268/25.0;
    }
}

#pragma mark - touch actions
- (void)touchedPoint:(CGPoint)touchPoint
{
    if (isAnimating)
        return;
    
    float a = [self getAngleFromPoint:touchPoint];
    
    if (a != 0)
    {
        //Normalizing selected angle
        if (a < 0)
            a += M_PI * 2;
        
        //Determing which slice is touched
        float first = startAngle;
        float last = 0.0;
        
        PieSlice *slice;
        for (slice in pieChart.pieSlicesArray)
        {
            last = first + (slice.slicePercentage/100.0) * (M_PI * 2);
            
            if (last > M_PI*2)
            {
                if (a > first || a < last - (M_PI*2))
                    break;          //found the slice
            }
            
            else if((a >= first) && (a <= last))
                break;              //found the slice
            
            first = last;
            
            //Normalizing first angle
            if (first > (M_PI * 2))
                first -= M_PI*2;
        }
        
        //Center the tapped slice upwards
        float targetAngle = 1.5*M_PI - (last - first)/2.0;
        
        destAngle += (targetAngle - first);
        
        //Normalizing destination angle
        if (destAngle < 0)
            destAngle += M_PI*2;
        
        nextSelectedSlice = slice;
        selectedYPos = yPos;
        
        selectedSlice = nextSelectedSlice;
        [self setState:STATE_ROTATING];
    }
    
    else
    {
        nextSelectedSlice = nil;
        [self setState:STATE_JOINING];
    }
}

- (float)getAngleFromPoint:(CGPoint)touchPoint
{
    float adjY = yPos;
    if (selectedSlice != nil)
    {
        adjY = pieLoweredYPos;
    }
    
    float deltaY = touchPoint.y - yPos;
    float deltaX = touchPoint.x - xPos;
    
    float distance = sqrt((deltaX*deltaX) + (deltaY*deltaY));
    
    if (distance <= radius)
        return atan2(deltaY, deltaX);
    else
        return 0;
}
@end