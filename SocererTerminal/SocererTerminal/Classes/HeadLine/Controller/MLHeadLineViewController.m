//
//  MLHeadLineViewController.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/24.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLHeadLineViewController.h"
#import "MLHTTPManager.h"
#import "MLHeadLine.h"
#import "MLHeadLineCell.h"
#import "MBProgressHUD+MLExtension.h"

@interface MLHeadLineViewController ()

@property (nonatomic, strong) NSArray *headlines;

@end

@implementation MLHeadLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //根据域名拼接URL请求路径
    NSString *domainURL = [kNetEaseDomain stringByAppendingString:self.urlString];
    
    domainURL = [NSString stringWithFormat:@"%@/0-140.html",domainURL];
    
    //向服务器发送请求
    [[MLHTTPManager manager] GET:domainURL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@", responseObject);
        
        //解析数据
//        [responseObject writeToFile:@"/Users/luoriver/Desktop/news.plist" atomically:YES];
        
        NSArray *dictArray = responseObject[self.urlString];
        
        
        NSMutableArray *modelArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            MLHeadLine *headline = [MLHeadLine headlineWithDictionary:dict];
            
            [modelArray addObject:headline];
        }
        
        self.headlines = [modelArray copy];
        
        //定义要刷新否则没有数据
        [self.tableView reloadData];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"网络繁忙,请稍候再试!"];
        NSLog(@"错误:%@",error);
    }];
    
    
}


#pragma mark - 实现数据源方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.headlines.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MLHeadLine *headline = self.headlines[indexPath.row];
    
    NSString *ID = [MLHeadLineCell headlineCellWithIdentifier:headline];
    
    MLHeadLineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.headline = headline;
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLHeadLine *headline = self.headlines[indexPath.row];
    if (headline.imgextra.count == 2) {
        return 120;  // 120 -> @"ImagesCell"
    }
    
    if (headline.isBigImage) {
        return 180;  //// 180 -> @"BigImageCell"
    }
    
    return 80; // 80 -> @"NewsCell"
}
@end
