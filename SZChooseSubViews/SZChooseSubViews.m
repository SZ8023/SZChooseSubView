//
//  SZChooseSubViews.m
//  SZMarqueeDemo
//
//  Created by styshy on 16/9/27.
//  Copyright © 2016年 styshy. All rights reserved.
//

#import "SZChooseSubViews.h"
#import "SZMaskView.h"

#define SZNormalColor [UIColor redColor]
#define SZHightedColor [UIColor blackColor]

@interface SZChooseSubViews()<UIGestureRecognizerDelegate>

@property(nonatomic, weak) UIView *currentSelectedView;
@property(nonatomic, copy) void (^chooseBlock)(NSArray *chooseSubViews);

@end

@implementation SZChooseSubViews

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addPanGesture];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addPanGesture];
    }
    return self;
}

- (void)addPanGesture {
    // 拖动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    panGesture.delegate = self;
    [self addGestureRecognizer:panGesture];
    
    // 点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)panAction:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.currentSelectedView = nil;
    }
    
    CGPoint point = [gestureRecognizer locationInView:self];
    
    for (UIView *subView in self.subviews) {
        CGFloat subMinX = subView.frame.origin.x;
        CGFloat subMinY = subView.frame.origin.y;
        CGFloat subMaxX = CGRectGetMaxX(subView.frame);
        CGFloat subMaxY = CGRectGetMaxY(subView.frame);
        if (subMinX < point.x && subMinY < point.y && subMaxX > point.x && subMaxY > point.y) {
            if ([self.choosedSubViews containsObject:subView]) {
                if (![self.currentSelectedView isEqual:subView]) {
                    self.currentSelectedView = subView;
                    [self removeChooseSubView:subView];
                }
            } else {
                if (![self.currentSelectedView isEqual:subView]) {
                    self.currentSelectedView = subView;
                    [self addChooseSubView:subView];
                }
            }
        }
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        // 调用block，选中之后需要的时间
        if (self.chooseBlock) {
            self.chooseBlock(self.choosedSubViews);
        }
    }
}

- (void)tapAction:(UITapGestureRecognizer *)gestureRecognizer {
    self.currentSelectedView = nil;
    [self panAction:gestureRecognizer];
}

- (void)chooseWithOriginSubViews:(NSArray *)subViews completionBlock:(void (^)(NSArray *chooseSubViews))chooseBlock{
    if (subViews != nil) {
        [subViews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addSubview:subView];
        }];
    }
    self.chooseBlock = chooseBlock;
}

- (void)addChooseSubView:(UIView *)subView {
    [self.choosedSubViews addObject:subView];
    SZMaskView *maskView = [[SZMaskView alloc] initWithFrame:subView.bounds];
    [subView addSubview:maskView];
}

- (void)removeChooseSubView:(UIView *)subView {
    [self.choosedSubViews removeObject:subView];
    for (UIView *szView in subView.subviews) {
        if ([szView isKindOfClass:[SZMaskView class]]) {
            [szView removeFromSuperview];
        }
    }
}


#pragma mark - UIGestureRecoginzerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - Getter and Setter
- (NSMutableArray *)choosedSubViews {
    if (_choosedSubViews == nil) {
        _choosedSubViews = [NSMutableArray array];
    }
    return _choosedSubViews;
}


@end
