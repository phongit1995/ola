#import "OlaChatComposerView.h"
#import "OlaRichTextCore.h"

#import <React/RCTConversions.h>
#import <react/renderer/components/OlaNativeSpec/ComponentDescriptors.h>
#import <react/renderer/components/OlaNativeSpec/EventEmitters.h>
#import <react/renderer/components/OlaNativeSpec/Props.h>
#import <react/renderer/components/OlaNativeSpec/RCTComponentViewHelpers.h>

using namespace facebook::react;

@interface OlaChatComposerView () <RCTOlaChatComposerViewProtocol, UITextViewDelegate>
@end

@implementation OlaChatComposerView {
  UITextView *_textView;
  UILabel *_placeholderLabel;
  CGFloat _fontSize;
  CGFloat _paddingH;
  CGFloat _paddingV;
  BOOL _alignTop;
  UIColor *_textColor;
  CGFloat _lastEmittedHeight;
  BOOL _suppressChangeEvent;
  BOOL _initialTextApplied;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<OlaChatComposerComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const OlaChatComposerProps>();
    _props = defaultProps;
    _fontSize = 16;
    _paddingH = 12;
    _paddingV = 8;
    _textColor = [UIColor blackColor];
    _lastEmittedHeight = 0;
    _suppressChangeEvent = NO;
    _initialTextApplied = NO;

    _textView = [[UITextView alloc] initWithFrame:CGRectZero];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:_fontSize];
    _textView.textContainerInset = UIEdgeInsetsMake(_paddingV, _paddingH, _paddingV, _paddingH);
    _textView.textContainer.lineFragmentPadding = 0;
    _textView.scrollEnabled = YES;
    _textView.showsVerticalScrollIndicator = NO;

    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _placeholderLabel.font = [UIFont systemFontOfSize:_fontSize];
    _placeholderLabel.userInteractionEnabled = NO;
    _placeholderLabel.numberOfLines = 1;

    [self addSubview:_textView];
    [self addSubview:_placeholderLabel];

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
  NSAttributedString *current = _textView.attributedText;
  if (current.length == 0) return;
  NSString *serialized = [self serializedText];
  _suppressChangeEvent = YES;
  [self applyTokenizedText:serialized];
  _suppressChangeEvent = NO;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  _textView.frame = self.bounds;
  CGFloat placeholderHeight = ceil(_placeholderLabel.font.lineHeight);
  CGFloat placeholderY =
      _alignTop ? _paddingV : (self.bounds.size.height - placeholderHeight) / 2;
  _placeholderLabel.frame = CGRectMake(_paddingH,
                                       placeholderY,
                                       self.bounds.size.width - _paddingH * 2,
                                       placeholderHeight);
  [self emitHeightIfNeeded];
}

- (NSDictionary *)baseTypingAttributes
{
  return @{
    NSFontAttributeName : [UIFont systemFontOfSize:_fontSize],
    NSForegroundColorAttributeName : _textColor
  };
}

- (void)updateProps:(const Props::Shared &)props oldProps:(const Props::Shared &)oldProps
{
  const auto &newProps = *std::static_pointer_cast<const OlaChatComposerProps>(props);

  _fontSize = newProps.fontSize > 0 ? newProps.fontSize : 16;
  _paddingH = newProps.paddingH;
  _paddingV = newProps.paddingV;
  _alignTop = newProps.alignTop;
  _textView.textContainerInset = UIEdgeInsetsMake(_paddingV, _paddingH, _paddingV, _paddingH);
  UIColor *textColor = RCTUIColorFromSharedColor(newProps.textColor);
  _textColor = textColor != nil ? textColor : [UIColor blackColor];
  UIColor *selectionColor = RCTUIColorFromSharedColor(newProps.selectionColor);
  if (selectionColor != nil) _textView.tintColor = selectionColor;
  UIColor *placeholderColor = RCTUIColorFromSharedColor(newProps.placeholderTextColor);
  if (placeholderColor != nil) _placeholderLabel.textColor = placeholderColor;
  _placeholderLabel.text = [NSString stringWithUTF8String:newProps.placeholder.c_str()];
  _placeholderLabel.font = [UIFont systemFontOfSize:_fontSize];
  _textView.font = [UIFont systemFontOfSize:_fontSize];
  _textView.editable = newProps.editable;
  _textView.typingAttributes = [self baseTypingAttributes];

  if (!_initialTextApplied) {
    _initialTextApplied = YES;
    NSString *initialText = [NSString stringWithUTF8String:newProps.initialText.c_str()];
    if (initialText.length > 0) {
      _suppressChangeEvent = YES;
      [self applyTokenizedText:initialText];
      _suppressChangeEvent = NO;
    }
  }

  [super updateProps:props oldProps:oldProps];
  [self updatePlaceholderVisibility];
}

- (NSString *)serializedText
{
  NSAttributedString *attributed = _textView.attributedText;
  NSMutableString *result = [NSMutableString string];
  [attributed enumerateAttributesInRange:NSMakeRange(0, attributed.length)
                                 options:0
                              usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
                                OlaTokenAttachment *attachment = attrs[NSAttachmentAttributeName];
                                if ([attachment isKindOfClass:[OlaTokenAttachment class]]) {
                                  [result appendString:attachment.code];
                                } else {
                                  [result
                                      appendString:[attributed.string substringWithRange:range]];
                                }
                              }];
  return result;
}

