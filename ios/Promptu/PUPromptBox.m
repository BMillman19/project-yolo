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
#import "BadgeLabel.h"
#import "UILabelStrikethrough.h"

#define DEFAULT_WIDTH          304.0
#define DEFAULT_TOP_MARGIN      10.0
#define DEFAULT_LEFT_MARGIN      8.0
#define CORNER_RADIUS            4.0

#define PRIORITY_ZERO 0
#define PRIORITY_ONE  1
#define PRIORITY_TWO  2

#define STATE_CLOSED 0
#define STATE_OPENED 1
#define STATE_EXPANDED 2

@implementation PUPromptBox

@synthesize promptId, delegate, dataSource, expandState;

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
        expandState = STATE_CLOSED;
        
        // Hook up a tap gesture recognizer
        UITapGestureRecognizer *singleFingerTap = 
        [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                action:@selector(handleTap:)];
        [self addGestureRecognizer:singleFingerTap];
        
        // Hook up a swipe gesture recognizer
        UILongPressGestureRecognizer *longPress = 
        [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handleLongPress:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:sender.view];
    NSLog(@"%@", NSStringFromCGPoint(point));
    PUPrompt *prompt = [self.dataSource promptWithId:self.promptId];
    
    if (self.expandState == STATE_CLOSED) {
        
        MGBoxLine *body = [MGBoxLine multilineWithText:prompt.body font:nil padding:12];
        [self.topLines addObject:body];
        
        NSMutableArray *tagBadges = [[NSMutableArray alloc] init];
                    
        for(NSString * tag in prompt.tags) {
            BadgeLabel *badge = [[BadgeLabel alloc] initWithFrame:CGRectZero];
            [badge setStyle:BadgeLabelStyleAppIcon];
            [badge setText:tag];
            [tagBadges addObject:badge];
        }
                    
                    
        UIButton *pinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [pinButton setImage:[UIImage imageNamed:@"icon-pushpin-black"] forState:UIControlStateNormal];
        pinButton.frame = CGRectMake(0, 0, 20, 20);
                    
        NSArray *buttons = [NSArray arrayWithObjects:[UIImage imageNamed:@"orange"], pinButton, nil];
                    
                    
        MGBoxLine *footer = [MGBoxLine lineWithLeft:tagBadges right:buttons];
        [self.topLines addObject:footer];
        self.expandState = STATE_OPENED;
        [self.delegate promptBoxDidExpand:self];
                            
    } else if (self.expandState == STATE_OPENED) {
        if(point.x > 270 && point.x < 310 && point.y < 130 && point.y > 70){            
            [self.delegate promptBoxShowDetailed:self];
        } else {
            MGBoxLine *first = [self.topLines objectAtIndex:0];
            [self.topLines removeAllObjects];
            [self.topLines addObject:first];
            self.expandState = STATE_CLOSED;
            [self.delegate promptBoxDidCompress:self];
        }
    } 
 
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        PUPrompt *prompt = [self.dataSource promptWithId:self.promptId];
        
        if (!prompt.dissmissed) {
            self.newAlpha = 0.5;
//            ((UILabelStrikethrough *)[[self.topLines objectAtIndex:0] objectAtIndex:1]).strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
            [self.delegate promptBoxDidDissmiss:self];
        } else {
            self.newAlpha = 1.0;
//            ((UILabelStrikethrough *)[[self.topLines objectAtIndex:0] objectAtIndex:1]).strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            [self.delegate promptBoxDidUndissmiss:self];
        }
    }
    
}

-(void)superExpand:(id)sender {
    PUPrompt *prompt = [self.dataSource promptWithId:self.promptId];
    MGBoxLine *body = [MGBoxLine multilineWithText:prompt.body font:nil padding:12];
    [self.topLines addObject:body];
    [self.delegate promptBoxDidExpand:self];

}

- (void)setDataSource:(id<PUPromptBoxDataSource>)aDataSource {
    dataSource = aDataSource;    

    PUPrompt *prompt = [self.dataSource promptWithId:self.promptId];
    NSString *blockImage = nil;
    if (!prompt.dissmissed) {
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
    } else {
        blockImage = @"grey";
    }
    
    UILabelStrikethrough *headerLabel = [[UILabelStrikethrough alloc] initWithFrame:CGRectMake(0, 0, 100, 26)];

    
   // UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.text = prompt.header;
    headerLabel.font = TITLE_FONT;
    CGSize size = [headerLabel.text sizeWithFont:headerLabel.font];
    headerLabel.frame = CGRectMake(0, 0, size.width, 26);
    headerLabel.backgroundColor = [UIColor clearColor];
    
    NSArray *left = [NSArray arrayWithObjects:[UIImage imageNamed:blockImage], headerLabel, nil];
    
    MGBoxLine *header = [MGBoxLine lineWithLeft:left right:@"24m"];
    header.rightFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    //header.font = TITLE_FONT;
    [self.topLines addObject:header];
}

@end
