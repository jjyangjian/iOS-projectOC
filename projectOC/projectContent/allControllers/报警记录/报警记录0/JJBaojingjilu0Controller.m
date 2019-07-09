//
//  JJBaojingjilu0Controller.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/10.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJBaojingjilu0Controller.h"

#import "JJBaojingjilu0Cell.h"

#import "JJYear_month_dayDatePicker.h"

@interface JJBaojingjilu0Controller ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)NSArray *dataArray;

@property (nonatomic)int page;
@property (nonatomic)int maxPage;
@property (nonatomic,strong)JJYear_month_dayDatePicker *datePicker;


@end

@implementation JJBaojingjilu0Controller

static NSString *cellName = @"JJBaojingjilu0Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.page = 1;
    self.maxPage = 0;

    [self createTableView];

    self.startDate = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970] - 86400];
    self.endDate = [NSDate date];
    
//    [self.startTimeButton setTitle:[JJDate getTimeTimeStringWithTimestampString:[NSString stringWithFormat:@"%ld",(long)[self.startDate timeIntervalSince1970]] andFormatString:@"yyyy-MM-dd"] forState:UIControlStateNormal];
//
//    [self.endTimeButton setTitle:[JJDate getTimeTimeStringWithTimestampString:[NSString stringWithFormat:@"%ld",(long)[self.endDate timeIntervalSince1970]] andFormatString:@"yyyy-MM-dd"] forState:UIControlStateNormal];

    self.currentStartTimeString = self.startTimeButton.currentTitle;
    self.currentEndTimeString = self.endTimeButton.currentTitle;

    
    [self queryDataWithPage:self.page];

}



- (void)updateData {

}

- (void)detailWithTime:(NSString *)time;
{
    self.page = 1;
    self.maxPage = 0;

    self.startDate =
    [NSDate dateWithTimeIntervalSince1970:[JJDate getTimestampStringWithTimeString:time andFormatString:@"yyyy-MM-dd"]];
    self.endDate =
    [NSDate dateWithTimeIntervalSince1970:[JJDate getTimestampStringWithTimeString:time andFormatString:@"yyyy-MM-dd"]];
    
//    [self.startTimeButton setTitle:[JJDate getTimeTimeStringWithTimestampString:[NSString stringWithFormat:@"%ld",(long)[self.startDate timeIntervalSince1970]] andFormatString:@"yyyy-MM-dd"] forState:UIControlStateNormal];
//
//    [self.endTimeButton setTitle:[JJDate getTimeTimeStringWithTimestampString:[NSString stringWithFormat:@"%ld",(long)[self.endDate timeIntervalSince1970]] andFormatString:@"yyyy-MM-dd"] forState:UIControlStateNormal];
    
    self.currentStartTimeString = self.startTimeButton.currentTitle;
    self.currentEndTimeString = self.endTimeButton.currentTitle;
    
    [self queryDataWithPage:self.page];

}

- (void)createTableView{
    [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellName];
}


#pragma tableViewDelegateAndDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 66;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //    if (section == 0) {
    //        return 0.f;
    //    }else if (section == 1){
    //        return 5.f;
    //    }else{
    //    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJBaojingjilu0Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    cell.label0.text = self.dataArray[indexPath.row][@"addtime"];
    cell.label1.text = [NSString stringWithFormat:@"%@(%@)",self.dataArray[indexPath.row][@"alarmname"],self.dataArray[indexPath.row][@"alarmitem"]];
    cell.label2.text = JJSTRING(self.dataArray[indexPath.row][@"alarmdata"]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    
//    if (indexPath.row == 3) {
//        UIViewController *controller = [[UIViewController alloc] init];
//        controller.hidesBottomBarWhenPushed = 1;
//        [self.navigationController pushViewController:controller animated:1];
//        controller.view.backgroundColor = [UIColor orangeColor];
//        return;
//    }
    
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

- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 100) {
        self.page = 1;
        
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

- (void)setStartDate:(NSDate *)startDate{
    _startDate = startDate;
    [self.startTimeButton setTitle:[JJDate getTimeTimeStringWithTimestampString:[NSString stringWithFormat:@"%ld",(long)[startDate timeIntervalSince1970]] andFormatString:@"yyyy-MM-dd"] forState:UIControlStateNormal];
}

- (void)setEndDate:(NSDate *)endDate{
    _endDate = endDate;
    [self.endTimeButton setTitle:[JJDate getTimeTimeStringWithTimestampString:[NSString stringWithFormat:@"%ld",(long)[endDate timeIntervalSince1970]] andFormatString:@"yyyy-MM-dd"] forState:UIControlStateNormal];
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
                                @"historyDataType":@"2",
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
                   
                   weakself.dataArray =responseObject[@"content"][@"rows"];
                   [weakself.tableView reloadData];
                   
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   [weakself hideHud];
                   [weakself showHint:error.domain];
                   NSLog(@"%@",error);
               }];
}






@end
