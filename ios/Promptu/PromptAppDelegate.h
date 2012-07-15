//
//  PromptAppDelegate.h
//  Promptu
//
//  Created by Brandon Millman on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RevealController;

@interface PromptAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RevealController *viewController;

@end
