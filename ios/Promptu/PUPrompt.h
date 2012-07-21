//
//  PUPrompt.h
//  Promptu
//
//  Created by Brandon Millman on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUPrompt : NSObject

@property (nonatomic, assign) NSInteger uId;
@property (nonatomic, assign) NSInteger authorId;
@property (nonatomic, assign) NSInteger groupId;
@property (nonatomic, retain) NSString* header;
@property (nonatomic, retain) NSString* body;
@property (nonatomic, assign) int priority;
@property (nonatomic, retain) NSArray* tags;
@property (nonatomic, retain) NSDate* sendDate;
@property (nonatomic, retain) NSDate* dueDate;
@property (nonatomic, assign) bool dissmissed;

@end
