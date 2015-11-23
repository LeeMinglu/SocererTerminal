//
//  NSString+HMExtension.h
//  20-QQ聊天
//
//  Created by 谢聪捷 on 15/7/13.
//  Copyright (c) 2015年 Jack-Xie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (HMExtension)

/** 类方法 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
/** 对象方法 */
- (CGSize)sizeOfTextFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
