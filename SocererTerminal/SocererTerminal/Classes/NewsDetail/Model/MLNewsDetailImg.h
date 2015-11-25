//
//  MLNewsDetailImg.h
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/25.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLNewsDetailImg : NSObject

/**图片路径*/
@property (nonatomic, copy) NSString *src;

/**图片尺寸*/
@property (nonatomic, copy) NSString *pixel;

/**图片所处的位置*/
@property (nonatomic, copy) NSString *ref;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)newsDetailImgWithDict:(NSDictionary *)dict;


@end
