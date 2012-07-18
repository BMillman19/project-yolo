//
//  PUPromptBox.m
//  Promptu
//
//  Created by Brandon Millman on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PUPromptBox.h"

#import "MGBoxLine.h"
#import "PUPrompt.h"
#import "TextBadge.h"
#import "BlueBadge.h"
#import "BadgeLabel.h"

#define DEFAULT_WIDTH          304.0
#define DEFAULT_TOP_MARGIN      10.0
#define DEFAULT_LEFT_MARGIN      8.0
#define CORNER_RADIUS            4.0

@implementation PUPromptBox

@synthesize position, alphaValue, delegate, dataSource, isExpanded;

+ (id)promptBoxWithPosition:(int)aPosition
{
    CGRect frame = CGRectMake(DEFAULT_LEFT_MARGIN, 0, DEFAULT_WIDTH, 0);
    PUPromptBox *box = [[[self class] alloc] initWithFrame:frame withPosition:aPosition];
    return box;
}

- (id)initWithFrame:(CGRect)frame withPosition:(int)aPosition
{
    self = [super initWithFrame:frame];
    if (self) {
        position = aPosition;
        alphaValue = 1.0;
        isExpanded = NO;
        
        // Hook up a tap gesture recognizer
        UITapGestureRecognizer *singleFingerTap = 
        [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                action:@selector(handleTap)];
        [self addGestureRecognizer:singleFingerTap];
        
        // Hook up a swipe gesture recognizer
        UISwipeGestureRecognizer *swipeRight = 
        [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSwipe)];
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [self addGestureRecognizer:swipeRight];
    }
    return self;
}

- (void)handleTap
{
    PUPrompt *prompt = [self.dataSource promptAtPosition:self.position];

    if (!isExpanded) {
        MGBoxLine *body = [MGBoxLine multilineWithText:prompt.body font:nil padding:12];
        [self.topLines addObject:body];
        
        NSMutableArray *tagBadges = [[NSMutableArray alloc] init];
        
        for(NSString * tag in prompt.tags) {
            BadgeLabel *badge = [[BadgeLabel alloc] initWithFrame:CGRectZero];
            [badge setStyle:BadgeLabelStyleAppIcon];
            [badge setText:tag];
            [tagBadges addObject:badge];
        }

        MGBoxLine *footer = [MGBoxLine lineWithLeft:tagBadges right:nil];
        [self.topLines addObject:footer];
        
        [self.delegate promptBoxDidExpand:self];
    } else {
        [self.topLines removeAllObjects];
        NSArray *left = [NSArray arrayWithObjects:[UIImage imageNamed:@"p0"], prompt.header, nil];
        MGBoxLine *header = [MGBoxLine lineWithLeft:left right:@"24m"];
        header.rightFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        header.font = TITLE_FONT;
        [self.topLines addObject:header];
        [self.delegate promptBoxDidCompress:self];
    }
    self.isExpanded = !self.isExpanded;
}

- (void)handleSwipe
{
    PUPrompt *prompt = [self.dataSource promptAtPosition:self.position];

    if (!prompt.dissmissed) {
        //[self setBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:0.5]];        
        [self.delegate promptBoxDidDissmiss:self];
    } else {
        //[self setBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:1.0]];        
        [self.delegate promptBoxDidUndissmiss:self];
    }

}

- (void)setDataSource:(id<PUPromptBoxDataSource>)aDataSource {
    dataSource = aDataSource;
    PUPrompt *prompt = [self.dataSource promptAtPosition:self.position];
    NSArray *left = [NSArray arrayWithObjects:[UIImage imageNamed:@"p0"], prompt.header, nil];
    MGBoxLine *header = [MGBoxLine lineWithLeft:left right:@"24m"];
    header.rightFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    header.font = TITLE_FONT;
    [self.topLines addObject:header];
    
}




//- (void)drawRect:(CGRect)rect
//{
//    self.layer.
//}



@end
