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

#define PRIORITY_ZERO 0
#define PRIORITY_ONE  1
#define PRIORITY_TWO  2

@implementation PUPromptBox

@synthesize promptId, alphaValue, delegate, dataSource, isExpanded, mask;

+ (id)promptBoxWithPromptId:(NSInteger)aPromptId
{
    CGRect frame = CGRectMake(DEFAULT_LEFT_MARGIN, 0, DEFAULT_WIDTH, 0);
    PUPromptBox *box = [[[self class] alloc] initWithFrame:frame];
    box.promptId = aPromptId;
    return box;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        alphaValue = 1.0;
        isExpanded = NO;
        
        // Hook up a tap gesture recognizer
        UITapGestureRecognizer *singleFingerTap = 
        [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                action:@selector(handleTap)];
        [self addGestureRecognizer:singleFingerTap];
        
        // Hook up a swipe gesture recognizer
        UILongPressGestureRecognizer *longPress = 
        [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleLongPress)];
        [self addGestureRecognizer:longPress];
        
        mask = [[UIView alloc] initWithFrame:self.frame];
        [mask setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.78]];
    }
    return self;
}

- (void)handleTap
{
    PUPrompt *prompt = [self.dataSource promptWithId:self.promptId];

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
        
        NSString *blockImage = nil;
        switch (prompt.priority) {
            case PRIORITY_ZERO:
                blockImage = @"red";
                break;
            case PRIORITY_ONE:
                blockImage = @"orange";
                break;
            case PRIORITY_TWO:
                blockImage = @"green";
                break;
                
            default:
                break;
        }
        NSArray *left = [NSArray arrayWithObjects:[UIImage imageNamed:blockImage], prompt.header, nil];
        MGBoxLine *header = [MGBoxLine lineWithLeft:left right:@"24m"];
        header.rightFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        header.font = TITLE_FONT;
        [self.topLines addObject:header];
        [self.delegate promptBoxDidCompress:self];
    }
    self.isExpanded = !self.isExpanded;
}

- (void)handleLongPress
{
    PUPrompt *prompt = [self.dataSource promptWithId:self.promptId];

    if (!prompt.dissmissed) {
        //[self addSubview:mask];  
        self.newAlpha = 0.5;
        [self.delegate promptBoxDidDissmiss:self];
    } else {
        //[mask removeFromSuperview];
        self.newAlpha = 1.0;
        [self.delegate promptBoxDidUndissmiss:self];
    }

}

- (void)setDataSource:(id<PUPromptBoxDataSource>)aDataSource {
    dataSource = aDataSource;
    PUPrompt *prompt = [self.dataSource promptWithId:self.promptId];
    NSString *blockImage = nil;
    switch (prompt.priority) {
        case PRIORITY_ZERO:
            blockImage = @"red";
            break;
        case PRIORITY_ONE:
            blockImage = @"orange";
            break;
        case PRIORITY_TWO:
            blockImage = @"green";
            break;
            
        default:
            break;
    }

    NSArray *left = [NSArray arrayWithObjects:[UIImage imageNamed:blockImage], prompt.header, nil];
    MGBoxLine *header = [MGBoxLine lineWithLeft:left right:@"24m"];
    header.rightFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    header.font = TITLE_FONT;
    [self.topLines addObject:header];
    
}

@end
