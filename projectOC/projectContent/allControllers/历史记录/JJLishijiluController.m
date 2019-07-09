//
//  JJLishijiluController.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/12.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJLishijiluController.h"

#import "JJLishijilu0Controller.h"
#import "JJLishijilu1Controller.h"

#import "JJYear_month_dayDatePicker.h"

@interface JJLishijiluController ()

@property (nonatomic,strong)JJLishijilu0Controller *subController0;
@property (nonatomic,strong)JJLishijilu1Controller *subController1;

@property (nonatomic)long currentIndex;
@property (nonatomic,weak)UIViewController *currentSubController;


@property (nonatomic,strong)NSArray *titleInfoArray;
@property (nonatomic,strong)NSArray *dataArray;

@property (nonatomic)int page;

@property (nonatomic)int maxPage;

@property (nonatomic,strong)JJYear_month_dayDatePicker *datePicker;

@end

@implementation JJLishijiluController

- (instancetype)initWithTitleInfoArray:(NSArray *)titleInfoArray
{
    self = [super init];
    if (self) {
        self.titleInfoArray = titleInfoArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"历史记录";

    self.view.backgroundColor = JJCOLOR_BAISE;
    self.label0.text = [JJExtern sharedJJ].currentDevice[@"eqName"];

    self.page = 1;
    self.maxPage = 0;

    self.startDate = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970] - 86400];
    self.endDate = [NSDate date];
    
    [self.startTimeButton setTitle:[JJDate getTimeTimeStringWithTimestampString:[NSString stringWithFormat:@"%ld",(long)[self.startDate timeIntervalSince1970]] andFormatString:@"yyyy-MM-dd"] forState:UIControlStateNormal];
    
    [self.endTimeButton setTitle:[JJDate getTimeTimeStringWithTimestampString:[NSString stringWithFormat:@"%ld",(long)[self.endDate timeIntervalSince1970]] andFormatString:@"yyyy-MM-dd"] forState:UIControlStateNormal];
    
    self.currentStartTimeString = self.startTimeButton.currentTitle;
    self.currentEndTimeString = self.endTimeButton.currentTitle;
    
    //    [self createFakeNavigationBar];
    
    if (! self.titleInfoArray.count) {
        NSDictionary *parameter = @{
                                    @"historyDataType":@"1",
                                    @"eqId":[JJExtern sharedJJ].currentDeviceID,
                                    };
        JJWEAKSELF
        [self showHudInView:self.view hint:@""];
        [JJDownload getData_Method:@"GET"
                      andURLString:JJURLSTRING_api_history_data_list_title
                      andParameter:parameter
                      andNeedToken:1
                   andSuccessBlock: ^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
                       [weakself hideHud];
                       [weakself showHint:message];
                       NSLog(@"%@",responseObject);
                       weakself.titleInfoArray = responseObject[@"content"];
                       
                       [weakself createSubViewControllers];
                       [weakself queryDataWithPage:weakself.page];
                       
                   } andFailureBlock: ^(NSError * _Nonnull error) {
                       [weakself hideHud];
                       [weakself showHint:error.domain];
                       NSLog(@"%@",error);
                   }];
    }else{
        [self createSubViewControllers];
        [self queryDataWithPage:self.page];
    }

    
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    //bug 手动控制生命周期,回头再调
    //https://www.jianshu.com/p/2148f9cfa010
    //https://www.jianshu.com/p/ba687e682816
    //    [_childvc1 beginAppearanceTransition:1 animated:1];
    //    [_childvc1 endAppearanceTransition];
    return 1;
}

- (void)createSubViewControllers{
    
    //    CGFloat height = SIZE.height - (IPHONE_SAFEAREA_STATUSBAR_HEIGHT + 8 + 60) - IPHONE_SAFEAREA_EXTRA_BOTTOM_HEIGHT;
    
    
    self.subController0 = [[JJLishijilu0Controller alloc] initWithTitleInfoArray:self.titleInfoArray];
    //    self.subController0.view.frame = CGRectMake(0, 0, SIZE.width, height);
    [self addChildViewController:self.subController0];
    
    self.subController1 = [[JJLishijilu1Controller alloc] initWithTitleInfoArray:self.titleInfoArray];
    //    self.subController1.view.frame = self.contentView.bounds;
    [self addChildViewController:self.subController1];
    
    self.subController0.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.subController0.view];
    self.currentIndex = 0;
    self.currentSubController = self.subController0;
    
}

- (IBAction)topButtonClick:(UIButton *)topButton{
    if (topButton.selected) {
        return;
    }
    JJWEAKSELF;
    [self switchSubControllerToIndex:topButton.tag - 100 andCompletion:^(BOOL finished) {
        if (finished) {
            weakself.topButton0.selected = 0;
            weakself.topButton1.selected = 0;
            topButton.selected = 1;
        }
    }];
}

- (IBAction)segmentClick:(UISegmentedControl *)sender {
    
    //    JJWEAKSELF;
    [self switchSubControllerToIndex:sender.selectedSegmentIndex andCompletion:^(BOOL finished) {
        if (finished) {
            //            weakself.topButton0.selected = 0;
            //            weakself.topButton1.selected = 0;
            //            topButton.selected = 1;
        }
    }];
}




