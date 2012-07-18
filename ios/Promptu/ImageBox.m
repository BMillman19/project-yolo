//
//  ImageBox.m
//  Promptu
//
//  Created by Brandon Millman on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageBox.h"

#import "MGBoxLine.h"
#import "UIColor+CreateMethods.h"

#define DEFAULT_WIDTH           54.0
#define DEFAULT_TOP_MARGIN      10.0
#define DEFAULT_LEFT_MARGIN    133.0
#define CORNER_RADIUS            4.0

@implementation ImageBox

+ (id)imageBoxWithImage:(UIImage *)anImage
{
    CGRect frame = CGRectMake(DEFAULT_LEFT_MARGIN, 0, DEFAULT_WIDTH, 0);
    return [[[self class] alloc] initWithFrame:(CGRect)frame withImage:(UIImage *)anImage];
}

+ (id)imageBoxWithImageName:(NSString *)aName
{
    return [[self class] imageBoxWithImage:[UIImage imageNamed:aName]];
}

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)anImage
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:@"#00ADEE" alpha:1.0];

        MGBoxLine *image = [MGBoxLine lineWithLeft:anImage right:nil];
        [self.topLines addObject:image];
    }
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
