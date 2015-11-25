//
//  MLHeadLine.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/25.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLHeadLine.h"


@implementation MLHeadLine

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)headlineWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

// 重写,什么都不做,防止字典转模型奔溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}




@end
