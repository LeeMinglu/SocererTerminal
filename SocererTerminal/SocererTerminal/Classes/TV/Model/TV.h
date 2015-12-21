//
//  TV.h
//  TV
//
//  Created by 李明禄 on 15/12/20.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TV : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)tvWithDict:(NSDictionary *)dict;
@end
