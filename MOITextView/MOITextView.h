//
//  MOITextView.h
//  MOITextViewDemo
//
//  Created by mconintet on 10/21/15.
//  Copyright © 2015 mconintet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MOITextView;

@protocol MOITextViewDelegate <UITextViewDelegate>

- (void)didChangeHeight:(CGFloat)height
               textView:(MOITextView*)textView
                 offset:(CGFloat)offset;

@end

@interface MOITextView : UITextView <UITextViewDelegate>

@property (nonatomic, strong, readonly) NSString* placeholder;
@property (nonatomic, assign, readonly) CGFloat maxHeight;
@property (nonatomic, assign, readonly) UIEdgeInsets padding;
@property (nonatomic, strong) id<MOITextViewDelegate> moiTextViewDelegate;

- (instancetype)initWithFont:(UIFont*)font
                     padding:(UIEdgeInsets)padding
                 placeholder:(NSString*)placeholder
                       width:(CGFloat)width
                   maxHeight:(CGFloat)maxHeight;

-(void)triggerDidChangeAfterSetText:(NSString*)text;

+ (CGFloat)calcHeightWithText:(NSString*)text
                         font:(UIFont*)font
                      padding:(UIEdgeInsets)padding
                        width:(CGFloat)width;
@end
