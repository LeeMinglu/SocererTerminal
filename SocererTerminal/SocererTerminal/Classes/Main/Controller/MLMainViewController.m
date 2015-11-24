//
//  MLMainViewController.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/23.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLMainViewController.h"
#import "MLChannel.h"

@interface MLMainViewController ()

/**
 *  存放频道清单的数组
 */
@property (nonatomic, strong) NSArray *channelList;

/**
 *  存放所有标题的ScrollView
 */
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;

/**
 *  存放所有内容的ScrollView
 */
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation MLMainViewController

- (NSArray *)channelList {
    if (!_channelList) {
        //1. 加载json的二进制数据
        NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        //2.反序列化
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        //3.从字典中获取数据据
        NSArray *dictArray = dict[dict.keyEnumerator.nextObject];
        
        //4.进行字典转模型
        NSMutableArray *modeArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            MLChannel *channel = [MLChannel channelWithDictionary:dict];
            [modeArray addObject:channel];
        }
        
        //5.返回一个从小到大排序的数据.tid是从小到大排序的
        _channelList = [modeArray sortedArrayUsingComparator:^NSComparisonResult(MLChannel *obj1, MLChannel *obj2) {
            return [obj1.tid compare:obj2.tid];
        }];
    }
    return _channelList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", self.channelList);
}


@end
