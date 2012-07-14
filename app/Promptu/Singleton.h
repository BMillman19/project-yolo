//
//  Singleton.h
//  Promptu
//
//  Created by Brandon Millman on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Singleton : NSObject

+ (Singleton*)sharedInstance;

@end
