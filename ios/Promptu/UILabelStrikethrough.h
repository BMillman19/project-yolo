//
//  UILabelStrikethrough.h
//  Promptu
//
//  Created by Brandon Millman on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabelStrikethrough : UILabel {
    int xOffset;
    int yOffset;
    int widthOffset;
    int stroke;
    UIColor* strokeColor;
}
@property (nonatomic) int xOffset;
@property (nonatomic) int yOffset;
@property (nonatomic) int widthOffset;
@property (nonatomic) int stroke;
@property (nonatomic,retain) UIColor* strokeColor;

-(id) initWithFrame:(CGRect)frame xOffset:(int)_xOffset yOffset:(int)_yOffset widthOffset:(int)_widthOffset stroke:(int)_stroke strokeColor:(UIColor*)_strokeColor;
@end
