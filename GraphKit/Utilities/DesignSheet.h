//
//  DesignSheet.h
//  GraphKit
//
//  Created by Sunil Rao on 26/04/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#ifndef DesignSheet_h
#define DesignSheet_h

#define SCREEN_ORIGIN_X                             [UIScreen mainScreen].bounds.origin.x
#define SCREEN_ORIGIN_Y                             [UIScreen mainScreen].bounds.origin.y
#define SCREEN_WIDTH                                [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT                               [UIScreen mainScreen].bounds.size.height

#define VIEW_BOUNDS_WIDTH        self.bounds.size.width
#define VIEW_BOUNDS_HEIGHT       self.bounds.size.height


#define LAYOUT_BORDER_THICKNESS 1

//ANIMATION
#define ANIMATION_DURATION_CIRCLE              5




// ************ LINE GRAPH ************** //

//COLORS
#define GRAPH_LINE_COLOR                [UIColor redColor]
#define GRAPH_LAYOUT_COLOR              [UIColor whiteColor]
#define GRAPH_LABEL_COLOR               [UIColor whiteColor]

//DIMENSIONS
#define GRAPH_LINE_WIDTH                2
#define GRAPH_LAYOUT_LINE_THICKNESS     1

//ANIMATION
#define ANIMATION_DURATION_GRAPH        3

//FONTS
#define GRAPH_LABEL_FONT_STYLE                @"Arial-BoldMT"
#define GRAPH_LABEL_FONT_SIZE                 9


#endif /* DesignSheet_h */
