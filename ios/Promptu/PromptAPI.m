//
//  PromptAPI.m
//  Promptu
//
//  Created by Brandon Millman on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PromptAPI.h"
#import "AFNetworking.h"

#define kHost @"http://localhost:3000"
#define kPath @"iReporter/"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation PromptAPI

@synthesize sessionDelegate;

-(PromptAPI*)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:kHost]];
    
    if (self != nil) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    
    return self;
}

//-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock
//{
//    NSMutableURLRequest *apiRequest = 
//    [self multipartFormRequestWithMethod:@"POST" 
//                                    path:kAPIPath 
//                              parameters:params 
//               constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
//                   //TODO: attach file if needed
//               }];
//    
//    AFJSONRequestOperation* operation = [[AFJSONRequestOperation alloc] initWithRequest: apiRequest];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        completionBlock(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
//    }];
//    
//    [operation start];
//}

@end
