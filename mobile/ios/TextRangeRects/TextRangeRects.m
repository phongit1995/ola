#import <React/RCTBridgeModule.h>
#import <UIKit/UIKit.h>

@interface TextRangeRects : NSObject <RCTBridgeModule>
@end

@implementation TextRangeRects

RCT_EXPORT_MODULE(TextRangeRects);

@synthesize viewRegistry_DEPRECATED = _viewRegistry_DEPRECATED;

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

static UIView<UITextInput> *OlaFindTextInputView(UIView *root)
{
  if ([root conformsToProtocol:@protocol(UITextInput)]) {
    return (UIView<UITextInput> *)root;
  }
  for (UIView *subview in root.subviews) {
    UIView<UITextInput> *found = OlaFindTextInputView(subview);
    if (found != nil) {
      return found;
    }
  }
  return nil;
}

RCT_EXPORT_METHOD(measure:(nonnull NSNumber *)reactTag
                  starts:(NSArray<NSNumber *> *)starts
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  UIView *componentView = [self->_viewRegistry_DEPRECATED viewForReactTag:reactTag];
  if (componentView == nil) {
    reject(@"no_view", @"view not found for tag", nil);
    return;
  }
  UIView<UITextInput> *input = OlaFindTextInputView(componentView);
  if (input == nil) {
    reject(@"no_input", @"text input not found in view", nil);
    return;
  }
  CGPoint contentOffset = CGPointZero;
  if ([input isKindOfClass:[UIScrollView class]]) {
    contentOffset = ((UIScrollView *)input).contentOffset;
  }
  NSMutableArray *result = [NSMutableArray arrayWithCapacity:starts.count];
  for (NSNumber *startNumber in starts) {
    NSInteger start = startNumber.integerValue;
    UITextPosition *from = [input positionFromPosition:input.beginningOfDocument offset:start];
    UITextPosition *to = [input positionFromPosition:input.beginningOfDocument offset:start + 1];
    if (from == nil || to == nil) {
      [result addObject:@{ @"x" : @0, @"y" : @0, @"width" : @0, @"height" : @0 }];
      continue;
    }
    UITextRange *range = [input textRangeFromPosition:from toPosition:to];
    CGRect rect = [input firstRectForRange:range];
    if (CGRectIsNull(rect) || CGRectIsInfinite(rect)) {
      [result addObject:@{ @"x" : @0, @"y" : @0, @"width" : @0, @"height" : @0 }];
      continue;
    }
    CGRect converted = [input convertRect:rect toView:componentView];
    [result addObject:@{
      @"x" : @(converted.origin.x + contentOffset.x),
      @"y" : @(converted.origin.y + contentOffset.y),
      @"width" : @(converted.size.width),
      @"height" : @(converted.size.height),
    }];
  }
  resolve(result);
}

@end
