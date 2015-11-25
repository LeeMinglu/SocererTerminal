//
//  MLNewsDetailViewController.h
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/25.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLHeadLine;

@interface MLNewsDetailViewController : UIViewController
/** 数据模型属性 */
@property (nonatomic, strong) MLHeadLine *headline;
@end
