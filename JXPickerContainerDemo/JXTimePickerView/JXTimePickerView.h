//
//  JXTimePickerView.h
//  JXPickerContainerDemo
//
//  Created by JiongXing on 16/8/22.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

#import "JXPickerContainer.h"
#import "JXTimePickerViewModel.h"

@interface JXTimePickerView : JXPickerContainer

@property (nonatomic, copy) NSArray<JXTimePickerViewModel *> *yearArray;

/// 点完成
@property (nonatomic, copy) void (^actionOnFinish)(NSInteger year, NSInteger month);

- (void)fetchSelectedData:(void (^)(JXTimePickerViewModel *yearModel, JXTimePickerViewModel *monthModel))dataBlock;

@end
