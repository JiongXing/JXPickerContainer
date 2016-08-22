//
//  JXTimePickerViewModel.h
//  JXPickerContainerDemo
//
//  Created by JiongXing on 16/8/22.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXTimePickerViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) NSArray<JXTimePickerViewModel *> *modelArray;

@end
