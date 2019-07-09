//
//  JJYear_month_dayDatePicker.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/17.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJYear_month_dayDatePicker.h"

@implementation JJYear_month_dayDatePicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
static CGFloat scale = 1.3;

- (instancetype)initWithBlock:(JJYear_month_dayDatePickerBlock)block
{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
    self.block = block;
    
//    self.datePicker.minimumDate = 0;
    self.datePicker.maximumDate = [NSDate date];
    
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.contentView.transform = CGAffineTransformMakeScale(scale , scale);
    self.contentView.alpha = 0.1f;
    return self;
}

- (void)setMaxDate:(NSDate *)maxDate{
    self.datePicker.maximumDate = maxDate;
}

- (void)setMinDate:(NSDate *)minDate{
    self.datePicker.minimumDate = minDate;
}

- (void)show;
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.contentView.alpha = 1.f;
        self.backgroundButton.alpha = 0.5f;
    } completion:^(BOOL finished) {
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(scale , scale);
        self.contentView.alpha = 0.1f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 100) {
        [self hide];
    }else if (sender.tag == 101) {
        self.block(self.datePicker.date);
        [self hide];
    }else{
    }
}

- (void)dealloc
{
    
}






@end
