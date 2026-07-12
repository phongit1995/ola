#import "OlaRichTextCore.h"

NSNotificationName const OlaRichTextImagesDidLoadNotification = @"OlaRichTextImagesDidLoad";

@implementation OlaLinkRange
@end

@implementation OlaTokenAttachment
@end

@implementation OlaTokenImage
@end

static NSString *const kMentionSource = @"@[A-Za-z0-9][A-Za-z0-9._-]*[A-Za-z0-9]";
static NSString *const kHashtagSource = @"#[A-Za-z0-9_.]+";
static NSString *const kUrlSource = @"https?:\\/\\/[^\\s]+|www\\.[^\\s]+";

@interface OlaRichTextCore ()
@property (nonatomic, strong) NSArray<OlaTokenImage *> *emojiImages;
@property (nonatomic, strong) NSDictionary<NSString *, OlaTokenImage *> *smileyByCode;
@property (nonatomic, strong, nullable) NSRegularExpression *tokenRegex;
@property (nonatomic, strong) NSRegularExpression *postTokenRegex;
@property (nonatomic, strong) NSRegularExpression *mentionRegex;
@property (nonatomic, strong) NSRegularExpression *hashtagRegex;
@property (nonatomic, strong) NSRegularExpression *urlRegex;
@property (nonatomic, strong) NSRegularExpression *trailingPunctuationRegex;
@property (nonatomic, strong) NSRegularExpression *emojiTokenRegex;
@end

@implementation OlaRichTextCore

+ (instancetype)shared
{
  static OlaRichTextCore *instance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [OlaRichTextCore new];
  });
  return instance;
}

- (instancetype)init
{
  if (self = [super init]) {
    _emojiImages = @[];
    _smileyByCode = @{};
    NSString *postPattern =
        [NSString stringWithFormat:@"(%@|%@|%@)", kMentionSource, kHashtagSource, kUrlSource];
    _postTokenRegex = [NSRegularExpression regularExpressionWithPattern:postPattern
                                                                options:0
                                                                  error:nil];
    _mentionRegex = [NSRegularExpression
        regularExpressionWithPattern:[NSString stringWithFormat:@"^(?:%@)$", kMentionSource]
                             options:0
                               error:nil];
    _hashtagRegex = [NSRegularExpression
        regularExpressionWithPattern:[NSString stringWithFormat:@"^(?:%@)$", kHashtagSource]
                             options:0
                               error:nil];
    _urlRegex = [NSRegularExpression
        regularExpressionWithPattern:[NSString stringWithFormat:@"^(?:%@)$", kUrlSource]
                             options:0
                               error:nil];
    _trailingPunctuationRegex =
        [NSRegularExpression regularExpressionWithPattern:@"[.,;:!?)\\]}'\"]+$" options:0 error:nil];
    _emojiTokenRegex = [NSRegularExpression regularExpressionWithPattern:@"^\\[e:(\\d{1,2})\\]$"
                                                                 options:0
                                                                   error:nil];
  }
  return self;
}

- (BOOL)isConfigured
{
  return self.tokenRegex != nil;
}

