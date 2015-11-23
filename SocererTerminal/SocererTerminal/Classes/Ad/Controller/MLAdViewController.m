//
//  MLAdViewController.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/23.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLAdViewController.h"
#import "MLMainTabBarController.h"

@interface MLAdViewController ()

@end

@implementation MLAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置背景图片
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
    
    [self.view addSubview:backgroundImageView];
    backgroundImageView.frame = self.view.bounds;
    
    
    //2.添加广告图片
    UIImageView *adImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ad"]];
    adImageView.width = 306;
    adImageView.height = 310;
    adImageView.centerX = self.view.width * 0.5;
    adImageView.centerY = self.view.height * 0.4;
    [self.view addSubview:adImageView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        MLMainTabBarController *mainTabBarVc = [[MLMainTabBarController alloc] init];
        window.rootViewController = mainTabBarVc;
        
    });
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
