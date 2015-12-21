//
//  TV.m
//  TV
//
//  Created by 李明禄 on 15/12/20.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "TV.h"

@implementation TV

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)tvWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
