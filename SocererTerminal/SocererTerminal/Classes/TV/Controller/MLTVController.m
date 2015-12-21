//
//  MLTVController.m
//  TV
//
//  Created by 李明禄 on 15/12/20.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLTVController.h"
#import "TVViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "TV.h"

@interface MLTVController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionViewController *tvVC;

/** 只支持全屏播放，需要modal显示 */
// 播放m3u8格式，不要使用MPMoviePlayerController，否则切换全屏会有问题！
@property (nonatomic, strong) MPMoviePlayerViewController *player;

@property (nonatomic, strong) NSArray *tves;

@end

@implementation MLTVController

- (NSArray *)tves {
    if (!_tves) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"luo.plist" ofType:nil];
        NSArray *tvDictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in tvDictArray) {
            TV *tv = [TV tvWithDict:dict];
            [arrM addObject:tv];
        }
        self.tves = [arrM copy];
    }
    return _tves;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
        // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TVViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    //设置流水布局
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat layoutW = self.view.bounds.size.width * 0.3;
    CGFloat layoutH = 100 +  arc4random_uniform(50);
    
    
    //设置布局属性
    flowlayout.itemSize = CGSizeMake(layoutW, layoutH);
    
    // 设置UICollectionView距离顶部的扩展区域
    flowlayout.headerReferenceSize = CGSizeMake(0, 100);
    flowlayout.footerReferenceSize = CGSizeMake(0, 300);
    
    // 同时设置上左下右
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 50, 100, 200);
    // 设置间隙
    flowlayout.minimumLineSpacing = 10; // 水平间距
    
    flowlayout.minimumInteritemSpacing = 100; // 垂直方向间隙, 注意由于是流

//    MLTVController *tvVC = [[MLTVController alloc] initWithCollectionViewLayout:flowlayout];
//
//    self.tvVC = tvVC;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.tves.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TVViewCell *cell = (TVViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    TV *tv = self.tves[indexPath.item];
    
    cell.tv = tv;
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {


    TV *tv = self.tves[indexPath.item];
    NSString *tvURL = tv.url;
    
//    NSLog(@"")
    [self CollectionViewCellWithURL:tvURL];
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)CollectionViewCellWithURL:(NSString *)URLString {
    NSURL *url = [NSURL URLWithString:URLString];
    
    self.player = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    // modal显示视频播放器
    [self presentViewController:self.player animated:YES completion:nil];

}

@end
