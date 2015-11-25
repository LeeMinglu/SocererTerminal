//
//  MLHTTPManager.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/25.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLHTTPManager.h"

@implementation MLHTTPManager

+ (instancetype)manager {
    MLHTTPManager  *manager = [super manager];
    
    NSMutableSet *newSet = [NSMutableSet set];
    newSet.set = manager.responseSerializer.acceptableContentTypes;
    [newSet addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = newSet;
    return manager;
    
}

@end
