//
//  ImageBox.h
//  Promptu
//
//  Created by Brandon Millman on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGStyledBox.h"

@interface ImageBox : MGStyledBox

+ (id)imageBoxWithImageName:(NSString *)aName;
+ (id)imageBoxWithImage:(UIImage *)anImage;

@end
