//
//  PUPrompt.h
//  Promptu
//
//  Created by Brandon Millman on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUPrompt : NSObject

@property (nonatomic, assign) long uId;
@property (nonatomic, assign) long authorId;
@property (nonatomic, assign) long groupId;
@property (nonatomic, retain) NSString* header;
@property (nonatomic, retain) NSString* body;
@property (nonatomic, assign) int priority;
@property (nonatomic, retain) NSArray* tags;
@property (nonatomic, retain) NSDate* sendDate;
@property (nonatomic, retain) NSDate* dueDate;
@property (nonatomic, assign) bool dissmissed;

@end
