//
//  UILabelStrikethrough.m
//  Promptu
//
//  Created by Brandon Millman on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UILabelStrikethrough.h"


@implementation UILabelStrikethrough
@synthesize xOffset, yOffset, widthOffset, stroke;
@synthesize strokeColor;

-(void) dealloc {
    [super dealloc];
    [strokeColor release];
}

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.xOffset = 0;
        self.yOffset = 4;
        self.widthOffset = 0;
        self.stroke = 2;
        self.strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame xOffset:(int)_xOffset yOffset:(int)_yOffset widthOffset:(int)_widthOffset stroke:(int)_stroke strokeColor:(UIColor*)_strokeColor {
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width+_widthOffset-_xOffset, frame.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        self.xOffset = _xOffset;
        self.yOffset = _yOffset;
        self.widthOffset = _widthOffset;
        self.stroke = _stroke;
        self.strokeColor = _strokeColor;
    }
    return self;    
}

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 0-self.xOffset, 0, 0+self.widthOffset};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (void)drawRect:(CGRect)rect {
    
    CGSize size = [self.text sizeWithFont:self.font constrainedToSize:self.frame.size lineBreakMode:self.lineBreakMode];
    CGContextRef c = UIGraphicsGetCurrentContext();
    const float* colors = CGColorGetComponents( self.strokeColor.CGColor );
    CGContextSetStrokeColor(c, colors);
    CGContextSetLineWidth(c, self.stroke);
    CGContextBeginPath(c);
    int halfWayUp = (size.height - self.bounds.origin.y) / 2 + self.yOffset;
    CGContextMoveToPoint(c, self.bounds.origin.x + self.xOffset, halfWayUp );
    CGContextAddLineToPoint(c, self.bounds.origin.x + size.width + self.widthOffset - self.xOffset, halfWayUp);
    CGContextStrokePath(c);
    
    [super drawRect:rect];
}

@end
