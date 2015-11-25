//
//  NSString+MLExtension.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/25.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "NSString+MLExtension.h"

@implementation NSString (MLExtension)
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
