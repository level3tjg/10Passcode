#import <UIKit/UIKit.h>

extern UIFontDescriptor *CTFontDescriptorCreateWithTextStyle(
    CFStringRef textStyle, CFStringRef sizeCategory, CFStringRef language);

extern CFStringRef kCTFontDescriptorTextStyleThin;
extern CFStringRef kCTFontDescriptorTextStyleRegular;

static BOOL forceThinTextStyle;
static BOOL forceRegularTextStyle;

@interface TPNumberPadButton : UIControl
@property(atomic, readwrite, strong) UIView *circleView;
- (void)loadImagesForCurrentCharacter;
- (void)reloadImagesForCurrentCharacter;
+ (CGFloat)highlightedCircleViewAlpha;
+ (CGFloat)unhighlightedCircleViewAlpha;
@end

@interface SBPasscodeNumberPadButton : TPNumberPadButton
@end
