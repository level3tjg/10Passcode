#import "Tweak.h"

%hook UIFont
+ (instancetype)fontWithDescriptor:(UIFontDescriptor *)descriptor size:(CGFloat)size {
  if (forceRegularTextStyle)
    descriptor = CTFontDescriptorCreateWithTextStyle(kCTFontDescriptorTextStyleRegular, NULL, NULL);
  else if (forceThinTextStyle)
    descriptor = CTFontDescriptorCreateWithTextStyle(kCTFontDescriptorTextStyleThin, NULL, NULL);
  return %orig;
}
%end

%hook SBPasscodeNumberPadButton
- (instancetype)initForCharacter:(NSInteger)character {
  if ((self = %orig)) {
    for (UIView *view in self.subviews)
      if (![view isEqual:self.circleView]) [view removeFromSuperview];
    self.circleView.layer.borderWidth = 2;
    self.circleView.layer.borderColor = UIColor.whiteColor.CGColor;
    self.circleView.backgroundColor = UIColor.clearColor;
    self.circleView.alpha = [self.class unhighlightedCircleViewAlpha];
  }
  return self;
}
- (void)setHighlighted:(BOOL)highlighted {
  %orig;
  if (highlighted) forceRegularTextStyle = YES;
  if ([self respondsToSelector:@selector(reloadImagesForCurrentCharacter)])
    [self reloadImagesForCurrentCharacter];
  if ([self respondsToSelector:@selector(loadImagesForCurrentCharacter)])
    [self loadImagesForCurrentCharacter];
  forceRegularTextStyle = NO;
}
- (void)highlightCircleView:(BOOL)highlight animated:(BOOL)animated {
  void (^animations)() = ^{
    self.circleView.layer.borderWidth = highlight ? 0 : 2;
    self.circleView.backgroundColor = highlight ? UIColor.whiteColor : UIColor.clearColor;
    self.circleView.alpha = highlight ? [self.class highlightedCircleViewAlpha]
                                      : [self.class unhighlightedCircleViewAlpha];
  };
  if (animated) {
    UIViewPropertyAnimator *animator =
        [[UIViewPropertyAnimator alloc] initWithDuration:highlight ? 0 : .85
                                           controlPoint1:CGPointMake(0, 0)
                                           controlPoint2:CGPointMake(0, 1)
                                              animations:animations];
    [animator startAnimation];
  } else {
    animations();
  }
}
+ (UIImage *)imageForCharacter:(NSInteger)character
                   highlighted:(BOOL)highlighted
                  whiteVersion:(BOOL)whiteVersion {
  forceThinTextStyle = YES;
  UIImage *image = %orig;
  forceThinTextStyle = NO;
  return image;
}
%end

%hook TPFileStorageManager
- (UIImage *)imageWithName:(NSString *)name {
  return nil;
}
- (void)saveImage:(UIImage *)image withName:(NSString *)name {
}
%end
