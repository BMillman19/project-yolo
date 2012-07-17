//
//  PromptViewController.h
//  Promptu
//
//  Created by Brandon Millman on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshViewController.h"
#import "PUPromptBox.h"

@interface PromptViewController : RefreshViewController <PUPromptBoxDelegate, PUPromptBoxDataSource>

@property (nonatomic, retain) NSMutableArray *prompts;

@end
