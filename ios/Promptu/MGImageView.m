//
//  MGImageView.m
//  Promptu
//
//  Created by Brandon Millman on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGImageView.h"

#define DEFAULT_WIDTH          304.0
#define DEFAULT_TOP_MARGIN      10.0
#define DEFAULT_LEFT_MARGIN      8.0
#define CORNER_RADIUS            4.0

@implementation MGImageView

@synthesize bottomMargin, topMargin, isReplacement, width;

+ (id) imageView {
    CGRect frame = CGRectMake(DEFAULT_LEFT_MARGIN, 0, DEFAULT_WIDTH, 0);
    MGImageView *view = [[self alloc] initWithFrame:frame];
    return view;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizesSubviews = YES;
        self.topMargin = DEFAULT_TOP_MARGIN;
        self.bottomMargin = 0;
    }
    return self;
}

- (void)draw
{
    [self setNeedsDisplay]; 
}
@end
