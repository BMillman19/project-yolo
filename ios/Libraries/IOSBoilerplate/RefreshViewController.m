//
//  RefreshViewController.m
//  Promptu
//
//  Created by Brandon Millman on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RefreshViewController.h"

#import "MGScrollView.h"

@implementation RefreshViewController

@synthesize refreshHeaderView, reloading, scroller, header, footer;

- (void)dealloc {
    self.refreshHeaderView.delegate = nil;
	self.refreshHeaderView = nil;
    [refreshHeaderView release];
    [scroller release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadDataSource {
	self.reloading = YES;
}

- (void)doneLoadingData {
	self.reloading = NO;
	[self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scroller];
    [self.scroller drawBoxesWithSpeed:ANIM_SPEED];
}


#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
	return self.reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
	return [NSDate date]; // should return date data source was last changed
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (!self.refreshHeaderView) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f -[self.scroller bounds].size.height, self.view.frame.size.width, [self.scroller bounds].size.height)];        
		view.delegate = self;
		[self.scroller addSubview:view];
		self.refreshHeaderView = view;
		[view release];
		
	}
	
	[self.refreshHeaderView refreshLastUpdatedDate];
    
    UISearchBar *temp = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    [[temp.subviews objectAtIndex:0] removeFromSuperview];
    temp.showsCancelButton=NO;
    temp.autocorrectionType=UITextAutocorrectionTypeNo;
    temp.autocapitalizationType=UITextAutocapitalizationTypeNone;
    temp.placeholder = @"Yolo bitch";
    temp.delegate=self;
    self.scroller.tableHeaderView=temp;
    [temp release];
    
    //scroller.contentOffset = CGPointMake(0,45);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.refreshHeaderView.delegate = nil;
	self.refreshHeaderView = nil;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)addBox:(id<MGBoxProtocol>)aBox atIndex:(int)index
{
    
    if(self.header)
        index += 1;
    if(self.footer)
        [self.scroller.boxes removeObject:self.footer];
    [self.scroller.boxes insertObject:aBox atIndex:index];
    if(self.footer)
        [self.scroller.boxes addObject:self.footer];
}

- (void)addBox:(id<MGBoxProtocol>)aBox;
{
    [self addBox:aBox atIndex:0];
}

- (void)setFooter:(id<MGBoxProtocol>)aFooter
{
    footer = aFooter;
    [self.scroller.boxes addObject:aFooter];
}

- (void)setHeader:(id<MGBoxProtocol>)aHeader
{
    header = aHeader;
    [self.scroller.boxes insertObject:aHeader atIndex:0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}





@end
