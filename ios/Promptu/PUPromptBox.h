//
//  PUPromptBox.h
//  Promptu
//
//  Created by Brandon Millman on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGStyledBox.h"

@class PUPrompt;

@protocol PUPromptBoxDelegate, PUPromptBoxDataSource;

@interface PUPromptBox : MGStyledBox

@property(nonatomic, assign) int position;
@property(nonatomic, assign) CGFloat alphaValue;
@property(nonatomic, assign) id<PUPromptBoxDelegate> delegate;
@property(nonatomic, assign) id<PUPromptBoxDataSource> dataSource;
@property(nonatomic, assign) bool isExpanded;

+ (id)promptBoxWithPosition:(int)aPosition;

@end

@protocol PUPromptBoxDelegate <NSObject>

@required
- (void)promptBoxDidExpand:(PUPromptBox *)promptBox;
- (void)promptBoxDidDissmiss:(PUPromptBox *)promptBox;
- (void)promptBoxDidUndissmiss:(PUPromptBox *)promptBox;


@end

@protocol PUPromptBoxDataSource <NSObject>

@required
- (PUPrompt *)promptAtPosition:(int)position;

@end
