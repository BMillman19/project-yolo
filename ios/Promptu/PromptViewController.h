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
@class PrettyToolbar;

@interface PromptViewController : RefreshViewController <PUPromptBoxDelegate, PUPromptBoxDataSource>

@property (nonatomic, retain) NSArray *prompts;
@property (nonatomic, retain) NSMutableDictionary *promptIndex;
@property (nonatomic, retain) NSMutableDictionary *promptBoxIndex;
@property (nonatomic, retain) IBOutlet PrettyToolbar *toolBar;
@property (nonatomic, copy) NSString *title;

- (void)refreshView;
- (IBAction)shufflePrompts:(id)sender;
- (IBAction)newPrompt:(id)sender;
- (IBAction)sortPrompts:(id)sender;


@end
