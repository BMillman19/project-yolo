//
//  TextBadge.h
//

#import <UIKit/UIKit.h>


@interface TextBadge : UIView {
	NSString* text;
}

@property (nonatomic, retain) NSString* text;

- (id)initWithFrame:(CGRect)frame withText:(NSString *)aText;
- (void)drawWithText:(NSString* )aText;

@end
