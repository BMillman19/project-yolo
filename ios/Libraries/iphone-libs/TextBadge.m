//
//  TextBadge.m
//

#import "TextBadge.h"


@implementation TextBadge

@synthesize text;

- (id)initWithFrame:(CGRect)frame withText:(NSString *)aText {
    if (self = [super initWithFrame:frame]) {
		[self setBackgroundColor: [UIColor clearColor]];
		text = aText;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	if (!text) return;
	UIFont *font = [UIFont boldSystemFontOfSize: 16];
	CGSize numberSize = [text sizeWithFont: font];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	float radius = numberSize.height / 2.0;
	float startPoint = (rect.size.width - (numberSize.width + numberSize.height))/2.0;
	
	CGContextSetRGBFillColor(context, 0.55, 0.6, 0.70, 1.0);
	CGContextBeginPath(context);
	CGContextAddArc(context, startPoint + radius, radius, radius, M_PI / 2 , 3 * M_PI / 2, NO);
	CGContextAddArc(context, startPoint + radius + numberSize.width, radius, radius, 3 * M_PI / 2, M_PI / 2, NO);
	CGContextClosePath(context);
	CGContextFillPath(context);
	
	[[UIColor whiteColor] set];	
	[text drawInRect: CGRectMake(startPoint + radius, rect.origin.y, rect.size.width, rect.size.height) withFont: font];
}

- (void)drawWithText:(NSString *)aText {
	self.text = aText;
	[self setNeedsDisplay];
}

- (void)dealloc {
    [text release];
    [super dealloc];
}


@end
