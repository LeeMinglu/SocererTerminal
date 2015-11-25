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
#import "MLLeftDockMenu.h"

@interface MLMainViewController ()<UIScrollViewDelegate>

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

/**  左边菜单视图*/
@property (nonatomic, weak) MLLeftDockMenu *leftDockMenu;

@end

@implementation MLMainViewController

#pragma mark - 懒加载方法
- (NSArray *)channelList
{
    if (_channelList == nil) {
        // 1. 加载json的二进制数据
        NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        // 2. 反序列化
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
        
        // 3. 从字典中获取数组数据
        //       MLLog(@"%@",dict[dict.keyEnumerator.nextObject]); // 返回的是一个字典数组对象
        NSArray *dictArray = dict[dict.keyEnumerator.nextObject];
        
        // 4. 进行字典转模型
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            // 将字典的key赋值给模型的属性进行存储
            MLChannel *channel = [MLChannel channelWithDictionary:dict];
            [modelArray addObject:channel];
        }
        
        // 5. 返回一个从小到大的数组, 经过观察发现tid是从小到大排序的
        _channelList = [modelArray sortedArrayUsingComparator:^NSComparisonResult(MLChannel *obj1, MLChannel *obj2) {
            return [obj1.tid compare:obj2.tid];
        }];
    }
    return _channelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    NSLog(@"%@",self.channelList);
    
    // 1. 添加所有的子控制器 (父子控制器)
    [self setupChildVces];
    
    // 2.添加顶部的所有标题
    [self setupTitles];
    
    // 3. 设置scrollView的一些属性
    [self setupScrollViewProperties];
    
    // 4. 添加默认子控制器
    [self setupDefaultViewController];
    
    // 5. 设置默认MLHomeLabel的比例值
    MLHomeLabel *firstLabel = [self.titleScrollView.subviews firstObject];
    firstLabel.scale = 1.0;
    
    // 6. 设置导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sidebar_nav_news"] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftItemClick)];
    
    
}




/**
 *  切换子控制器
 *
 *  @param index 需要显示的子控制器的索引
 */

#pragma mark - 导航栏左边item点击事件
- (void)navLeftItemClick
{
    // 1. 如果左边的菜单视图已经存在,表示用户不是第一次点击, 就需要判断是展开还是合闭
    if (self.leftDockMenu) {
        // 左边菜单视图为展开状态
        if (self.contentScrollView.contentOffset.x < 0) { // 需要合闭
            [self.contentScrollView setContentOffset:CGPointZero animated:YES];
        } else { // 需要展开
            // 让内容滚动视图向右偏移200的间距, 特别注意 : 一旦滚动视图被点击或触摸, 就会执行 scrollViewDidScroll: 方法,恢复原来状态
            [self.contentScrollView setContentOffset:CGPointMake(-200, 0) animated:YES];
        }
        
    } else { // 2. 如果左边的菜单视图不存在,表示用户是第一次点击,那么就创建左边的菜单视图
        [self setupLeftDockMenu];
        [self.contentScrollView setContentOffset:CGPointMake(-200, 0) animated:YES];
    }
}

#pragma mark - 添加左菜单和右菜单
- (void)setupLeftDockMenu
{
    // 1. 创建左边的菜单视图
    MLLeftDockMenu *leftDockMenu = [[MLLeftDockMenu alloc] init];
    leftDockMenu.height = 300;
    leftDockMenu.width = 150;
    leftDockMenu.y = (self.contentScrollView.height - leftDockMenu.height) * 0.5;
    leftDockMenu.x = -200;
    
    // 2. 添加到滚动视图中
    [self.contentScrollView addSubview:leftDockMenu];
    
    // 3. 记录左边的菜单视图
    self.leftDockMenu = leftDockMenu;
}


#pragma mark - 添加默认子控制器
- (void)setupDefaultViewController
{
    MLHeadLineViewController *firstVc = [self.childViewControllers firstObject];
    firstVc.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:firstVc.view];
}

#pragma mark - 设置scrollView的一些属性
- (void)setupScrollViewProperties
{
    // 1. 取消水平和垂直滚动条, 否则会报 [UIImageView setScale:] 找不到方法!
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    // 2. 设置scrollView的代理方法
    self.contentScrollView.delegate = self;
    // 3. 设置分页效果
    self.contentScrollView.pagingEnabled = YES;
    // 4. 设置内容滚动视图的 size
    CGFloat contentW = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.contentScrollView.contentSize = CGSizeMake(contentW, 0);
    // 5. 取消scrollView自动调整内边距的属性值
    self.automaticallyAdjustsScrollViewInsets = NO;
}


#pragma mark - 添加所有的子控制器
/**
 *  添加所有的子控制器
 */
