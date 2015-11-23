//
//  NSString+HMExtension.m
//  20-QQ聊天
//
//  Created by 谢聪捷 on 15/7/13.
//  Copyright (c) 2015年 Jack-Xie. All rights reserved.
//

#import "NSString+HMExtension.h"

@implementation NSString (HMExtension)

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeOfTextFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    return [NSString sizeWithText:self font:font maxSize:maxSize];
}

@end
