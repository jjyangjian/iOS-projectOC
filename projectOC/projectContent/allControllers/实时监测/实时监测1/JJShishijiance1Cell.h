//
//  JJShishijiance1Cell.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/11.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#define X_COUNT 10

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJShishijiance1Cell : UITableViewCell

@property (nonatomic,strong) NSString *cellid;

@property (weak, nonatomic) IBOutlet UILabel *label0;

- (void)setChartInfoWithMinValue:(CGFloat)minValue MaxValue:(CGFloat)maxValue Unit:(NSString *)unit;

- (void)updateDataWithDictionary:(NSDictionary *)dictionary;



@end

NS_ASSUME_NONNULL_END
