//
//  PromptViewController.h
//  Promptu
//
//  Created by Brandon Millman on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RefreshViewController.h"

#import <UIKit/UIKit.h>
#import "PUPromptBox.h"
#import "MGBoxProtocol.h"

@interface PromptViewController : RefreshViewController <PUPromptBoxDelegate, PUPromptBoxDataSource>

@property (nonatomic, retain) NSMutableArray *prompts;

@end
