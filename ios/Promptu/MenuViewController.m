//
//  MenuViewController.m
//  Promptu
//
//  Created by Brandon Millman on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

#import "PromptViewController.h"
#import "PromptCenter.h"
#import "Underscore.h"


@implementation MenuViewController

@synthesize promptViewController;

- (void)dealloc {
    [promptViewController release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (IBAction)shuffle:(id)sender {
    [(PromptCenter *)[PromptCenter sharedInstance] fetchPrompts:234234 withCallback: ^(long userId, id result, NSError* error) {
            if(!error) {
                self.promptViewController.prompts = _array(result).shuffle.unwrap;
                self.promptViewController.title = @"Shuffle";
                [self.promptViewController refreshView];
                [[NSNotificationCenter defaultCenter] postNotificationName:MENU_ITEM_SELECTED object:nil];
         }
     }];
}

//- (IBAction)shuffle:(id)sender {
//    [(PromptCenter *)[PromptCenter sharedInstance] fetchPrompts:234234 withCallback: ^(long userId, id result, NSError* error) {
//        if(!error) {
//            self.promptViewController.prompts = _array(result).filter(^BOOL (id obj) {
//                return [obj isKindOfClass:[NSDictionary class]];
//            }).unwrap;
//            [self.promptViewController refreshView];
//        }
//    }];
//}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.promptViewController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