- (void)switchSubControllerToIndex:(long)index andCompletion:(void(^)(BOOL finished))completion{
    if (index == self.currentIndex) {
        return;
    }
    __weak typeof(self) weakself = self;
    
    self.childViewControllers[index].view.frame = self.contentView.bounds;
    
    [self transitionFromViewController:self.currentSubController toViewController:self.childViewControllers[index] duration:0.f options:UIViewAnimationOptionTransitionNone animations:^{} completion:^(BOOL finished) {
        completion(finished);
        if (finished) {
            weakself.currentIndex = index;
            weakself.currentSubController = self.childViewControllers[weakself.currentIndex];
        }
    }];
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.subController0 updateDataWithArray:dataArray];
    [self.subController1 updateDataWithArray:dataArray];
}

- (void)setPage:(int)page{
    _page = page;
    if (page <= 1) {
        self.lastButton.enabled = 0;
    }else{
        self.lastButton.enabled = 1;
    }
    if (page >= self.maxPage) {
        self.nextButton.enabled = 0;
    }else{
        self.nextButton.enabled = 1;
    }
    self.pageLabel.text = [NSString stringWithFormat:@"%d/%d页",self.page,self.maxPage];
}

- (void)setMaxPage:(int)maxPage{
    _maxPage = maxPage;
    if (self.page >= maxPage) {
        self.nextButton.enabled = 0;
    }else{
        self.nextButton.enabled = 1;
    }
    self.pageLabel.text = [NSString stringWithFormat:@"%d/%d页",self.page,self.maxPage];
}

- (void)setStartDate:(NSDate *)startDate{
    _startDate = startDate;
    [self.startTimeButton setTitle:[JJDate getTimeTimeStringWithTimestampString:[NSString stringWithFormat:@"%ld",(long)[startDate timeIntervalSince1970]] andFormatString:@"yyyy-MM-dd"] forState:UIControlStateNormal];
}

- (void)setEndDate:(NSDate *)endDate{
    _endDate = endDate;
    [self.endTimeButton setTitle:[JJDate getTimeTimeStringWithTimestampString:[NSString stringWithFormat:@"%ld",(long)[endDate timeIntervalSince1970]] andFormatString:@"yyyy-MM-dd"] forState:UIControlStateNormal];
}


- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 100) {
        self.page = 1;
//        self.currentStartDate = self.startDate;
//        self.currentEndDate = self.endDate;
        
        self.currentStartTimeString = self.startTimeButton.currentTitle;
        self.currentEndTimeString = self.endTimeButton.currentTitle;
        
        [self queryDataWithPage:self.page];

    }else if (sender.tag == 101) {
        if (!self.datePicker) {
            self.datePicker = [[JJYear_month_dayDatePicker alloc] initWithBlock:^(NSDate * _Nonnull date) {
            }];
        }
        JJWEAKSELF
        self.datePicker.block = ^(NSDate * _Nonnull date) {
            weakself.startDate = date;
        };
        self.datePicker.minDate = nil;
        self.datePicker.maxDate = self.endDate;
        [self.datePicker show];
        
    }else if (sender.tag == 102) {
        if (!self.datePicker) {
            self.datePicker = [[JJYear_month_dayDatePicker alloc] initWithBlock:^(NSDate * _Nonnull date) {
            }];
        }
        JJWEAKSELF
        self.datePicker.block = ^(NSDate * _Nonnull date) {
            weakself.endDate = date;
        };
        self.datePicker.minDate = self.startDate;
        self.datePicker.maxDate = [NSDate date];
        [self.datePicker show];
        
    }else if (sender.tag == 111) {
        self.page -= 1;
        [self queryDataWithPage:self.page];
    }else if (sender.tag == 112) {
        self.page += 1;
        [self queryDataWithPage:self.page];
    }else{
        
    }
}



- (void)queryDataWithPage:(int)page{
    //    "username":"zyf3","password":"123"
    
//    {
//        "eqId":"300000",
//        "historyDataType":"1",
//        "beginTime":"2019-04-17",
//        "endTime":"2019-04-17",
//        "pageSize":15,"pageNum":1,
//        "orderByColumn":"addTime",
//        "isAsc":"desc"
//    }
    
    
    NSDictionary *parameter = @{
                                @"historyDataType":@"1",
                                @"eqId":[JJExtern sharedJJ].currentDeviceID,
                                @"beginTime":self.currentStartTimeString,
                                @"endTime":self.currentEndTimeString,
                                @"pageSize":@"50",
                                @"pageNum":[NSString stringWithFormat:@"%d",page],
                                @"orderByColumn":@"addTime",
                                @"isAsc":@"desc"
                                };
//    NSURL *url = [NSURL
//                  URLWithString:[JJURLSTRING_api_history_data_list                                 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet
// URLFragmentAllowedCharacterSet]]];
    JJWEAKSELF
    [self showHudInView:self.view hint:@""];
    [JJDownload getData_Method:@"POST"
                  andURLString:JJURLSTRING_api_history_data_list
                       andBody:parameter
                  andNeedToken:1
               andSuccessBlock: ^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
                   [weakself hideHud];
                   [weakself showHint:message];
                   NSLog(@"%@",responseObject);
                   
                   weakself.maxPage = [responseObject[@"content"][@"pageSize"] intValue];
                   
                   weakself.dataArray = responseObject[@"content"][@"rows"];
                   
//                   JJLishijiluController *controller = [[JJLishijiluController alloc] initWithTitleInfoArray:responseObject[@"content"]];
//                   [self.navigationController pushViewController:controller animated:1];
                   
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   [weakself hideHud];
                   [weakself showHint:error.domain];
                   NSLog(@"%@",error);
               }];
}



@end





