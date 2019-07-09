//
//  JJTongji1Cell.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/13.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJTongji1Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label0;

- (void)setChartInfoWithMinValue:(CGFloat)minValue MaxValue:(CGFloat)maxValue Unit:(NSString *)unit;

- (void)updateDataWithValueArray:(NSArray *)valueArray;



@end

NS_ASSUME_NONNULL_END
