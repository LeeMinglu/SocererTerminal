//
//  MLHeadLineCell.h
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/25.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLHeadLine;

@interface MLHeadLineCell : UITableViewCell

/**数据模型属性 */
@property (nonatomic, strong) MLHeadLine *headline;

/**根据创建的模型来返回相对应的cell重用标识符 */
+ (NSString *)headlineCellWithIdentifier:(MLHeadLine *) headline;

@end