- (void)configureWithDictionary:(NSDictionary *)config
{
  CGFloat smileyFactor = [config[@"smileyFactor"] doubleValue] ?: 1.25;
  CGFloat emojiFactor = [config[@"emojiFactor"] doubleValue] ?: 1.15;

  NSMutableArray<OlaTokenImage *> *emoji = [NSMutableArray array];
  for (NSDictionary *entry in config[@"emoji"]) {
    OlaTokenImage *image = [OlaTokenImage new];
    image.uri = [entry[@"uri"] isKindOfClass:[NSString class]] ? entry[@"uri"] : @"";
    image.aspect = [entry[@"aspect"] doubleValue] ?: 1;
    image.heightFactor = emojiFactor;
    [emoji addObject:image];
  }

  NSMutableDictionary<NSString *, OlaTokenImage *> *smileyByCode = [NSMutableDictionary dictionary];
  NSMutableArray<NSString *> *smileyCodes = [NSMutableArray array];
  for (NSDictionary *entry in config[@"smileys"]) {
    OlaTokenImage *image = [OlaTokenImage new];
    image.uri = [entry[@"uri"] isKindOfClass:[NSString class]] ? entry[@"uri"] : @"";
    image.aspect = [entry[@"aspect"] doubleValue] ?: 1;
    image.heightFactor = smileyFactor;
    for (NSString *code in entry[@"codes"]) {
      if (![code isKindOfClass:[NSString class]] || code.length == 0) continue;
      smileyByCode[code] = image;
      [smileyCodes addObject:code];
    }
  }

  [smileyCodes sortUsingComparator:^NSComparisonResult(NSString *a, NSString *b) {
    if (a.length == b.length) return NSOrderedSame;
    return a.length > b.length ? NSOrderedAscending : NSOrderedDescending;
  }];
  NSMutableArray<NSString *> *escaped = [NSMutableArray array];
  for (NSString *code in smileyCodes) {
    [escaped addObject:[NSRegularExpression escapedPatternForString:code]];
  }
  NSString *pattern =
      [NSString stringWithFormat:@"\\[e:\\d{1,2}\\]|%@", [escaped componentsJoinedByString:@"|"]];

  self.emojiImages = emoji;
  self.smileyByCode = smileyByCode;
  self.tokenRegex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];

  [self loadImages];
}

- (void)loadImages
{
  NSMutableArray<OlaTokenImage *> *all = [NSMutableArray arrayWithArray:self.emojiImages];
  NSMutableSet<OlaTokenImage *> *unique = [NSMutableSet setWithArray:self.smileyByCode.allValues];
  [all addObjectsFromArray:unique.allObjects];

  dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
    for (OlaTokenImage *entry in all) {
      if (entry.image != nil || entry.uri.length == 0) continue;
      UIImage *loaded = nil;
      if ([entry.uri hasPrefix:@"http://"] || [entry.uri hasPrefix:@"https://"]) {
        NSURL *url = [NSURL URLWithString:entry.uri];
        NSData *data = url != nil ? [NSData dataWithContentsOfURL:url] : nil;
        loaded = data != nil ? [UIImage imageWithData:data] : nil;
      } else if ([entry.uri hasPrefix:@"file://"]) {
        NSURL *url = [NSURL URLWithString:entry.uri];
        loaded = url.path != nil ? [UIImage imageWithContentsOfFile:url.path] : nil;
      } else {
        loaded = [UIImage imageNamed:entry.uri];
        if (loaded == nil) {
          NSString *path = [[NSBundle mainBundle] pathForResource:entry.uri ofType:nil];
          loaded = path != nil ? [UIImage imageWithContentsOfFile:path] : nil;
        }
      }
      entry.image = loaded;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      [[NSNotificationCenter defaultCenter] postNotificationName:OlaRichTextImagesDidLoadNotification
                                                          object:nil];
    });
  });
}

- (nullable OlaTokenImage *)tokenImageForCode:(NSString *)code
{
  NSTextCheckingResult *emojiMatch =
      [self.emojiTokenRegex firstMatchInString:code options:0 range:NSMakeRange(0, code.length)];
  if (emojiMatch != nil) {
    NSInteger index = [[code substringWithRange:[emojiMatch rangeAtIndex:1]] integerValue];
    if (index >= 1 && index <= (NSInteger)self.emojiImages.count) {
      return self.emojiImages[index - 1];
    }
    return nil;
  }
  return self.smileyByCode[code];
}

