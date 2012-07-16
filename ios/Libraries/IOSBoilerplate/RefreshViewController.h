//
//  RefreshViewController.h
//  Promptu
//
//  Created by Brandon Millman on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EGORefreshTableHeaderView.h"

@class MGScrollView;

@interface RefreshViewController : UIViewController <EGORefreshTableHeaderDelegate, UIScrollViewDelegate> {

    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;

}

@property (nonatomic, retain) IBOutlet MGScrollView* scroller;

@end
