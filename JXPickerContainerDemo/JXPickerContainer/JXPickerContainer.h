//
//  JXPickerContainer.h
//  JXPickerContainerDemo
//
//  Created by JiongXing on 16/8/22.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXPickerContainer : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *barView; // 取消和完成按钮所在的bar
@property (nonatomic, strong) UIView *barTopLine;
@property (nonatomic, strong) UIView *barBottomLine;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIPickerView *pickerView;

// UI
@property (nonatomic, assign) CGFloat buttonMargin;
@property (nonatomic, assign) CGFloat barHeight;
@property (nonatomic, assign) CGFloat pickerHeight;
@property (nonatomic, assign) CGFloat bgAlpha;
@property (nonatomic, assign) CGFloat pickerMargin;

/// 是否正显示
@property (nonatomic, assign, readonly) BOOL isShowing;

/// 点击左按钮
@property (nonatomic, copy) void (^actionOnLeftButton)(JXPickerContainer *__weak picker);
/// 点击右按钮
@property (nonatomic, copy) void (^actionOnRightButton)(JXPickerContainer *__weak picker);

- (void)showInView:(UIView *)view;

- (void)hide;

- (void)onLeftButton;

- (void)onRightButton;

@end
