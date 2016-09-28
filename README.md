### SZChooseSubView

可以选中添加到父视图中的任意子视图，支持多选，支持手势滑动选择！

![SZChooseSubView](https://github.com/SZ8023/SZChooseSubView/blob/master/screenshot/chooseSubView.gif)

### 设计目的

开始写这个库的目的是为了解决日历当中选择日期的问题，比如说可以单选一个日期，可以选择多个日期，支持滑动选择多个日期。由于不清楚需要开发哪些接口，是否需要对应的数据模型，所以只是简单的写了一下。

### 使用方式

使用方式也比较简单，你只需要传入需要选中的视图控件。

```objc
SZChooseSubViews *chooseView = [[SZChooseSubViews alloc] initWithFrame:self.view.bounds];
chooseView.backgroundColor = [UIColor whiteColor];
[self.view addSubview:chooseView];
self.chooseView = chooseView;
// 添加子视图，可以通过多种方式添加子视图
```


### 补充说明

* 由于选中的视图只是在原来视图的基础上添加了一层遮罩，所以暴露出来的属性`choosedSubViews`中的子视图已经被添加上了遮罩视图。
* 如果通过方法`- (void)chooseWithOriginSubViews:(NSArray *)subViews completionBlock:(void (^)(NSArray *chooseSubViews))chooseBlock`来添加子视图，那么添加之前子视图的frame必须确定。
* 你也可以通过`addSubview`方法来添加视图。
* 子视图可以是UIView或者其子类，如果是继承自UIButton，默认是接收UIButton的点击事件，如果需要使用本库中的点击选中或取消，可以通过`userInteractionEnabled`来设置。
