//
//  JJLishijiluController.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/12.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJLishijiluController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label0;

@property (weak, nonatomic) IBOutlet UIButton *topButton0;
@property (weak, nonatomic) IBOutlet UIButton *topButton1;
@property (weak, nonatomic) IBOutlet UIView *contentView;


@property (weak, nonatomic) IBOutlet UIButton *startTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *endTimeButton;
@property (strong, nonatomic) NSString *currentStartTimeString;
@property (strong, nonatomic) NSString *currentEndTimeString;

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
//@property (strong, nonatomic) NSDate *currentStartDate;
//@property (strong, nonatomic) NSDate *currentEndDate;



@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;






- (instancetype)initWithTitleInfoArray:(NSArray *)titleInfoArray;


@end

NS_ASSUME_NONNULL_END
