//
//  DACircularProgressView.h
//  DACircularProgress
//
//  Created by Daniel Amitay on 2/6/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DA_ROUNDED_CORNERS_DEFAULT YES

@interface DACircularProgressView : UIView

@property(nonatomic, retain) UIColor *trackTintColor;
@property(nonatomic, retain) UIColor *progressTintColor;
@property(nonatomic, retain) NSTimer *timer;
@property(nonatomic, assign) BOOL roundedCorners;
@property(nonatomic, assign) CGFloat progress;

- (void)startAnimating;
- (void)stopAnimating;

@end
