//
//  PromptViewController.m
//  Promptu
//
//  Created by Brandon Millman on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PromptViewController.h"

#import "PrettyKit.h"
#import "MGScrollView.h"
#import "MGStyledBox.h"
#import "MGBoxLine.h"
#import "PromptCenter.h"
#import "PUPromptBox.h"
#import "PUPrompt.h"
#import "ImageBox.h"
#import "MGImageView.h"
#import "SearchBox.h"
#import "FilterBox.h"
#import "PrettyToolbar.h"
#import "Underscore.h"

@implementation PromptViewController

@synthesize prompts, promptIndex, promptBoxIndex, toolBar, title;

- (void)dealloc{
    [prompts release];
    [promptIndex release];
    [promptBoxIndex release];
    [toolBar release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//// This is the core method you should implement
- (void)reloadDataSource {
    [super reloadDataSource];
    // Here you would make an HTTP request or something like that
    // Call [self doneLoadingTableViewData] when you are done
    [self performSelector:@selector(doneLoadingData) withObject:nil afterDelay:3.0];
}

- (void)refreshView {
    [self.scroller.boxes removeAllObjects];
    for (PUPrompt *prompt in self.prompts) {
        [self.scroller.boxes addObject:[self.promptBoxIndex objectForKey:[NSNumber numberWithLong:prompt.uId]]];
    }
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
    [self.scroller flashScrollIndicators];
}

//#pragma mark - UIScrollViewDelegate (for snapping boxes to edges)
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    if (!_reloading) {
//        [(MGScrollView *)scrollView snapToNearestBox];
//    }
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
//                  willDecelerate:(BOOL)decelerate {
//    if (!decelerate && !_reloading) {
//        [(MGScrollView *)scrollView snapToNearestBox];
//    }
//}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [(PromptCenter *)[PromptCenter sharedInstance] fetchPrompts:234234 withCallback:
     ^(long userId, id result, NSError* error) {
         if(!error) {
             self.promptIndex = [[NSMutableDictionary alloc] initWithCapacity:1];
             self.promptBoxIndex = [[NSMutableDictionary alloc] initWithCapacity:1];
             self.prompts = result;
             [self refreshView];
         }
     }];
    
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)]) {
		UIPanGestureRecognizer *navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
        UIPanGestureRecognizer *viewPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
		[self.navigationController.navigationBar addGestureRecognizer:navigationBarPanGestureRecognizer];
        [self.view addGestureRecognizer:viewPanGestureRecognizer];
        [navigationBarPanGestureRecognizer release];
        [viewPanGestureRecognizer release];

		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
	}
    

    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:PU_PATTERN]];
    self.scroller.backgroundColor = [UIColor clearColor];
    self.scroller.alwaysBounceVertical = YES;
    
    self.toolBar.topLineColor = [UIColor colorWithHex:0x00ADEE];
    self.toolBar.gradientStartColor = [UIColor colorWithHex:0x00ADEE];
    self.toolBar.gradientEndColor = [UIColor colorWithHex:0x0078A5];
    self.toolBar.bottomLineColor = [UIColor colorWithHex:0x0078A5];
    self.toolBar.tintColor = self.toolBar.gradientEndColor;
}

- (void)viewDidUnload {
    [super viewDidUnload]; // Always call superclass methods first, since you are using inheritance
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - PUPromptBoxDelegate 

- (void)promptBoxDidExpand:(PUPromptBox *)promptBox {
    [self.scroller drawBoxesWithSpeed:0.0];
}

- (void)promptBoxDidCompress:(PUPromptBox *)promptBox {
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
}

- (void)promptBoxDidDissmiss:(PUPromptBox *)promptBox {
    ((PUPrompt *)[self.promptIndex objectForKey:[NSNumber numberWithLong:promptBox.promptId]]).dissmissed = YES;
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
}

- (void)promptBoxDidUndissmiss:(PUPromptBox *)promptBox {
    ((PUPrompt *)[self.promptIndex objectForKey:[NSNumber numberWithLong:promptBox.promptId]]).dissmissed = NO;
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
}

- (void)promptBoxShowDetailed:(PUPromptBox *)promptBox {
    
}

#pragma mark - PUPromptBoxDataSource

- (PUPrompt *)promptWithId:(NSInteger)promptId {
    return [self.promptIndex objectForKey:[NSNumber numberWithLong:promptId]];
}

#pragma mark - IBActions
- (IBAction)shufflePrompts:(id)sender {
    self.prompts = _array(self.prompts).shuffle.unwrap;
    [self refreshView];
}

- (IBAction)newPrompt:(id)sender {
    
}
- (IBAction)sortPrompts:(id)sender {
    
}

#pragma mark - Custom accessors

- (void)setPrompts:(NSArray *)newPrompts {
    [newPrompts retain];
    [prompts release];
    prompts = newPrompts;
    for (PUPrompt *prompt in self.prompts) {
        [self.promptIndex setObject:prompt forKey:[NSNumber numberWithInt:prompt.uId]];
        if (![self.promptBoxIndex objectForKey:[NSNumber numberWithInt:prompt.uId]]) {
            PUPromptBox *box = [PUPromptBox promptBoxWithPromptId:prompt.uId];
            box.delegate = self;
            box.dataSource = self;
            [self.promptBoxIndex setObject:box forKey:[NSNumber numberWithInt:prompt.uId]];
        }
    }
}

- (void)setTitle:(NSString *)aTitle {
    self.navigationItem.title = aTitle;
}






@end
