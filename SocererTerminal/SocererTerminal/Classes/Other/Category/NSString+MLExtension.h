//
//  NSString+MLExtension.h
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/25.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

@interface NSString (MLExtension)
/** 类方法 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
/** 对象方法 */
- (CGSize)sizeOfTextFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
