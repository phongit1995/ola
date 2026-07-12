#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSNotificationName const OlaRichTextImagesDidLoadNotification;

typedef NS_ENUM(NSInteger, OlaLinkKind) {
  OlaLinkKindMention,
  OlaLinkKindUrl,
};

@interface OlaLinkRange : NSObject
@property (nonatomic, assign) NSRange range;
@property (nonatomic, assign) OlaLinkKind kind;
@property (nonatomic, copy) NSString *payload;
@end

@interface OlaTokenAttachment : NSTextAttachment
@property (nonatomic, copy) NSString *code;
@end

@interface OlaTokenImage : NSObject
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, assign) CGFloat aspect;
@property (nonatomic, assign) CGFloat heightFactor;
@property (nonatomic, strong, nullable) UIImage *image;
@end

@interface OlaRichTextCore : NSObject

+ (instancetype)shared;

- (void)configureWithDictionary:(NSDictionary *)config;
- (BOOL)isConfigured;
- (nullable OlaTokenImage *)tokenImageForCode:(NSString *)code;

- (NSAttributedString *)attributedStringForContent:(NSString *)content
                                          fontSize:(CGFloat)fontSize
                                         textColor:(UIColor *)textColor
                                       accentColor:(UIColor *)accentColor
                                              rich:(BOOL)rich
                                             links:(nullable NSMutableArray<OlaLinkRange *> *)links;

- (NSAttributedString *)composerFragmentForText:(NSString *)text
                                       fontSize:(CGFloat)fontSize
                                      textColor:(UIColor *)textColor;

- (CGSize)measureContent:(NSString *)content
                maxWidth:(CGFloat)maxWidth
                fontSize:(CGFloat)fontSize
                maxLines:(NSInteger)maxLines;

@end

NS_ASSUME_NONNULL_END
