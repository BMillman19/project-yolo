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

@implementation PromptViewController

@synthesize prompts;

- (void)dealloc{
    [prompts release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [(PromptCenter *)[PromptCenter sharedInstance] fetchPrompts:234234 withCallback:
            ^(long userId, id result, NSError* error) {
                if(!error) {
                    prompts = result;
                }
            }];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//// This is the core method you should implement
- (void)reloadDataSource {
    [super reloadDataSource];
    // Here you would make an HTTP request or something like that
    // Call [self doneLoadingTableViewData] when you are done
    [self performSelector:@selector(doneLoadingData) withObject:nil afterDelay:3.0];
}

- (void)addBox:(UIButton *)sender {
    MGStyledBox *box = [MGStyledBox box];
    MGBox *parentBox = [self parentBoxOf:sender];
    if (parentBox) {
        int i = [self.scroller.boxes indexOfObject:parentBox];
        [self.scroller.boxes insertObject:box atIndex:i + 1];
    } else {
        [self.scroller.boxes addObject:box];
    }
    
    UIButton *up = [self button:@"up" for:@selector(moveUp:)];
    UIButton *down = [self button:@"down" for:@selector(moveDown:)];
    UIButton *add = [self button:@"add" for:@selector(addBox:)];
    UIButton *remove = [self button:@"remove" for:@selector(removeBox:)];
    UIButton *shuffle = [self button:@"shuffle" for:@selector(shuffle)];
    
    NSArray *left = [NSArray arrayWithObjects:up, down, nil];
    NSArray *right = [NSArray arrayWithObjects:shuffle, remove, add, nil];
    
    MGBoxLine *line = [MGBoxLine lineWithLeft:left right:right];
    [box.topLines addObject:line];
    
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
    [self.scroller flashScrollIndicators];
}

- (void)removeBox:(UIButton *)sender {
    MGBox *parentBox = [self parentBoxOf:sender];
    [self.scroller.boxes removeObject:parentBox];
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
}

- (void)moveUp:(UIButton *)sender {
    MGBox *parentBox = [self parentBoxOf:sender];
    int i = [self.scroller.boxes indexOfObject:parentBox];
    if (!i) {
        return;
    }
    [self.scroller.boxes removeObject:parentBox];
    [self.scroller.boxes insertObject:parentBox atIndex:i - 1];
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
}

- (void)moveDown:(UIButton *)sender {
    MGBox *parentBox = [self parentBoxOf:sender];
    int i = [self.scroller.boxes indexOfObject:parentBox];
    if (i == [self.scroller.boxes count] - 1) {
        return;
    }
    [self.scroller.boxes removeObject:parentBox];
    [self.scroller.boxes insertObject:parentBox atIndex:i + 1];
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
}

- (MGBox *)parentBoxOf:(UIView *)view {
    while (![view.superview isKindOfClass:[MGBox class]]) {
        if (!view.superview) {
            return nil;
        }
        view = view.superview;
    }
    return (MGBox *)view.superview;
}

- (UIButton *)button:(NSString *)title for:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    [button setTitleColor:[UIColor colorWithWhite:0.9 alpha:0.9]
             forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:0.2 alpha:0.9]
                   forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    CGSize size = [title sizeWithFont:button.titleLabel.font];
    button.frame = CGRectMake(0, 0, size.width + 18, 26);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 3;
    button.backgroundColor = self.view.backgroundColor;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0, 1);
    button.layer.shadowRadius = 0.8;
    button.layer.shadowOpacity = 0.6;
    return button;
}

- (void)shuffle {
    NSMutableArray *shuffled =
    [NSMutableArray arrayWithCapacity:[self.scroller.boxes count]];
    for (id box in self.scroller.boxes) {
        int i = arc4random() % ([shuffled count] + 1);
        [shuffled insertObject:box atIndex:i];
    }
    self.scroller.boxes = shuffled;
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Promptu";
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
											   target:self 
											   action:@selector(onComposeClick:)] autorelease];
    
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
	{
		UIPanGestureRecognizer *navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
		[self.navigationController.navigationBar addGestureRecognizer:navigationBarPanGestureRecognizer];
		
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self.navigationController.parentViewController action:@selector(revealToggle:)];
	}
    

    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:PU_PATTERN]];
    self.scroller.backgroundColor = [UIColor clearColor];

    //self.scroller.backgroundColor = [UIColor colorWithRed:0.29 green:0.32 blue:0.35 alpha:1];


    self.scroller.alwaysBounceVertical = YES;
    
//    // add a moveable box
//   [self addBox:nil];
//    
    for (int i = 0; i < [self.prompts count]; i++) {
        PUPromptBox *box = [PUPromptBox promptBoxWithPosition:i];
        box.delegate = self;
        box.dataSource = self;
        [self.scroller.boxes addObject:box];
    }
    
    MGStyledBox *box1 = [MGStyledBox box];
    self.footer = box1;
    
    //self.header = [SearchBox boxWithParent:self];
    

    

    
    // add some MGBoxLines to the box
//    UILabel *time = [[UILabel alloc] initWithFrame:CGRectZero];
//    time.text = @"24m";
//    time.backgroundColor = [UIColor clearColor];

    MGBoxLine *head1 =
    [MGBoxLine lineWithLeft:@"Left And Right Content" right:nil];
    head1.font = TITLE_FONT;
    [box1.topLines addObject:head1];
//    MGImageView *view = [MGImageView imageView];
//    [view setImage:[UIImage imageNamed: @"wood_pattern.png"]];
//    self.footer = [MGImageView imageView];
//    [self.scroller.boxes addObject:view];
    
//    // add a new MGBox to the MGScrollView
//    MGStyledBox *box1 = [MGStyledBox box];
//    [self.scroller.boxes addObject:box1];
    
//    // add some MGBoxLines to the box
//    MGBoxLine *head1 =
//    [MGBoxLine lineWithLeft:@"Left And Right Content" right:nil];
//    [box1.topLines addObject:head1];
//    
//    UISwitch *toggle = [[UISwitch alloc] initWithFrame:CGRectZero];
//    toggle.on = YES;
//    MGBoxLine *line1 =
//    [MGBoxLine lineWithLeft:@"NSString and UISwitch" right:toggle];
//    [box1.topLines addObject:line1];

    
    // draw all the boxes and animate as appropriate
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
    [self.scroller flashScrollIndicators];
    

                                                                
}

- (void)viewDidUnload
{
    [super viewDidUnload]; // Always call superclass methods first, since you are using inheritance
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - PUPromptBoxDelegate 

- (void)promptBoxDidExpand:(PUPromptBox *)promptBox
{
    [self.scroller drawBoxesWithSpeed:0.0];
}

- (void)promptBoxDidCompress:(PUPromptBox *)promptBox
{
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
}

- (void)promptBoxDidDissmiss:(PUPromptBox *)promptBox
{
    ((PUPrompt *)[self.prompts objectAtIndex:promptBox.position]).dissmissed = YES;
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
}

- (void)promptBoxDidUndissmiss:(PUPromptBox *)promptBox
{
    ((PUPrompt *)[self.prompts objectAtIndex:promptBox.position]).dissmissed = NO;
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
}

#pragma mark - PUPromptBoxDataSource

- (PUPrompt *)promptAtPosition:(int)position
{
    return [self.prompts objectAtIndex:position];
}





@end
