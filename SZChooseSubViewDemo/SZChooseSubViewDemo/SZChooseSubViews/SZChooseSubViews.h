//
//  SZChooseSubViews.h
//  SZMarqueeDemo
//
//  Created by styshy on 16/9/27.
//  Copyright © 2016年 styshy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZChooseSubViews : UIView

/** 选中的子视图 */
@property(nonatomic, strong) NSMutableArray *choosedSubViews;

/**
 *  subViews: 设置好frame之后，可以传入设置好frame的子视图数组
 *  chooseBlock: 选中视图之后的触发事件
 */
- (void)chooseWithOriginSubViews:(NSArray *)subViews completionBlock:(void (^)(NSArray *chooseSubViews))chooseBlock;

@end
