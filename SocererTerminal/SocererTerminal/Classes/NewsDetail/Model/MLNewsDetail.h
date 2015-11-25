//
//  MLNewsDetail.h
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/25.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLNewsDetail : NSObject

/**新闻标题*/
@property (nonatomic, copy) NSString *title;

/**发布时间*/
@property (nonatomic, copy) NSString *ptime;

/**新闻内容*/
@property (nonatomic, copy) NSString *body;

/**新闻详情配图*/
@property (nonatomic, strong) NSArray *img;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)newsDetailWithDict:(NSDictionary *)dict;
@end
