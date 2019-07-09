//
//  JJLishijilu0HeaderView.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/13.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJLishijilu0HeaderView.h"

@interface JJLishijilu0HeaderView ()

@property (nonatomic ,strong)NSArray <UILabel *>*labelArray;



@end


@implementation JJLishijilu0HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)xaddLabels:(NSArray <UILabel *>*)labels;
{
//    if (self.labelArray.count) {
//        for (UILabel *label in self.labelArray) {
//            [self.stackView removeArrangedSubview:label];
//        }
//    }
    
    for (int i = 0 ; i < labels.count; i ++) {
        UILabel *label = labels[i];
        
        [self.stackView insertArrangedSubview:label atIndex:i];
    }
    //    self.labelArray = labels;
    
}

- (void)addLabels:(NSArray <UILabel *>*)labels;
{
    for (int i = 0; i < labels.count; i ++) {
        //        [self.stackView addSubview:self.labelsArr[i]];
        if (i == 0) {
            labels[i].frame = CGRectMake(0, 0, 80, 40);
        }else{
            labels[i].frame = CGRectMake(80 + (i - 1) * ((SIZE.width - 80) / (labels.count - 1)), 0, (SIZE.width - 100) / (labels.count - 1), 40 );
        }
        [self addSubview:labels[i]];
    }
}



@end
