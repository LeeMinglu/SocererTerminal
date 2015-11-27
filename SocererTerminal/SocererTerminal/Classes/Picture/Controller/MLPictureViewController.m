//
//  MLPictureViewController.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/26.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLPictureViewController.h"

@interface MLPictureViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backItemClick:(id)sender;

@end

@implementation MLPictureViewController

- (UIImageView *)pictureImageView {
    if (_pictureImageView.animationImages == nil) {
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 1; i < 35; i++) {
            //2.获取图片的名称
            NSString *imageName = [NSString stringWithFormat:@"bobo_flower_frame%02d",i];
            
            //3.通过图片名称获取图片对象
            UIImage *image = [UIImage imageNamed:imageName];
            
            //4.将图片添加到临时图片数组中
            [imageArray addObject:image];
        }
        
        //5.将临时图片数组中的图片赋值给pictureView动画属性
        _pictureImageView.animationImages = imageArray;
    }
    return _pictureImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //设置动画重复次数,精确动画播放的境,并开始动画
    self.pictureImageView.animationRepeatCount = 1;
    
    self.pictureImageView.animationDuration = self.pictureImageView.animationImages.count * 0.2;
    
    //动画播放的时间
    [self.pictureImageView startAnimating];
    
    //使用动画来完成序列帧图片数组的播放
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.transform = CGAffineTransformMakeTranslation(0, 80);
    }];
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    //滑动结束后复位tableView
    [UIView animateWithDuration:1.0 animations:^{
        self.tableView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"picture_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"图片cell";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"picture_%zd",indexPath.row];
    cell.backgroundColor = MLRandomColor;
    
    return cell;
}

//导航栏左边item的点击
- (IBAction)backItemClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
