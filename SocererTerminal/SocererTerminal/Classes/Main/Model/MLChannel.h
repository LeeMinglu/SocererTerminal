//
//  MLChannel.h
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/24.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLChannel : NSObject

@property (nonatomic, strong) NSString *tname;
@property (nonatomic, strong) NSString *tid;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)channelWithDictionary:(NSDictionary *)dict;
@end
