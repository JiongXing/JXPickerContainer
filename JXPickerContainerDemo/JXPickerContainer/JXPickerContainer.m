//
//  JXPickerContainer.m
//  JXPickerContainerDemo
//
//  Created by JiongXing on 16/8/22.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

#import "JXPickerContainer.h"

@implementation JXPickerContainer

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bgView];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.barView];
        [self.barView addSubview:self.leftButton];
        [self.barView addSubview:self.rightButton];
        [self.barView addSubview:self.barTopLine];
        [self.barView addSubview:self.barBottomLine];
        [self.contentView addSubview:self.pickerView];
        
        self.barHeight = 84 / 2;
        self.pickerHeight = 530 / 2;
        self.buttonMargin = 24 / 2;
        self.bgAlpha = 0.3;
    }
    return self;
}

#pragma mark - View
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = self.bgAlpha;
        
        _bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBgViewTouch)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIView *)barView {
    if (!_barView) {
        _barView = [[UIView alloc] init];
        _barView.backgroundColor = [UIColor whiteColor];
    }
    return _barView;
}

- (UIView *)barTopLine {
    if (!_barTopLine) {
        _barTopLine = [[UIView alloc] init];
        _barTopLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _barTopLine;
}

- (UIView *)barBottomLine {
    if (!_barBottomLine) {
        _barBottomLine = [[UIView alloc] init];
        _barBottomLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _barBottomLine;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [self generateButtonWithTitle:@"取消"];
        [_leftButton addTarget:self action:@selector(onLeftButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [self generateButtonWithTitle:@"完成"];
        [_rightButton addTarget:self action:@selector(onRightButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIButton *)generateButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:32 / 2];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    return button;
}

#pragma mark - Action
- (void)onBgViewTouch {
    [self hide];
}

- (BOOL)isShowing {
    return CGRectGetMinY(self.contentView.frame) < CGRectGetHeight(self.frame);
}

- (void)showInView:(UIView *)view {
    self.frame =  view.bounds;
    [view addSubview:self];
    [self reLayout];
    
    CGRect contentFrame = self.contentView.frame;
    contentFrame.origin.y = CGRectGetHeight(self.frame);
    self.contentView.frame = contentFrame;
    self.bgView.alpha = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.contentView.frame;
        frame.origin.y = CGRectGetHeight(self.frame) - (self.barHeight + self.pickerHeight);
        self.contentView.frame = frame;
        
        self.bgView.alpha = self.bgAlpha;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect contentFrame = self.contentView.frame;
        contentFrame.origin.y = CGRectGetHeight(self.frame);
        self.contentView.frame = contentFrame;
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)reLayout {
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    self.bgView.frame = self.bounds;
    
    CGFloat contentHeight = self.barHeight + self.pickerHeight;
    self.contentView.frame = CGRectMake(0, height - contentHeight, width, contentHeight);
    
    self.barView.frame = CGRectMake(0, 0, width, self.barHeight);
    
    [self.leftButton sizeToFit];
    CGFloat leftButtonWidth = CGRectGetWidth(self.leftButton.frame) + self.buttonMargin * 2;
    self.leftButton.frame = CGRectMake(0, 0, leftButtonWidth, self.barHeight);
    
    [self.rightButton sizeToFit];
    CGFloat rightButtonWidth = CGRectGetWidth(self.rightButton.frame) + self.buttonMargin * 2;
    self.rightButton.frame = CGRectMake(width - rightButtonWidth, 0, rightButtonWidth, self.barHeight);
    
    self.barTopLine.frame = CGRectMake(0, 0, width, 0.5);
    self.barBottomLine.frame = CGRectMake(0, self.barHeight - 0.5, width, 0.5);
    
    self.pickerView.frame = CGRectMake(self.pickerMargin, self.barHeight, width - self.pickerMargin * 2, self.pickerHeight);
    [self.pickerView setNeedsLayout];
    [self.pickerView setNeedsDisplay];
}

#pragma mark - Action
- (void)onLeftButton {
    [self hide];
    if (self.actionOnLeftButton) {
        self.actionOnLeftButton(self);
    }
}

- (void)onRightButton {
    [self hide];
    if (self.actionOnRightButton) {
        self.actionOnRightButton(self);
    }
}

#pragma mark - Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 0;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return nil;
}


@end
