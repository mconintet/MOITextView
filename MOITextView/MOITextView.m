//
//  MOITextView.m
//  MOITextViewDemo
//
//  Created by mconintet on 10/21/15.
//  Copyright © 2015 mconintet. All rights reserved.
//

#import "MOITextView.h"
#import "macro.h"

#define MOITV_PLACEHOLDER_COLOR 0xC3C3C3
#define MOITV_NORMAL_TEXT_COLOR 0x0

#define MOITV_BORDER_WIDTH 1.0f
#define MOITV_BORDER_RADIUS 3.0f
#define MOITV_BORDER_COLOR 0xC1C0C6

#define MOITV_BACKGROUND_COLOR 0xF9F9F9

#define MOITV_PADDING UIEdgeInsetsMake(4, 2, 4, 2)

@interface MOITextView ()
@property (nonatomic, strong) UITextView* calcTextView;
@end

@implementation MOITextView

- (instancetype)initWithFont:(UIFont*)font
                     padding:(UIEdgeInsets)padding
                 placeholder:(NSString*)placeholder
                       width:(CGFloat)width
                   maxHeight:(CGFloat)maxHeight
{
    self = [super init];
    if (self) {
        _placeholder = placeholder;
        _maxHeight = maxHeight;

        CGRect frame = self.frame;
        frame.size.width = width;
        self.frame = frame;

        self.font = font;
        self.text = _placeholder;

        self.textContainerInset = UIEdgeInsetsEqualToEdgeInsets(padding, UIEdgeInsetsZero) ? MOITV_PADDING : padding;
        self.textColor = UICOLOR_FROM_RGB(MOITV_PLACEHOLDER_COLOR);
        self.backgroundColor = UICOLOR_FROM_RGB(MOITV_BACKGROUND_COLOR);
        self.scrollEnabled = NO;

        self.layer.borderColor = [UICOLOR_FROM_RGB(MOITV_BORDER_COLOR) CGColor];
        self.layer.borderWidth = MOITV_BORDER_WIDTH;
        self.layer.cornerRadius = MOITV_BORDER_RADIUS;

        self.delegate = self;

        CGFloat height = [[self class] calcHeightWithText:self.text
                                                     font:self.font
                                                  padding:self.textContainerInset
                                                    width:width];
        DLOG(@"height: %f", height);

        [self applyHeight:height newOffset:nil];
    }
    return self;
}

+ (CGFloat)calcHeightWithText:(NSString*)text
                         font:(UIFont*)font
                      padding:(UIEdgeInsets)padding
                        width:(CGFloat)width
{
    static UITextView* calcTextView = nil;
    if (calcTextView == nil) {
        calcTextView = ({
            UITextView* tv = [[UITextView alloc] init];
            tv.scrollEnabled = NO;
            tv;
        });
    }

    calcTextView.textContainerInset = UIEdgeInsetsEqualToEdgeInsets(padding, UIEdgeInsetsZero) ? MOITV_PADDING : padding;
    calcTextView.font = font;
    calcTextView.text = text;
    CGSize size = [calcTextView sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];

    return size.height;
}

- (BOOL)applyHeight:(CGFloat)height newOffset:(CGFloat*)newOffset
{
    height = MIN(_maxHeight, height);
    self.scrollEnabled = height == _maxHeight;

    CGRect frame = self.frame;
    if (height != frame.size.height) {

        if (newOffset != nil) {
            *newOffset = height - frame.size.height;
        }

        frame.size.height = height;
        self.frame = frame;

        DLOG(@"applyHeight: %f offset: %f", height, newOffset != nil ? *newOffset : -1);
        return true;
    }
    return false;
}

- (void)setWidth:(CGFloat)width trigger:(BOOL)trigger
{
    CGRect frame = self.frame;
    if (frame.size.width != width) {
        frame.size.width = width;
        self.frame = frame;

        CGFloat height = [[self class] calcHeightWithText:self.text
                                                     font:self.font
                                                  padding:self.textContainerInset
                                                    width:width];
        CGFloat newOffset;
        BOOL hasChange = [self applyHeight:height newOffset:&newOffset];

        if (hasChange && trigger) {
            [self.moiTextViewDelegate didChangeHeight:height
                                             textView:self
                                               offset:newOffset];
        }
    }
}

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView*)textView
{
    int textColor = UICOLOR_TO_HEX(self.textColor);
    if (textColor == MOITV_PLACEHOLDER_COLOR) {
        self.text = @"";
        self.textColor = UICOLOR_FROM_RGB(MOITV_NORMAL_TEXT_COLOR);
    }

    if ([self.moiTextViewDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.moiTextViewDelegate textViewDidBeginEditing:self];
    }
}

- (void)textViewDidEndEditing:(UITextView*)textView
{
    if ([self.text isEqualToString:@""]) {
        self.text = self.placeholder;
        self.textColor = UICOLOR_FROM_RGB(MOITV_PLACEHOLDER_COLOR);
    }

    if ([self.moiTextViewDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.moiTextViewDelegate textViewDidEndEditing:self];
    }
}

- (void)textViewDidChange:(UITextView*)textView
{
    CGFloat height = [[self class] calcHeightWithText:self.text
                                                 font:self.font
                                              padding:self.textContainerInset
                                                width:self.frame.size.width];

    CGFloat newOffset;
    BOOL hasChange = [self applyHeight:height newOffset:&newOffset];
    if (hasChange) {
        [self.moiTextViewDelegate didChangeHeight:height
                                         textView:self
                                           offset:newOffset];
    }

    if ([self.moiTextViewDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.moiTextViewDelegate textViewDidChange:self];
    }
}

- (void)triggerDidChangeAfterSetText:(NSString*)text
{
    self.text = text;
    [self textViewDidChange:self];
}

@end
