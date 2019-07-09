//
//  JJBaojingjilu0Controller.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/10.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJBaojingjilu0Controller : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *startTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *endTimeButton;

@property (strong, nonatomic) NSString *currentStartTimeString;
@property (strong, nonatomic) NSString *currentEndTimeString;


@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;



@property (weak, nonatomic) IBOutlet UITableView *tableView;




@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

- (void)detailWithTime:(NSString *)time;





@end

NS_ASSUME_NONNULL_END