- (NSAttributedString *)attachmentStringForCode:(NSString *)code
                                       fontSize:(CGFloat)fontSize
                                      tokenImage:(OlaTokenImage *)tokenImage
{
  UIFont *font = [UIFont systemFontOfSize:fontSize];
  CGFloat height = fontSize * tokenImage.heightFactor;
  CGFloat width = height * tokenImage.aspect;
  OlaTokenAttachment *attachment = [OlaTokenAttachment new];
  attachment.code = code;
  attachment.image = tokenImage.image;
  attachment.bounds = CGRectMake(0, font.descender, width, height);
  return [NSAttributedString attributedStringWithAttachment:attachment];
}

- (NSAttributedString *)tokenizedText:(NSString *)text
                             fontSize:(CGFloat)fontSize
                           attributes:(NSDictionary *)attributes
{
  NSMutableAttributedString *result = [NSMutableAttributedString new];
  NSRegularExpression *regex = self.tokenRegex;
  if (regex == nil || text.length == 0) {
    if (text.length > 0) {
      [result appendAttributedString:[[NSAttributedString alloc] initWithString:text
                                                                     attributes:attributes]];
    }
    return result;
  }
  __block NSUInteger lastIndex = 0;
  [regex enumerateMatchesInString:text
                          options:0
                            range:NSMakeRange(0, text.length)
                       usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop) {
                         NSString *code = [text substringWithRange:match.range];
                         OlaTokenImage *tokenImage = [self tokenImageForCode:code];
                         if (tokenImage == nil) return;
                         if (match.range.location > lastIndex) {
                           NSString *plain = [text
                               substringWithRange:NSMakeRange(lastIndex,
                                                              match.range.location - lastIndex)];
                           [result appendAttributedString:[[NSAttributedString alloc]
                                                              initWithString:plain
                                                                  attributes:attributes]];
                         }
                         [result appendAttributedString:[self attachmentStringForCode:code
                                                                             fontSize:fontSize
                                                                            tokenImage:tokenImage]];
                         lastIndex = NSMaxRange(match.range);
                       }];
  if (lastIndex < text.length) {
    NSString *plain = [text substringFromIndex:lastIndex];
    [result appendAttributedString:[[NSAttributedString alloc] initWithString:plain
                                                                   attributes:attributes]];
  }
  return result;
}

- (NSAttributedString *)composerFragmentForText:(NSString *)text
                                       fontSize:(CGFloat)fontSize
                                      textColor:(UIColor *)textColor
{
  UIFont *font = [UIFont systemFontOfSize:fontSize];
  return [self tokenizedText:text
                    fontSize:fontSize
                  attributes:@{NSFontAttributeName : font, NSForegroundColorAttributeName : textColor}];
}

- (BOOL)fullyMatches:(NSRegularExpression *)regex text:(NSString *)text
{
  if (text.length == 0) return NO;
  NSTextCheckingResult *match = [regex firstMatchInString:text
                                                  options:0
                                                    range:NSMakeRange(0, text.length)];
  return match != nil && NSEqualRanges(match.range, NSMakeRange(0, text.length));
}

