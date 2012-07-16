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

#define DEFAULT_WIDTH          304.0
#define DEFAULT_TOP_MARGIN      10.0
#define DEFAULT_LEFT_MARGIN      8.0
#define CORNER_RADIUS            4.0

@implementation PUPromptBox

@synthesize position, alphaValue, delegate, dataSource, isExpanded;

+ (id)promptBoxWithPosition:(int)aPosition
{
    CGRect frame = CGRectMake(DEFAULT_LEFT_MARGIN, 0, DEFAULT_WIDTH, 0);
    PUPromptBox *box = [[self alloc] initWithFrame:frame withPosition:aPosition];
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
        MGBoxLine *body = [MGBoxLine multilineWithText:prompt.body font:nil padding:24];
        [self.topLines addObject:body];
    } else {
        [self.topLines removeAllObjects];
        MGBoxLine *header = [MGBoxLine lineWithLeft:prompt.header right:nil];
        header.font = TITLE_FONT;
        [self.topLines addObject:header];
    }
    self.isExpanded = !self.isExpanded;
    [self.delegate promptBoxDidExpand:self];
}

- (void)handleSwipe
{
    PUPrompt *prompt = [self.dataSource promptAtPosition:self.position];

    if (!prompt.dissmissed) {
        self.alphaValue = 0.5;
        [self.delegate promptBoxDidDissmiss:self];
    } else {
        self.alphaValue = 1.0;
        [self.delegate promptBoxDidUndissmiss:self];
    }

}

- (void)setDataSource:(id<PUPromptBoxDataSource>)aDataSource {
    dataSource = aDataSource;
    PUPrompt *prompt = [self.dataSource promptAtPosition:self.position];
    MGBoxLine *header = [MGBoxLine lineWithLeft:prompt.header right:nil];
    header.font = TITLE_FONT;
    [self.topLines addObject:header];
    
}




//- (void)drawRect:(CGRect)rect
//{
//    self.alpha = alphaValue;
//    [super drawRect:rect];
//
//}



@end
