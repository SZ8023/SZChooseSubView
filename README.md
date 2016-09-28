### SZChooseSubView

可以选中添加到父视图中的任意子视图，支持多选，支持手势滑动选择！

![SZChooseSubView](https://github.com/SZ8023/SZChooseSubView/blob/master/screenshot/chooseSubView.gif)

### 该库的目的

开始写这个库的目的是为了解决日历当中选择日期的问题，比如说可以单选一个日期，可以选择多个日期，支持滑动选择多个日期。由于不清楚需要开发哪些接口，是否需要对应的数据模型，所以只是简单的写了一下。

### 使用方式

使用方式也比较简单，你只需要传入需要选中的视图控件。

```objc
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
```


### 补充说明

* 由于选中的视图只是在原来视图的基础上添加了一层遮罩，所以暴露出来的属性`choosedSubViews`中的子视图已经被添加上了遮罩视图。
* 如果通过方法`- (void)chooseWithOriginSubViews:(NSArray *)subViews completionBlock:(void (^)(NSArray *chooseSubViews))chooseBlock`来添加子视图，那么添加之前子视图的frame必须确定。
* 你也可以通过`addSubview`方法来添加视图。
