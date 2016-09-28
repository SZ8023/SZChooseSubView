//
//  SZMaskView.m
//  SZMarqueeDemo
//
//  Created by styshy on 16/9/28.
//  Copyright © 2016年 styshy. All rights reserved.
//

#import "SZMaskView.h"

@implementation SZMaskView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor =[UIColor blackColor];
    self.alpha = 0.5;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.backgroundColor = [[UIColor colorWithRed:102/255.0 green:187/255.0 blue:224/255.0 alpha:0.5] CGColor];
    }
    return self;
}

@end