- (NSAttributedString *)attributedStringForContent:(NSString *)content
                                          fontSize:(CGFloat)fontSize
                                         textColor:(UIColor *)textColor
                                       accentColor:(UIColor *)accentColor
                                              rich:(BOOL)rich
                                             links:(NSMutableArray<OlaLinkRange *> *)links
{
  UIFont *font = [UIFont systemFontOfSize:fontSize];
  NSDictionary *baseAttributes =
      @{NSFontAttributeName : font, NSForegroundColorAttributeName : textColor};
  if (!rich) {
    return [self tokenizedText:content fontSize:fontSize attributes:baseAttributes];
  }

  NSMutableAttributedString *result = [NSMutableAttributedString new];
  NSMutableArray<NSString *> *parts = [NSMutableArray array];
  __block NSUInteger lastIndex = 0;
  [self.postTokenRegex
      enumerateMatchesInString:content
                       options:0
                         range:NSMakeRange(0, content.length)
                    usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop) {
                      [parts addObject:[content substringWithRange:NSMakeRange(
                                                                       lastIndex,
                                                                       match.range.location -
                                                                           lastIndex)]];
                      [parts addObject:[content substringWithRange:match.range]];
                      lastIndex = NSMaxRange(match.range);
                    }];
  [parts addObject:[content substringFromIndex:lastIndex]];

  for (NSString *part in parts) {
    if (part.length == 0) continue;
    if ([self fullyMatches:self.mentionRegex text:part]) {
      NSUInteger start = result.length;
      UIFont *bold = [UIFont systemFontOfSize:fontSize weight:UIFontWeightSemibold];
      [result appendAttributedString:
                  [[NSAttributedString alloc]
                      initWithString:part
                          attributes:@{
                            NSFontAttributeName : bold,
                            NSForegroundColorAttributeName : accentColor
                          }]];
      if (links != nil) {
        OlaLinkRange *link = [OlaLinkRange new];
        link.range = NSMakeRange(start, part.length);
        link.kind = OlaLinkKindMention;
        link.payload = [part substringFromIndex:1];
        [links addObject:link];
      }
      continue;
    }
    if ([self fullyMatches:self.hashtagRegex text:part]) {
      [result appendAttributedString:
                  [[NSAttributedString alloc]
                      initWithString:part
                          attributes:@{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : accentColor
                          }]];
      continue;
    }
    if ([self fullyMatches:self.urlRegex text:part]) {
      NSTextCheckingResult *trailingMatch =
          [self.trailingPunctuationRegex firstMatchInString:part
                                                    options:0
                                                      range:NSMakeRange(0, part.length)];
      NSString *trailing =
          trailingMatch != nil ? [part substringWithRange:trailingMatch.range] : @"";
      NSString *url = trailing.length == 0
                          ? part
                          : [part substringToIndex:part.length - trailing.length];
      NSString *href =
          [url hasPrefix:@"www."] ? [NSString stringWithFormat:@"https://%@", url] : url;
      NSUInteger start = result.length;
      [result appendAttributedString:
                  [[NSAttributedString alloc]
                      initWithString:url
                          attributes:@{
                            NSFontAttributeName : font,
                            NSForegroundColorAttributeName : accentColor,
                            NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)
                          }]];
      if (links != nil) {
        OlaLinkRange *link = [OlaLinkRange new];
        link.range = NSMakeRange(start, url.length);
        link.kind = OlaLinkKindUrl;
        link.payload = href;
        [links addObject:link];
      }
      if (trailing.length > 0) {
        [result appendAttributedString:[[NSAttributedString alloc] initWithString:trailing
                                                                       attributes:baseAttributes]];
      }
      continue;
    }
    [result appendAttributedString:[self tokenizedText:part
                                               fontSize:fontSize
                                             attributes:baseAttributes]];
  }
  return result;
}

- (CGSize)measureContent:(NSString *)content
                maxWidth:(CGFloat)maxWidth
                fontSize:(CGFloat)fontSize
                maxLines:(NSInteger)maxLines
{
  NSAttributedString *attributed = [self attributedStringForContent:content
                                                           fontSize:fontSize
                                                          textColor:[UIColor blackColor]
                                                        accentColor:[UIColor blackColor]
                                                               rich:YES
                                                              links:nil];
  NSTextStorage *storage = [[NSTextStorage alloc] initWithAttributedString:attributed];
  NSLayoutManager *layoutManager = [NSLayoutManager new];
  NSTextContainer *container =
      [[NSTextContainer alloc] initWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)];
  container.lineFragmentPadding = 0;
  container.maximumNumberOfLines = maxLines > 0 ? maxLines : 0;
  container.lineBreakMode = NSLineBreakByTruncatingTail;
  [layoutManager addTextContainer:container];
  [storage addLayoutManager:layoutManager];
  [layoutManager ensureLayoutForTextContainer:container];
  CGRect used = [layoutManager usedRectForTextContainer:container];
  return CGSizeMake(MIN(ceil(used.size.width), maxWidth), ceil(used.size.height));
}

@end
