//
//  PromptCenter.m
//  Promptu
//
//  Created by Brandon Millman on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PromptCenter.h"

#import "PUPrompt.h"

@implementation PromptCenter

- (void) fetchPrompts: (long)userId withCallback: (void(^)(long userId, id result, NSError* error))callback
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:1];
    
    PUPrompt *a = [[PUPrompt alloc] init];
    a.uId = 3423432;
    a.authorId = 2342342;
    a.groupId = 23434;
    a.header = @"AYO Bitch";
    a.body = @"Smoke weed everyday sdfsdfsad asdfasdf gjktyujr dsdfsfsdaf dfsadfsadfasdfas dfsadfasd";
    a.priority = 0;
    a.tags = [[NSArray alloc] initWithObjects:@"yee", @"yolo", @"rawdog", nil];
    a.sendDate = [NSDate dateWithTimeIntervalSince1970:1308031456];
    a.dueDate = [NSDate dateWithTimeIntervalSince1970:1309000000];
    a.dissmissed = NO;
    
    [result addObject:a];
    [a release];
    
    PUPrompt *b = [[PUPrompt alloc] init];
    b.uId = 3423432;
    b.authorId = 2342342;
    b.groupId = 23434;
    b.header = @"Hella yolo";
    b.body = @"you only live once, that's the mofo dsfasdfsdaf qewrwqe gtyjyu rffewrfwerfer";
    b.priority = 2;
    b.tags = [[NSArray alloc] initWithObjects:@"blah", @"penis", @"dho", nil];
    b.sendDate = [NSDate dateWithTimeIntervalSince1970:1309000000];
    b.dueDate = [NSDate dateWithTimeIntervalSince1970:23423423432];
    b.dissmissed = NO;
    
    [result addObject:b];
    [b release];
    
    callback(42342342, result, nil);
}


@end
