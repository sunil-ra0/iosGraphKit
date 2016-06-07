//
//  CommonHeaders.h
//  GraphKit
//
//  Created by Sunil Rao on 18/05/16.
//  Copyright © 2016 Sunil Rao. All rights reserved.
//

#ifndef CommonHeaders_h
#define CommonHeaders_h

//****** line graph and bar graph margin & layout macros

#define TOTAL_X_DIST        VIEW_BOUNDS_WIDTH * 0.85
#define TOTAL_Y_DIST        VIEW_BOUNDS_HEIGHT * 0.80
#define STARTING_X          VIEW_BOUNDS_WIDTH * 0.10
#define ENDING_X            VIEW_BOUNDS_WIDTH * 0.95
#define STARTING_Y          VIEW_BOUNDS_HEIGHT * 0.85
#define ENDING_Y            VIEW_BOUNDS_HEIGHT * 0.05

#define ANIMATION_DURATION              1

//****** Key paths for animations *******//
#define STROKE_END_KEY_PATH                     @"strokeEnd"
#define DRAW_CIRCLE_ANIM_KEY_PATH               @"drawCircleAnimation"

#endif /* CommonHeaders_h */
