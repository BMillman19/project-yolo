//
//  SearchBox.m
//  Promptu
//
//  Created by Brandon Millman on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchBox.h"

#import "MGBoxLine.h"

#define DEFAULT_WIDTH          304.0
#define DEFAULT_TOP_MARGIN      10.0
#define DEFAULT_LEFT_MARGIN      8.0
#define CORNER_RADIUS            4.0

@implementation SearchBox

+ (id)boxWithParent:(UIViewController *)parent {
    CGRect frame = CGRectMake(DEFAULT_LEFT_MARGIN, 0, DEFAULT_WIDTH, 0);
    SearchBox *box = [[[self class] alloc] initWithFrame:frame withParent:parent];
    return box;
}

- (id)initWithFrame:(CGRect)frame withParent:(UIViewController *)parent
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizesSubviews = YES;
        self.topMargin = DEFAULT_TOP_MARGIN;
        self.bottomMargin = 0;
        
   
        
        UISearchBar* sb = [[UISearchBar alloc] initWithFrame:frame];
        sb.delegate = self;
        sb.tintColor = [UIColor redColor];
        [sb setScopeButtonTitles:[NSArray arrayWithObjects:@"All",@"Name",@"State",nil]];
        //searchView.delegate = self;
        [sb setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [sb sizeToFit];
        
        MGBoxLine *search = [MGBoxLine lineWithLeft:sb right:nil];
        [self.topLines addObject:search];
        
        UISearchDisplayController* sdc = [[UISearchDisplayController alloc] initWithSearchBar:sb contentsController:parent];
        sdc.delegate = self;
        sdc.searchResultsDelegate = self;
        sdc.searchResultsDataSource = self;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
