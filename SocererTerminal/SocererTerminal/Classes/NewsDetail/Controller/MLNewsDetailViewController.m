//
//  MLNewsDetailViewController.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/25.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLNewsDetailViewController.h"
#import "MLNewsDetail.h"
#import "MLNewsDetailImg.h"
#import "MLStatusBarHUD.h"
#import "MBProgressHUD+MLExtension.h"
#import "MLHeadLine.h"
#import "MLHTTPManager.h"

@interface MLNewsDetailViewController ()<UIWebViewDelegate>

/**网页视图控件*/
@property (weak, nonatomic) IBOutlet UIWebView *webView;

/**新闻详情数据模型*/
@property (nonatomic, strong) MLNewsDetail *detail;


@end

@implementation MLNewsDetailViewController

//- (void)viewDidLoad {
//    [super viewDidload];
//    
////    self.title = @"新闻详情";
////    self.webView.delegate = self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新闻详情";
    self.webView.delegate = self;
    
    // 发送请求和设置数据
    [self setupRequestAndData];
    
    
}

#pragma mark - 发送请求和设置数据
- (void)setupRequestAndData
{
    // 发送一个GET请求, 获得新闻的详情数据
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html", self.headline.docid];
    
    [[MLHTTPManager manager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSDictionary *dict = responseObject[self.headline.docid];
        // 使用模型属性存储数据
        self.detail = [MLNewsDetail newsDetailWithDict:dict];
        NSLog(@"%@",self.detail);
        
        // 展示详情内容
        [self showNewsDetail];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 请求失败
        [MBProgressHUD showError:@"网络繁忙,请稍后再试"];
        NSLog(@"%@",error);
        
    }];
}

#pragma mark - 展示详情内容
- (void)showNewsDetail
{
    
    NSMutableString *html = [NSMutableString string];
    
    
    // 头部内容
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"MLNewsDetail.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    // 具体内容
    [html appendString:@"<body>"];
    
    // 将图片插入body对应的标记中  比如: <!--IMG#0-->
    [html appendString:[self setupBoby]];
    
    [html appendString:@"</body>"];
    
    // 尾部内容
    [html appendString:@"</html>"];
    
    // 显示网页
    [self.webView loadHTMLString:html baseURL:nil];
}

// 初始化body内容
- (NSString *)setupBoby
{
    NSMutableString *body = [NSMutableString string];
    
    // 拼接标题
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detail.title];
    
    // 拼接时间
    [body appendFormat:@"<div class=\"time\">%@</div>",self.detail.ptime];
    
    
    // 拼接图片
    [body appendString:self.detail.body];
    for (MLNewsDetailImg *img in self.detail.img) {
        
        // 宽度不能超过屏幕
        // 保持原来的宽高比
        
        NSMutableString *imgHtml = [NSMutableString string];
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // img.pixel -->  550*344
        NSArray *pixel = [img.pixel componentsSeparatedByString:@"*"]; // [550, 344]
        
        int width = [[pixel firstObject] intValue];
        int height = [[pixel lastObject] intValue];
        int maxWidth = [UIScreen mainScreen].bounds.size.width * 0.9;
        if (width > maxWidth) { // 限制宽度
            height = height * maxWidth / width;
            width = maxWidth;
        }
        
        // 查看图片原始尺寸大小 和 按比例缩放后的尺寸
        NSString *onload = @"this.onclick = function() {"
        "window.location.href = 'ML:saveImageToAblum:&' + this.src"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%d\" height=\"%d\" src=\"%@\"><div>",onload,width , height, img.src];
        [imgHtml appendString:@"</div>"];
        
        
        [body replaceOccurrencesOfString:img.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
        
    }
    
    return body;
}

/**
 方法作用: 保存图片到相册
 imgSrc : 图片路径
 */
- (void)saveImageToAblum:(NSString *)imgSrc
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"是否要保存图片到相册?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        // UIWebView 的缓存由 NSURLCache 来管理
        NSURLCache *cache = [NSURLCache sharedURLCache];
        
        // 从网页的缓存中取得图片
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imgSrc]];
        NSCachedURLResponse *response = [cache cachedResponseForRequest:request];
        NSData *imageData = response.data;
        UIImage *image = [UIImage imageWithData:imageData];
        
        // 保存图片
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // 提醒用户图片保存成功还是失败
    if (error) { // 图片保存失败
        [MLStatusBarHUD showError:@"图片保存失败"];
    } else { // 图片保存成功
        [MLStatusBarHUD showSuccess:@"图片保存成功"];
    }
}

#pragma mark - <UIWebViewDelegate>
/**
 调用 : 每当webView发送一个请求之前都会先调用这个方法
 request : 即将发送的请求
 BOOL : Yes : 允许发送这个请求  No : 禁止发送这个请求
 navigationType : 是否在新窗口中打开
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"ml:"];
    if (range.length > 0) {
        NSUInteger loc = range.location + range.length;
        NSString *path = [url substringFromIndex:loc];
        // 获得方法名和参数
        NSArray *methodNameAndParam = [path componentsSeparatedByString:@"&"];
        // 方法名
        NSString *methodName = [methodNameAndParam firstObject];
        // 参数
        NSString *param = nil;
        if (methodNameAndParam.count > 1) {
            param = [methodNameAndParam lastObject];
        }
        // 调用方法
        // clang 是负责编译 OC 程序的
        // 让 clang 编译到这一行的时候压栈
#pragma clang diagnostic push
        // 让 clang 忽略 -Warc-performSelector-leaks 警告信息
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        // 将字符串转换成SEL方法
        SEL methodSel = NSSelectorFromString(methodName);
        if ([self respondsToSelector:methodSel]) { // 判断方法的目的 : 防止因为方法不存在而报错
            // 执行方法
            [self performSelector:methodSel withObject:param];
        }
        // 让 clang 出栈
#pragma clang diagnostic pop
        
        
        return NO;
    }
    
    return YES;
}

@end
