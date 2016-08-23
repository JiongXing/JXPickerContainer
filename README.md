# JXPickerContainer
- 一个常见的选择器/时间选择器

![JXTimePicker](http://github.com/JiongXing/JXPickerContainer/raw/master/screenshot/JXPickerContainer.gif)
- 简单用法

```objc
#import "JXTimePickerView.h"

@interface ViewController ()

@property (nonatomic, strong) JXTimePickerView *picker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onRightItem)];
    
    self.picker = [[JXTimePickerView alloc] init];
    self.picker.yearArray = [self generateYearArray];
}

- (void)onRightItem {
    if (self.picker.isShowing) {
        [self.picker hide];
    }
    else {
        UIWindow *keyWin = [UIApplication sharedApplication].keyWindow;
        [self.picker showInView:keyWin];
    }
}

- (NSArray<JXTimePickerViewModel *> *)generateYearArray {
    NSMutableArray *array = [NSMutableArray array];
    JXTimePickerViewModel *year2015 = [self generateModelWithTitle:@"2015年" modelArray:[self generateMonthArrayFrom:6 to:12]];
    [array addObject:year2015];
    JXTimePickerViewModel *year2016 = [self generateModelWithTitle:@"2016年" modelArray:[self generateMonthArrayFrom:1 to:8]];
    [array addObject:year2016];
    return array;
}

- (NSArray<JXTimePickerViewModel *> *)generateMonthArrayFrom:(NSInteger)from to:(NSInteger)to {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger index = from; index <= to; index ++) {
        JXTimePickerViewModel *model = [self generateModelWithTitle:[NSString stringWithFormat:@"%@月", @(index)] modelArray:nil];
        [array addObject:model];
    }
    return array;
}

- (JXTimePickerViewModel *)generateModelWithTitle:(NSString *)title modelArray:(NSArray *)modelArray {
    JXTimePickerViewModel *model = [[JXTimePickerViewModel alloc] init];
    model.title = title;
    model.modelArray = modelArray;
    return model;
}

@end
```
