//
//  JJShishijianceController.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/11.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJShishijianceController.h"

#import "JJShishijiance0Controller.h"
#import "JJShishijiance1Controller.h"

#import "JJMQTTManager.h"

//#define SECONDS 1.f
#define SECONDS 1.f

@interface JJShishijianceController ()
<
JJMQTTManagerDelegate
>

@property (nonatomic,strong)JJMQTTManager *connectManager;

@property (nonatomic,strong)JJShishijiance0Controller *subController0;
@property (nonatomic,strong)JJShishijiance1Controller *subController1;

@property (nonatomic)long currentIndex;
@property (nonatomic,weak)UIViewController *currentSubController;




@property (nonatomic) dispatch_source_t timer;

@end

@implementation JJShishijianceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"实时监测";
    self.label0.text = [JJExtern sharedJJ].currentDevice[@"eqName"];
    self.view.backgroundColor = JJCOLOR_BAISE;
    
    
    [self createSubViewControllers];
    
    
        [self updateCurrentData];
 
//    [self ceshi];
    
}

- (void)dealloc
{

}



- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    if (self.timer) {
//        dispatch_source_cancel(self.timer);
//        self.timer = nil;
//    }
}


- (void)ceshi{
    
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0); //dispatch_get_main_queue();
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //通过start参数控制第一次执行的时间，DISPATCH_TIME_NOW表示立即执行(以后面参数为主) /后面表示第一次延迟时间,
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(SECONDS * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(SECONDS * NSEC_PER_SEC);
    
    dispatch_source_set_timer(self.timer, start, interval, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(self.timer, ^{
        //        NSLog(@"dispatch_source_set_timer start");
        //        NSLog(@"%d", count);
        dispatch_async(dispatch_get_main_queue(), ^{

//            CGFloat f = (arc4random()%1000) / 100.f;
            
            [self updateDataWithDictionary:@{
                                             @"data":
                                                 @[
                                                     @{
                                                         @"key":@"pH",
                                                         @"name":@"pH",
                                                         @"unit":@" ",
                                                         @"value":[NSString stringWithFormat:@"%.2f",(arc4random()%1000) / 100.f],
                                                         },
                                                     @{
                                                         @"key" : @"wendu",
                                                         @"name" : @"温度",
                                                         @"unit" : @"℃",
                                                         @"value" : [NSString stringWithFormat:@"%.2f",(arc4random()%1000) / 100.f],
                                                         },
                                                     ],
                                             @"time":[NSString stringWithFormat:@"%.0f",[JJDate getTimeNowTimestamp]],
                                             }];
        });
    });
    dispatch_resume(self.timer);
}

- (void)updateCurrentData{
    JJWEAKSELF
    [self showHudInView:self.view hint:@""];
    [JJDownload getData_Method:@"GET"
                  andURLString:
     JJURLSTRING_api_history_data_top_(([NSString stringWithFormat:@"%d",X_COUNT]), [JJExtern sharedJJ].currentDeviceID)
     
     //JJURLSTRING_api_report_peak_([JJExtern sharedJJ].currentDeviceID, self.startTimeButton.currentTitle, self.endTimeButton.currentTitle)
                       andBody:nil
                  andNeedToken:1
               andSuccessBlock: ^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
                   [weakself hideHud];
                   [weakself showHint:message];
//                   NSLog(@"%@",responseObject);
                   //                   weakself.maxPage = [responseObject[@"content"][@"pageSize"] intValue];
//                   weakself.dataDictionary =responseObject[@"content"];
                   NSArray *arr = responseObject[@"content"][@"data"];
                   
                   for (int i = 0; i < arr.count; i ++) {
                       NSMutableDictionary *mdic = [[NSMutableDictionary alloc] init];
                       
                       mdic[@"data"] = arr[i];
                       mdic[@"time"] = arr[arr.count - i - 1][0][@"time"];
                       NSLog(@"%@",mdic);
                       [weakself updateDataWithDictionary:mdic];
                   }

                   [weakself longConnect];
                   
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   [weakself hideHud];
                   [weakself showHint:error.domain];
                   NSLog(@"%@",error);
                   
               }];
}

