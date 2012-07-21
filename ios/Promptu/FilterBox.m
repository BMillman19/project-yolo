//
//  FilterBox.m
//  Promptu
//
//  Created by Brandon Millman on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FilterBox.h"
#import "SEFilterControl.h"
#import "MGBoxLine.h"

#define DEFAULT_WIDTH          304.0
#define DEFAULT_TOP_MARGIN      10.0
#define DEFAULT_LEFT_MARGIN      8.0
#define CORNER_RADIUS            4.0

@implementation FilterBox

+ (id)filterBox 
{
    CGRect frame = CGRectMake(DEFAULT_LEFT_MARGIN, 0, DEFAULT_WIDTH, 0);
    return [[[self class] alloc] initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //-(id) initWithFrame:(CGRect) frame Titles:(NSArray *) titles
        NSArray *tiles = [NSArray arrayWithObjects:@"Lolol", @"hello", @"world", nil];
        SEFilterControl *filter = [[SEFilterControl alloc] initWithFrame:CGRectZero Titles:tiles];
        
        MGBoxLine *image = [MGBoxLine lineWithLeft:nil right:filter];
        [self.topLines addObject:image];    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
