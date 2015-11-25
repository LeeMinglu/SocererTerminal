//
//  MLNewsDetail.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/25.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLNewsDetail.h"
#import "MLNewsDetailImg.h"

@implementation MLNewsDetail
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        NSArray *dictArray = self.img;
        NSMutableArray *modelArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            MLNewsDetailImg *imgModel = [MLNewsDetailImg newsDetailImgWithDict:dict];
            [modelArray addObject:imgModel];
            
        }
        
        self.img = modelArray;
    }
    return self;
}

+ (instancetype)newsDetailWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
