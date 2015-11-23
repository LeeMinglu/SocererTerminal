//
//  MLMainTabBarController.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/23.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLMainTabBarController.h"
#import "MLNavigationController.h"
#import "MLBottomTabBar.h"
#import "MLBottomTabBarBtn.h"



@implementation MLMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化子控制器
    [self setupChildViewControllers];
    
    //初始化自定义底部TabBar
    [self setupCustomTabBar];
    
    
}



- (void)setupChildViewControllers {
    // 1.新闻中心
    MLNavigationController *navMainHall = [self navigationControllerWithStoryboardName:@"Main"];
    
    // 2.阅读中心
    MLNavigationController *navReadingHall = [self navigationControllerWithStoryboardName:@"Reading"];
    
    //3.视听中心
    MLNavigationController *navVideoHall = [self navigationControllerWithStoryboardName:@"Video"];
    
    //4.发现
    MLNavigationController *navDiscoverHall = [self navigationControllerWithStoryboardName:@"Discover"];
    
    // 5.我
    MLNavigationController *navMeHall = [self navigationControllerWithStoryboardName:@"Me"];
    
    //将所有的控制器添加到TabBar控制器中
    self.viewControllers = @[navMainHall, navReadingHall, navVideoHall, navDiscoverHall, navMeHall];
}

//封装一个根据storyboard文件名快速创建箭头指向的初始化控制器(MLNavigationController)
- (MLNavigationController *) navigationControllerWithStoryboardName:(NSString *)name {
    //1.加载storyboard文件
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    
    //2.创建storyboard中指向的初始化控制器, 也就是自定义的导航控制器
    return [storyboard instantiateInitialViewController];

}

//初始化自定义底部TabBar
- (void)setupCustomTabBar {
    //1.创建自定义的tabBar
    MLBottomTabBar *tabBar = [[MLBottomTabBar alloc] init];
    
    //2.通过循环来创建多个tabBarButton
    NSUInteger count = self.childViewControllers.count;
    for (int i = 0; i < count; i++) {
        
        //获取普通图片和选中图片的名称
        NSString *normal = [NSString stringWithFormat:@"TabBar%d", (i + 1)];
        NSString *selected = [NSString stringWithFormat:@"TabBar%dSel", (i + 1)];
        
        // 调用内部封装的方法来快速创建自定义tabBar按钮
        [tabBar addBottomBarButtonWithImage:normal selected:selected];
    }
    
    //3.设置frame并添加到系统的tabBar中
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    
    //设置当前控制器为tabBar的代理
    tabBar.delegate = self;
    
}

//实现协议的方法
- (void)buttomTabBar:(MLBottomTabBar *)tabBar didClickButtonTabBarWithIndex:(int)index {
    
    // 让UITabBarController自己来切换需要显示的子控制器 selectedIndex是系统内部自己的属性
    self.selectedIndex = index;
}




@end
