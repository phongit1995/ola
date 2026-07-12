#import "OlaRichTextView.h"
#import "OlaRichTextCore.h"

#import <React/RCTConversions.h>
#import <react/renderer/components/OlaNativeSpec/ComponentDescriptors.h>
#import <react/renderer/components/OlaNativeSpec/EventEmitters.h>
#import <react/renderer/components/OlaNativeSpec/Props.h>
#import <react/renderer/components/OlaNativeSpec/RCTComponentViewHelpers.h>

using namespace facebook::react;

@interface OlaRichTextView () <RCTOlaRichTextViewViewProtocol>
@end

@implementation OlaRichTextView {
  NSTextStorage *_textStorage;
  NSLayoutManager *_layoutManager;
  NSTextContainer *_textContainer;
  NSMutableArray<OlaLinkRange *> *_links;
  NSString *_content;
  CGFloat _fontSize;
  NSInteger _maxLines;
  UIColor *_textColor;
  UIColor *_accentColor;
  UITapGestureRecognizer *_tapRecognizer;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<OlaRichTextViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const OlaRichTextViewProps>();
    _props = defaultProps;
    _links = [NSMutableArray array];
    _content = @"";
    _fontSize = 16;
    _maxLines = 0;
    _textColor = [UIColor blackColor];
    _accentColor = [UIColor blackColor];
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                             action:@selector(handleTap:)];
    [self addGestureRecognizer:_tapRecognizer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(imagesDidLoad)
                                                 name:OlaRichTextImagesDidLoadNotification
                                               object:nil];
  }
  return self;
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)imagesDidLoad
{
  [self rebuildText];
}

- (void)updateProps:(const Props::Shared &)props oldProps:(const Props::Shared &)oldProps
{
  const auto &newProps = *std::static_pointer_cast<const OlaRichTextViewProps>(props);

  _content = [NSString stringWithUTF8String:newProps.content.c_str()];
  _fontSize = newProps.fontSize;
  _maxLines = newProps.maxLines;
  UIColor *textColor = RCTUIColorFromSharedColor(newProps.textColor);
  UIColor *accentColor = RCTUIColorFromSharedColor(newProps.accentColor);
  _textColor = textColor != nil ? textColor : [UIColor blackColor];
  _accentColor = accentColor != nil ? accentColor : _textColor;

  [super updateProps:props oldProps:oldProps];
  [self rebuildText];
}

- (void)rebuildText
{
  [_links removeAllObjects];
  NSAttributedString *attributed =
      [[OlaRichTextCore shared] attributedStringForContent:_content
                                                  fontSize:_fontSize
                                                 textColor:_textColor
                                               accentColor:_accentColor
                                                      rich:YES
                                                     links:_links];
  _textStorage = [[NSTextStorage alloc] initWithAttributedString:attributed];
  _layoutManager = [NSLayoutManager new];
  _textContainer = [[NSTextContainer alloc]
      initWithSize:CGSizeMake(self.bounds.size.width > 0 ? self.bounds.size.width : CGFLOAT_MAX,
                              CGFLOAT_MAX)];
  _textContainer.lineFragmentPadding = 0;
  _textContainer.maximumNumberOfLines = _maxLines > 0 ? _maxLines : 0;
  _textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
  [_layoutManager addTextContainer:_textContainer];
  [_textStorage addLayoutManager:_layoutManager];
  [self setNeedsDisplay];
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  if (_textContainer != nil && _textContainer.size.width != self.bounds.size.width &&
      self.bounds.size.width > 0) {
    _textContainer.size = CGSizeMake(self.bounds.size.width, CGFLOAT_MAX);
    [self setNeedsDisplay];
  }
}

- (void)drawRect:(CGRect)rect
{
  if (_layoutManager == nil || _textContainer == nil) return;
  NSRange glyphRange = [_layoutManager glyphRangeForTextContainer:_textContainer];
  [_layoutManager drawBackgroundForGlyphRange:glyphRange atPoint:CGPointZero];
  [_layoutManager drawGlyphsForGlyphRange:glyphRange atPoint:CGPointZero];
}

- (nullable OlaLinkRange *)linkAtPoint:(CGPoint)point
{
  if (_layoutManager == nil || _links.count == 0 || _textStorage.length == 0) return nil;
  NSUInteger glyphIndex = [_layoutManager glyphIndexForPoint:point inTextContainer:_textContainer];
  CGRect glyphRect = [_layoutManager boundingRectForGlyphRange:NSMakeRange(glyphIndex, 1)
                                               inTextContainer:_textContainer];
  if (!CGRectContainsPoint(CGRectInset(glyphRect, -4, -4), point)) return nil;
  NSUInteger charIndex = [_layoutManager characterIndexForGlyphAtIndex:glyphIndex];
  for (OlaLinkRange *link in _links) {
    if (NSLocationInRange(charIndex, link.range)) return link;
  }
  return nil;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  if (![self pointInside:point withEvent:event]) return nil;
  return [self linkAtPoint:point] != nil ? self : nil;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
  OlaLinkRange *link = [self linkAtPoint:[recognizer locationInView:self]];
  if (link == nil || _eventEmitter == nullptr) return;
  const auto emitter = std::static_pointer_cast<const OlaRichTextViewEventEmitter>(_eventEmitter);
  if (link.kind == OlaLinkKindMention) {
    emitter->onMentionPress({.nick = std::string([link.payload UTF8String])});
  } else {
    emitter->onUrlPress({.url = std::string([link.payload UTF8String])});
  }
}

- (void)prepareForRecycle
{
  [super prepareForRecycle];
  _content = @"";
  [_links removeAllObjects];
  _textStorage = nil;
  _layoutManager = nil;
  _textContainer = nil;
}

@end
