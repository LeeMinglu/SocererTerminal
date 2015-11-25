//
//  MLHeadLine.h
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/25.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLHeadLine : NSObject

/**新闻标题*/
@property (nonatomic, copy) NSString *title;


/**新闻摘要*/
@property (nonatomic, copy) NSString *digest;

/**图片*/
@property (nonatomic, copy) NSString *imgsrc;

/**新闻id */
@property (nonatomic, copy) NSString *docid;

/**跟帖数量 */
@property (nonatomic, assign) int replyCount;

/**多图数组(两张) */
@property (nonatomic, strong) NSArray *imgextra;

/**添加一个图片类型属性,如果是大图, 那么数值就为1 */
@property (nonatomic, assign, getter=isBigImage) BOOL imgType;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)headlineWithDictionary:(NSDictionary *)dict;


@end
