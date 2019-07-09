//
//  JJAnnotationDetailView.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/5/5.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJAnnotationDetailView.h"




static CGFloat scale = 1.3;

@implementation JJAnnotationDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithTitle:(NSString *)title
                         time:(NSString *)time
                   labelArray:(NSArray <UILabel *>*)labelArray
                        block:(JJButtonBlock)block;
{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
//    _labels = labelArray;
    self.label0.text = title;
    self.label1.text = time;
    self.buttonBlock = block;
    
    
    CGFloat labelWidth = (SIZE.width - 40.f) / 4;
    CGFloat labelHeight = 80.f;
    
    unsigned long allline = (labelArray.count / 4) + (labelArray.count % 4 ? 1 : 0);
    self.contentSpacingConstraint.constant = allline * labelHeight + 16.f;
    //8 + 30 + 8为y坐标0点
    //
    
    for (int index = 0; index < labelArray.count; index ++) {
        int column = index % 4;//列,对应x轴
        int line = index / 4;//行,对应y轴
        
        NSLog(@"%d-%d",column,line);
        
        labelArray[index].frame = CGRectMake(column * labelWidth,(8 + 30 + 8) + line * labelHeight, labelWidth, labelHeight);
        
        NSLog(@"%@",labelArray[index].text);
        NSLog(@"%@",NSStringFromCGRect(labelArray[index].frame));
        labelArray[index].layer.borderColor = UIColor.groupTableViewBackgroundColor.CGColor;
        labelArray[index].layer.borderWidth = 0.5f;
        [self.contentView addSubview:labelArray[index]];
    }
    
    
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.contentView.transform = CGAffineTransformMakeScale(scale , scale);
    self.contentView.alpha = 0.1f;

    return self;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.contentView.alpha = 1.f;
        self.backgroundButton.alpha = 0.5f;
    } completion:^(BOOL finished) {
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(scale , scale);
        self.contentView.alpha = 0.1f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)buttonClick:(UIButton *)sender {
    [self hide];
    if (sender.tag == 100) {
//        [self hide];
//    } else if (sender.tag == 101) {
//    } else if (sender.tag == 102) {
//    } else if (sender.tag == 103) {
//    } else if (sender.tag == 104) {
    }else{
        self.buttonBlock(sender.tag);
    }
}










@end
