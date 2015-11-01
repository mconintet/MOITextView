//
//  macro.h
//  MOITextViewDemo
//
//  Created by mconintet on 10/21/15.
//  Copyright © 2015 mconintet. All rights reserved.
//

#ifndef macro_h
#define macro_h

#ifdef DEBUG
#define DLOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLOG(...)
#endif

#define UICOLOR_FROM_RGB(rgbValue)                              \
    [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0 \
                    green:((rgbValue & 0x00FF00) >> 8) / 255.0  \
                     blue:(rgbValue & 0x0000FF) / 255.0         \
                    alpha:1.0]

#define UICOLOR_TO_HEX(uicolor)                                            \
    ((((int)(CGColorGetComponents([uicolor CGColor])[0] * 255)) << 16)     \
        | (((int)(CGColorGetComponents([uicolor CGColor])[1] * 255)) << 8) \
        | ((int)(CGColorGetComponents([uicolor CGColor])[2] * 255)))

#endif /* macro_h */
