//
//  MLMainViewController.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/23.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLMainViewController.h"
#import "MLChannel.h"
#import "MLHeadLineViewController.h"
#import "MLSocietyViewController.h"
#import "MLHomeLabel.h"

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
    
//    NSLog(@"%@", self.channelList);
    
    [self setupChildsVces];
    
    
    [self setupTitles];
    
}

- (void)setupChildsVces {
    //1.新闻控制器
    UIStoryboard *headLineStoryBoard = [UIStoryboard storyboardWithName:@"HeadLine" bundle:nil];
    
    MLHeadLineViewController *headLineVc = [headLineStoryBoard instantiateViewControllerWithIdentifier:@"HeadLine"];
    
    //传递url字符串---> 用来发送请求
    headLineVc.urlString = [self.channelList[0] tid];
    
    //传递标题名称 -> 用来显示在Label标签上
    headLineVc.title = [self.channelList[0] tname];
    
    [self addChildViewController:headLineVc];
    
    
    //2.社会控制器
    UIStoryboard *societyStoryBoard = [UIStoryboard storyboardWithName:@"Society" bundle:nil];
    MLSocietyViewController *societyVc = [societyStoryBoard instantiateViewControllerWithIdentifier:@"Society"];
    
    societyVc.urlString = [self.channelList[1] tid];
    societyVc.title = [self.channelList[1] tname];
    
    [self addChildViewController:societyVc];
    
    
    //3.循环创建多个控制器
    
    int count = (int)self.channelList.count - 2;
    
    for (int i = 0; i < count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = [self.channelList[i + 2]  tname];
        [self addChildViewController:vc];
//        NSLog(@"lllllllll:%@", [self.channelList[i] tname]);
    }

}

- (void)setupTitles {
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat labelW = 80;
    CGFloat labelH = 30;
    CGFloat labelY = 0;
    
    for (NSUInteger i = 0 ; i < count; i++) {
        //创建label
        MLHomeLabel *label = [[MLHomeLabel alloc] init];
        label.tag = i;
        [self.titleScrollView addSubview:label];
        
        //设置Frame
        CGFloat labelX = i * labelW;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        //设置文字
        UIViewController *vc = self.childViewControllers[i];
        label.text = vc.title;
        
        //监听点击
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        
        //设置scrollView内容的大小
        CGFloat titleContentW = count * labelW;
        self.titleScrollView.contentSize = CGSizeMake(titleContentW, 0);
        
        
    }
    
}

//监听label的点击
- (void)labelClick:(UIGestureRecognizer *)recognizer {
    //1.获得被点击的label
    MLHomeLabel *label = (MLHomeLabel *)recognizer.view;
    
    //2.计算x方向上的偏移量
    CGFloat offsetX = label.tag * self.contentScrollView.frame.size.width;
    
    //3.设置偏移量
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0)];
    
}


@end
