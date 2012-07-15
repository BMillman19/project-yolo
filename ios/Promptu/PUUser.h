//
//  PUUser.h
//  Promptu
//
//  Created by Brandon Millman on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUUser : NSObject

@property (nonatomic, assign) long userId;
@property (nonatomic, retain) NSString* firstName;
@property (nonatomic, retain) NSString* lastName;
@property (nonatomic, retain) NSString* email;
@property (nonatomic, retain) NSString* imageURL;

@end
