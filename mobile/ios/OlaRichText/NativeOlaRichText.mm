#import "NativeOlaRichText.h"
#import "OlaRichTextCore.h"

@implementation NativeOlaRichText

+ (NSString *)moduleName
{
  return @"OlaRichText";
}

- (void)configure:(NSDictionary *)config
{
  [[OlaRichTextCore shared] configureWithDictionary:config];
}

- (NSArray<NSNumber *> *)measure:(NSString *)content
                        maxWidth:(double)maxWidth
                        fontSize:(double)fontSize
                        maxLines:(double)maxLines
{
  CGSize size = [[OlaRichTextCore shared] measureContent:content
                                                 maxWidth:maxWidth
                                                 fontSize:fontSize
                                                 maxLines:(NSInteger)maxLines];
  return @[ @(size.width), @(size.height) ];
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeOlaRichTextSpecJSI>(params);
}

@end
