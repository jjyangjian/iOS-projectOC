//
//  JJLishijilu0Cell.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/13.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJLishijilu0Cell.h"

@interface JJLishijilu0Cell ()

@property (nonatomic,strong)NSMutableArray <UILabel *>*labelsArr;

@end

@implementation JJLishijilu0Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.labelsArr = [[NSMutableArray alloc] init];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)xaddLabels:(NSArray <UILabel *>*)labels;
{
    if (self.labelsArr.count) {
        for (int i = 0; i < self.labelsArr.count; i ++) {
            [self.labelsArr[i] removeFromSuperview];
        }
        [self.labelsArr removeAllObjects];
    }
    [self.labelsArr addObjectsFromArray:labels];
    for (int i = 0; i < self.labelsArr.count; i ++) {
//        [self.stackView addSubview:self.labelsArr[i]];
        if (i == 0) {
            self.labelsArr[i].frame = CGRectMake(0, 0, 100, 0 );
        }else{
            self.labelsArr[i].frame = CGRectMake(0, 0, (SIZE.width - 100) / (labels.count - 1), 50 );
        }
        [self.stackView insertArrangedSubview:self.labelsArr[i] atIndex:i];
    }
}

- (void)addLabels:(NSArray <UILabel *>*)labels;
{
    if (self.labelsArr.count) {
        for (int i = 0; i < self.labelsArr.count; i ++) {
            [self.labelsArr[i] removeFromSuperview];
        }
        [self.labelsArr removeAllObjects];
    }
    [self.labelsArr addObjectsFromArray:labels];
    for (int i = 0; i < self.labelsArr.count; i ++) {
        //        [self.stackView addSubview:self.labelsArr[i]];
        if (i == 0) {
            self.labelsArr[i].frame = CGRectMake(0, 0, 80, 50);
        }else{
            self.labelsArr[i].frame = CGRectMake(80 + (i - 1) * ((SIZE.width - 80) / (labels.count - 1)), 0, (SIZE.width - 100) / (labels.count - 1), 50 );
        }
        [self addSubview:self.labelsArr[i]];
    }
}

@end
