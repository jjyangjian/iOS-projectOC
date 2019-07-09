//
//  JJDateDataManager.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/10.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJBaojingjilu1DateDataManager.h"

@interface JJBaojingjilu1DateDataManager ()

@property (nonatomic,strong)JJDateDataManagerGetDataCompletion completion;


@property (nonatomic)NSTimeInterval timestamp;
@property (nonatomic,strong)NSDate *date;

@property (nonatomic)NSInteger year;//年
@property (nonatomic)NSInteger month;//月
@property (nonatomic)NSInteger day;//日
@property (nonatomic)NSInteger weekDayFromFirstDayOfMonth;//当月第一天是周几
@property (nonatomic)NSInteger daysOfMonth;//当月有几天

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)NSString *deviceID;


@end

@implementation JJBaojingjilu1DateDataManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray new];
    }
    return self;
}

- (void)getDataWithNian:(NSString *)nian andYue:(NSString *)yue  andCompletion:(JJDateDataManagerGetDataCompletion)completion;
{
    
}

- (void)getDataWithDeviceID:(NSString *)deviceID
            TimestampString:(NSString *)timestampString
              Completion:(JJDateDataManagerGetDataCompletion)completion;
{
    self.deviceID = deviceID;
//    timestampString = @"1554952802";
    self.timestamp = [timestampString longLongValue];
    self.date = [NSDate dateWithTimeIntervalSince1970:self.timestamp];
    self.completion = completion;

    //1.将日历的数据取来.
    [self makeCalendar];
    
    //2.往data内填补空缺部分.
    [self addNilData];
    
    //3.获取数据
    [self addData];
}

- (void)makeCalendar{

    self.year = [JJDate calendar_yearFromDate:self.date];
    self.month = [JJDate calendar_monthFromDate:self.date];
    self.day = [JJDate calendar_dayFromDate:self.date];
    self.weekDayFromFirstDayOfMonth = [JJDate calendar_weekdayOfMonthFromDate:self.date];
    if (self.weekDayFromFirstDayOfMonth == 0) {
        self.weekDayFromFirstDayOfMonth = 7;
    }
    self.daysOfMonth = [JJDate calendar_totalDaysOfMonthFromDate:self.date];
    NSLog(@"年:%ld,月:%ld,周几打头:%ld",self.year,self.month,self.weekDayFromFirstDayOfMonth);//第一天从周几?
}

//填补空缺
- (void)addNilData{
    [self.dataArray removeAllObjects];
    for (int i = 1; i < self.weekDayFromFirstDayOfMonth; i ++) {
        NSDictionary *dic = @{
                              @"empty":@"1",
                              };
        [self.dataArray addObject:dic];
    }
}

- (void)addData{
    JJWEAKSELF
    [JJDownload getData_Method:@"GET"
                  andURLString:
     JJURLSTRING_api_alarm_report_month_(self.deviceID,([NSString stringWithFormat:@"%ld-%ld",(long)self.year,self.month]))
                  andParameter:nil
                  andNeedToken:1
               andSuccessBlock: ^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
                   NSArray *arr = responseObject[@"content"][@"data"];
                   for (int i = 0; i < [arr count]; i ++) {
                       [weakself.dataArray addObject:
                        @{@"day":[NSString stringWithFormat:@"%d",i + 1],
                          @"time":arr[i][0],
                          @"state":arr[i][1],
                          @"count":arr[i][2],
                          @"empty":@"0",
                          }];
                   }

                   weakself.completion(responseObject[@"content"][@"title"],self.dataArray,nil,message);
                   NSLog(@"%@",responseObject);
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   weakself.completion(nil,nil,error,error.domain);
               }];
}

@end