- (void)longConnect{
    if (!self.connectManager) {
        self.connectManager = [[JJMQTTManager alloc] initWithDelegate:self];
    }
    [self showHudInView:self.view hint:@"连接中..."];
    
    [self.connectManager mqttConnect];
    
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
    
    
    self.subController0 = [[JJShishijiance0Controller alloc] init];
    //    self.subController0.view.frame = CGRectMake(0, 0, SIZE.width, height);
    [self addChildViewController:self.subController0];
    
    self.subController1 = [[JJShishijiance1Controller alloc] init];
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


- (void)updateDataWithDictionary:(NSDictionary *)dictionary{
//    self.label1.text = [NSString stringWithFormat:@"最近更新时间:%@",[JJDate getTimeTimeStringWithTimestampString:JJSTRING(dictionary[@"time"]) andFormatString:@"yyyy-MM-dd HH:mm:ss"]];
    self.label1.text = [NSString stringWithFormat:@"更新:%@",dictionary[@"time"]];
    
    NSMutableArray *marr = [NSMutableArray new];
    for (int i = 0; i < [dictionary[@"data"] count]; i ++) {
        NSMutableDictionary *mdic = [[NSMutableDictionary alloc] initWithDictionary:dictionary[@"data"][i]];
        mdic[@"time"] = dictionary[@"time"];
        if ( ! mdic[@"value"]) {
            mdic[@"value"] = JJSTRING(mdic[@"data"]);
        }
        [marr addObject:mdic];
    }
    [self.subController0 updateDataWithArray:marr];
    [self.subController1 updateDataWithArray:marr];
//    [self.subController1 updateDataWithArray:marr];
//    [self.subController1 updateDataWithArray:marr];
}

#pragma mark mqtt delegate
//接收.好像握手时候用到了
- (void)mqttManager:(JJMQTTManager *)manager received:(MQTTSession *)session type:(MQTTCommandType)type qos:(MQTTQosLevel)qos retained:(BOOL)retained duped:(BOOL)duped mid:(UInt16)mid data:(NSData *)data;{
    
}

//连接成功
- (void)mqttManager:(JJMQTTManager *)manager connected:(MQTTSession *)session;{
    //连接成功
    
    [self hideHud];
    [self showHudInView:self.view hint:@"订阅中..."];
    
    NSLog(@"%@",session.willTopic);
    
    NSString *str = [NSString stringWithFormat:@"/cio/01/data/%@/data",[JJExtern sharedJJ].currentDeviceID];
    manager.topic = str;
    [session subscribeToTopic:str atLevel:MQTTQosLevelAtLeastOnce subscribeHandler:^(NSError *error, NSArray*gQoss) {
        [self hideHud];
        if (error) {
            [self showHint:@"订阅失败"];
            self.label1.text = @"订阅失败,请使用切换设备功能重新激活";
            NSLog(@"连接失败 = %@", error.localizedDescription);
        }else{
            NSLog(@"链接成功 = %@", gQoss);
            NSLog(@"%@",manager.topic);
        }
    }];
}

//返回内容
- (void)mqttManager:(JJMQTTManager *)manager newMessage:(MQTTSession *)session data:(NSData*)data onTopic:(NSString*)topic qos:(MQTTQosLevel)qos retained:(BOOL)retained mid:(unsigned int)mid;{
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    mDic[@"time"] = [JJDate getTimeTimeStringWithTimestampString:JJSTRING(dic[@"time"]) andFormatString:@"HH:mm:ss"];
    NSLog(@"%@",mDic);
    [self updateDataWithDictionary:mDic];
    
}

//关闭
- (void)mqttManager:(JJMQTTManager *)manager connectionClosed:(MQTTSession *)session;{
    //失败1
    [self showHint:@"连接关闭"];
    self.label1.text = @"连接关闭,请使用切换设备功能重新激活";
}

//错误
- (void)mqttManager:(JJMQTTManager *)manager connectionError:(MQTTSession *)session error:(NSError *)error;{
    //失败2
    [self hideHud];
    [self showHint:@"连接失败"];
    self.label1.text = @"连接失败,请使用切换设备功能重新激活";
}

//拒绝
- (void)mqttManager:(JJMQTTManager *)manager connectionRefused:(MQTTSession *)session error:(NSError *)error;{
    
}

//向后兼容,暂时无用
- (void)mqttManager:(JJMQTTManager *)manager session:(MQTTSession*)session newMessage:(NSData*)data onTopic:(NSString*)topic;{
    
}

//处理事件
- (void)mqttManager:(JJMQTTManager *)manager handleEvent:(MQTTSession *)session event:(MQTTSessionEvent)eventCode error:(NSError *)error;{
    
}


@end


