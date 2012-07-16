//
//  PUPrompt.m
//  Promptu
//
//  Created by Brandon Millman on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PUPrompt.h"

@implementation PUPrompt

@synthesize uId, authorId, groupId, header, body, priority, tags, sendDate, dueDate, dissmissed;

- (void)dealloc
{
    [header release];
    [body release];
    [tags release];
    [sendDate release];
    [dueDate release];
    [super dealloc];
}

@end
