//
//  MLChannel.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/24.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLChannel.h"

@implementation MLChannel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        self.tname = dict[@"tname"];
        self.tid = dict[@"tid"];
    }
    return self;
}

+ (instancetype)channelWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

//- (void)setValue:(id)value forUndefinedKey:(NrSString *)key {}

@end
