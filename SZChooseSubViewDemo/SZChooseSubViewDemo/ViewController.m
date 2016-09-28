//
//  ViewController.m
//  SZChooseSubViewDemo
//
//  Created by styshy on 16/9/28.
//  Copyright © 2016年 styshy. All rights reserved.
//

#import "ViewController.h"
#import "SZChooseSubViews.h"

@interface ViewController ()

@property(nonatomic, strong) SZChooseSubViews *chooseView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    SZChooseSubViews *chooseView = [[SZChooseSubViews alloc] initWithFrame:self.view.bounds];
    chooseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:chooseView];
    self.chooseView = chooseView;
    
    // 添加子视图
    CGFloat appW = 100;
    CGFloat appH = 60;
    // 第一行的View距离顶部的距离
    CGFloat marginTop = 80;
    
    // 每一行上应用的个数
    int columns = 3;
    
    // marginX = (屏幕的宽度 - appW * columns) / (cllumns + 1)
    CGFloat marginX = (self.view.frame.size.width - appW * columns) / (columns + 1);
    CGFloat marginY = marginX;
    
    for (int i = 0; i < 21; i++) {
        
        UILabel *oneView = [[UILabel alloc] init];
        
        oneView.text = [NSString stringWithFormat:@"测试 %zd",i];
        
        // 计算每一个格子的行索引
        int row = i / columns;
        // 计算当前格子所在列的索引
        int col = i % columns;
        
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = marginTop + row * (appH + marginY);
        oneView.frame = CGRectMake(appX, appY, appW, appH);
        oneView.backgroundColor = [UIColor whiteColor];
        oneView.textAlignment = NSTextAlignmentCenter;
        [self.chooseView addSubview:oneView];
        
    }
    UILabel *testLBL = [[UILabel alloc] initWithFrame:CGRectMake(marginX, 30, CGRectGetWidth(self.view.bounds) - 2 * marginX, 40)];
    testLBL.text = @"http://sz8023.github.io";
    testLBL.backgroundColor = [UIColor whiteColor];
    testLBL.textAlignment = NSTextAlignmentCenter;
    
    // 可以一次性添加已经设置好坐标的子视图，或者分别一个个添加
    [self.chooseView chooseWithOriginSubViews:@[testLBL] completionBlock:^(NSArray *chooseSubViews) {
        NSString *message = [NSString stringWithFormat:@"你选中了 %zd 个子视图~_~",chooseSubViews.count];
        UIAlertController *logout = [UIAlertController alertControllerWithTitle:@"你确定注销？" message:message preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *destructive = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            return;
        }];
        [logout addAction:destructive];
        [logout addAction:cancel];
        [self presentViewController:logout animated:YES completion:nil];
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