- (void)applyTokenizedText:(NSString *)text
{
  NSAttributedString *attributed =
      [[OlaRichTextCore shared] composerFragmentForText:text
                                               fontSize:_fontSize
                                              textColor:_textColor];
  _textView.attributedText = attributed;
  _textView.selectedRange = NSMakeRange(attributed.length, 0);
  _textView.typingAttributes = [self baseTypingAttributes];
  [self updatePlaceholderVisibility];
  [self emitHeightIfNeeded];
}

- (void)insertFragment:(NSAttributedString *)fragment
{
  NSRange selection = _textView.selectedRange;
  NSMutableAttributedString *current =
      [[NSMutableAttributedString alloc] initWithAttributedString:_textView.attributedText];
  [current replaceCharactersInRange:selection withAttributedString:fragment];
  _textView.attributedText = current;
  _textView.selectedRange = NSMakeRange(selection.location + fragment.length, 0);
  _textView.typingAttributes = [self baseTypingAttributes];
  [self updatePlaceholderVisibility];
  [self emitChange];
  [self emitHeightIfNeeded];
  [_textView scrollRangeToVisible:_textView.selectedRange];
}

- (void)updatePlaceholderVisibility
{
  _placeholderLabel.hidden = _textView.attributedText.length > 0;
}

- (void)emitChange
{
  if (_suppressChangeEvent || _eventEmitter == nullptr) return;
  const auto emitter = std::static_pointer_cast<const OlaChatComposerEventEmitter>(_eventEmitter);
  emitter->onChangeText({.text = std::string([[self serializedText] UTF8String])});
}

- (void)emitHeightIfNeeded
{
  if (_eventEmitter == nullptr || self.bounds.size.width <= 0) return;
  CGSize fitting = [_textView sizeThatFits:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)];
  CGFloat height = ceil(fitting.height);
  if (fabs(height - _lastEmittedHeight) < 1) return;
  _lastEmittedHeight = height;
  const auto emitter = std::static_pointer_cast<const OlaChatComposerEventEmitter>(_eventEmitter);
  emitter->onComposerHeight({.height = height});
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
  _textView.typingAttributes = [self baseTypingAttributes];
  [self updatePlaceholderVisibility];
  [self emitChange];
  [self emitHeightIfNeeded];
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
  _textView.typingAttributes = [self baseTypingAttributes];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
  if (_eventEmitter == nullptr) return;
  std::static_pointer_cast<const OlaChatComposerEventEmitter>(_eventEmitter)->onComposerFocus({});
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
  if (_eventEmitter == nullptr) return;
  std::static_pointer_cast<const OlaChatComposerEventEmitter>(_eventEmitter)->onComposerBlur({});
}

#pragma mark - Commands

- (void)handleCommand:(const NSString *)commandName args:(const NSArray *)args
{
  RCTOlaChatComposerHandleCommand(self, commandName, args);
}

- (void)insertCode:(NSString *)code trailingSpace:(BOOL)trailingSpace
{
  OlaTokenImage *tokenImage = [[OlaRichTextCore shared] tokenImageForCode:code];
  NSMutableAttributedString *fragment = [NSMutableAttributedString new];
  if (tokenImage != nil) {
    [fragment appendAttributedString:[[OlaRichTextCore shared]
                                         composerFragmentForText:code
                                                        fontSize:_fontSize
                                                       textColor:_textColor]];
  } else {
    [fragment appendAttributedString:[[NSAttributedString alloc]
                                         initWithString:code
                                             attributes:[self baseTypingAttributes]]];
  }
  if (trailingSpace) {
    [fragment appendAttributedString:[[NSAttributedString alloc]
                                         initWithString:@" "
                                             attributes:[self baseTypingAttributes]]];
  }
  [self insertFragment:fragment];
}

- (void)insertText:(NSString *)text
{
  [self insertFragment:[[NSAttributedString alloc] initWithString:text
                                                        attributes:[self baseTypingAttributes]]];
}

- (void)backspace
{
  if (_textView.attributedText.length == 0) return;
  NSRange selection = _textView.selectedRange;
  if (selection.length == 0 && selection.location == 0) return;
  [_textView deleteBackward];
  [self updatePlaceholderVisibility];
  [self emitChange];
  [self emitHeightIfNeeded];
}

- (void)setText:(NSString *)text
{
  _suppressChangeEvent = YES;
  [self applyTokenizedText:text];
  _suppressChangeEvent = NO;
}

- (void)focus
{
  [_textView becomeFirstResponder];
}

- (void)blur
{
  [_textView resignFirstResponder];
}

- (void)prepareForRecycle
{
  [super prepareForRecycle];
  _suppressChangeEvent = YES;
  _textView.attributedText = [[NSAttributedString alloc] initWithString:@""];
  _suppressChangeEvent = NO;
  _lastEmittedHeight = 0;
  _initialTextApplied = NO;
  [self updatePlaceholderVisibility];
}

@end
