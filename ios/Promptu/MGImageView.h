//
//  MGImageView.h
//  Promptu
//
//  Created by Brandon Millman on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MGBoxProtocol.h"

@interface MGImageView : UIImageView <MGBoxProtocol>;

+ (id)imageView;


@end