- (void)setupChildVces
{
    // 1. 新闻控制器
    UIStoryboard *headlineStoryBoard = [UIStoryboard storyboardWithName:@"HeadLine" bundle:nil];
    MLHeadLineViewController *headlineVc = [headlineStoryBoard instantiateViewControllerWithIdentifier:@"HeadLine"];
    
    // 传递url字符串 -> 用来发送请求
    headlineVc.urlString = [self.channelList[0] tid];
    // 传递标题名称 -> 用来显示在label标签上
    headlineVc.title = [self.channelList[0] tname];
    // 添加子控制器
    [self addChildViewController:headlineVc];
    
    
    // 2. 社会控制器
    UIStoryboard *societyStoryBoard = [UIStoryboard storyboardWithName:@"Society" bundle:nil];
    MLSocietyViewController *societyVc = [societyStoryBoard instantiateViewControllerWithIdentifier:@"Society"];
    societyVc.urlString = [self.channelList[1] tid];
    societyVc.title = [self.channelList[1] tname];
    [self addChildViewController:societyVc];
    
    // 3. 循环创建多个控制器
    int count = (int)self.channelList.count - 2; // (2代表新闻控制器和社会控制器已经创建完成)
    for (int i = 0; i < count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = [self.channelList[i + 2] tname];
        [self addChildViewController:vc];
    }
}

/**
 *  添加顶部的所有标题
 */
- (void)setupTitles
{
    // 创建label
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat labelW = 80;
    CGFloat labelH = 30;
    CGFloat labelY = 0;
    
    for (NSUInteger i = 0; i < count; i++) {
        // 创建label
        MLHomeLabel *label = [[MLHomeLabel alloc] init];
        label.tag = i;
        [self.titleScrollView addSubview:label];
        
        // 设置frame
        CGFloat labelX = i * labelW;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        // 设置文字
        UIViewController *vc = self.childViewControllers[i];
        label.text = vc.title;
        
        // 监听点击
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    }
    
    // 设置scrollView的内容大小
    CGFloat titlesContentW = count * labelW;
    self.titleScrollView.contentSize = CGSizeMake(titlesContentW, 0);
}

/**
 *  监听label的点击
 */
- (void)labelClick:(UITapGestureRecognizer *)recognizer
{
    // 1. 获得被点击的label
    MLHomeLabel *label = (MLHomeLabel *)recognizer.view;
    
    // 2. 计算x方向上的偏移量
    CGFloat offsetX = label.tag * self.contentScrollView.frame.size.width;
    
    // 3. 设置偏移量
    //    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0); // 没有动画
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES]; // 有动画
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  在scrollview动画结束时调用 (添加子控制器的view到 self.contentScrollview )
 *
 *  @param scrollView == self.contentScrollview
 *  用户手动触发的动画结束,不会调用这个方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //    NSLog(@"scrollViewDidEndScrollingAnimation");
    
    // 获得当前需要显示的子控制器索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIViewController *vc = self.childViewControllers[index];
    
    // 滚动标题栏 (self.titleScrollview)
    MLHomeLabel *label = self.titleScrollView.subviews[index];
    CGFloat width = self.titleScrollView.frame.size.width;
    CGFloat offsetX = label.center.x - width * 0.5;
    // 最大偏移量
    CGFloat maxOffsetx = self.titleScrollView.contentSize.width - width;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > maxOffsetx) {
        offsetX = maxOffsetx;
    }
    //    self.titleScrollView.contentOffset = CGPointMake(offsetX, 0);
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    // 遍历其它的label
    [self.titleScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            MLHomeLabel *otherLabel = self.titleScrollView.subviews[idx];
            otherLabel.scale = 0.0;
            
        }
    }];
    
    // 如果子控制器的view已经在上面,就直接返回
    if (vc.view.superview) return;
    
    // 添加
    CGFloat vcW = scrollView.frame.size.width;
    CGFloat vcH = scrollView.frame.size.height;
    CGFloat vcY = 0;
    CGFloat vcX = index * vcW;
    
    
    
    vc.view.frame = CGRectMake(vcX, vcY, vcW, vcH);
    
    [scrollView addSubview:vc.view];
}
/**
 *  当scrollview停止滚动时调用这个方法 (用户手动触发的动画结束,会调用这个方法)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1. 需要进行控制的文字 (2个标题)
    // 2. 两个标题各自的比例值
#warning 这里最好取绝对值 (保证计算出来的比例是个非负数)
    // 偏移量 / 宽度
    CGFloat value = ABS(self.contentScrollView.contentOffset.x / self.contentScrollView.frame.size.width);
    
    //    NSLog(@"%f",value);
    
    // 左边文字的索引
    NSUInteger leftIndex = (NSUInteger)value;
    // 右边文字的索引
    NSUInteger rightIndex = leftIndex + 1;
    
    // 右边文字的比例
    CGFloat rightScale = value - leftIndex;
    // 左边文字的比例
    CGFloat leftScale = 1 - rightScale;
    
    // 取出label设置大小和颜色
    MLHomeLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    leftLabel.scale = leftScale;
    if (rightIndex < self.titleScrollView.subviews.count) {
        MLHomeLabel *rightLabel = self.titleScrollView.subviews[rightIndex];
        rightLabel.scale = rightScale;
    }
}


@end
