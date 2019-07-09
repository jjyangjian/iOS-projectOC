//
//  JJYear_month_dayDatePicker.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/17.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJYear_month_dayDatePicker : UIView



typedef void(^JJYear_month_dayDatePickerBlock)(NSDate *date);

@property (strong, nonatomic) JJYear_month_dayDatePickerBlock block;


@property (nonatomic,strong)NSDate * _Nullable maxDate;
@property (nonatomic,strong)NSDate * _Nullable minDate;


@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *backgroundButton;




- (instancetype)initWithBlock:(JJYear_month_dayDatePickerBlock)block;

- (void)show;




@end

NS_ASSUME_NONNULL_END
