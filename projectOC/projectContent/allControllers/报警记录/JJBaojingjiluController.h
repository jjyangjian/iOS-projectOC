//
//  JJBaojingjiluController.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/10.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJBaojingjiluController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label0;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (weak, nonatomic) IBOutlet UIButton *topButton0;
@property (weak, nonatomic) IBOutlet UIButton *topButton1;
@property (weak, nonatomic) IBOutlet UIView *contentView;


- (instancetype)initWithTitleInfoArray:(NSArray *)titleInfoArray;

@end

NS_ASSUME_NONNULL_END
