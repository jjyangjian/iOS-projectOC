//
//  JJShebeiliebiaoCell.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/9.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJShebeiliebiaoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
//@property (weak, nonatomic) IBOutlet UILabel *label3;
//@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UIButton *button0;

@property (strong, nonatomic) JJButtonBlock buttonBlock;

- (void)loadDataWithDictionary:(NSDictionary *)dictionary;
- (void)loadDataWithDevice:(NSDictionary *)device buttonBlock:(JJButtonBlock)buttonBlock;


@end

NS_ASSUME_NONNULL_END
