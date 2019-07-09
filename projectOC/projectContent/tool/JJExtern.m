//
//  JJExtern.m
//  jjxinfadi
//
//  Created by CMP on 2018/7/13.
//  Copyright © 2018年 ChiefCadet. All rights reserved.
//

#import "JJExtern.h"


//#import "JJDengluController.h"




@implementation JJExtern

static JJExtern *jj = nil;

//@synthesize currentDeviceID = _currentDeviceID;


+ (void)gotoDengluController;
{
    [JJExtern sharedJJ].userid = @"";
    [JJExtern sharedJJ].token = @"";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"当前账号已在其他设备登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //        [UIApplication sharedApplication].keyWindow.rootViewController = [[JJDengluController alloc] init];
        //        [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    }]];
    [[self jsd_getCurrentViewController] presentViewController:alertController animated:1 completion:^{
    }];
}

+ (UIViewController *)jsd_getCurrentViewController{
    UIViewController * currentViewController = [self jsd_getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController * tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            } else {
                return currentViewController;
            }
        }
    }    return currentViewController;
}
+ (UIViewController *)jsd_getRootViewController{
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");    return window.rootViewController;
}

+ (void)showXuanzeshebeiViewForViewController:(UIViewController *)viewController andSelectedDevice:(JJXuanzeshebeiViewSelectedDeviceBlock)selectedDeviceBlock andHideBlock:(JJXuanzeshebeiViewHideBlock)hideBlock;
{
    JJXuanzeshebeiView *view = [[JJXuanzeshebeiView alloc] initWithFrame:viewController.view.bounds andSelectedDevice:^(NSDictionary * _Nonnull device) {
        selectedDeviceBlock (device);
    } andHideBlock:^{
        hideBlock();
    }];
    [viewController.view addSubview:view];
    [view showCompletion:^(BOOL finished) {
    }];
}


+ (JJExtern *)sharedJJ{
    @synchronized (self){
        if (!jj) {
            jj = [[self alloc] init];
        }
        return jj;
    }
}

- (instancetype)init{
    @synchronized   (self){
        if(self = [super init])
        {
            //______________________________
            //在这里写下想给的初始值
            //
            
            _username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
            _password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
            _token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
            
            _currentDeviceID = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@currentDeviceID",self.username]];
            
            _userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
            
            _phone  = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
            _headimageurlstring  = [[NSUserDefaults standardUserDefaults] objectForKey:@"headimageurlstring"];
            _name  = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
            _sex  = [[NSUserDefaults standardUserDefaults] objectForKey:@"sex"];

  
            NSArray *locationcoordinateStringArray =
            @[  @"38.012822,114.464073",
                @"38.016894,114.436117",
                @"37.889766,114.412833",
                @"37.556044,114.565761",
                @"37.799606,113.465372",
                @"37.615066,113.015789",
                @"34.467755,109.442689",
                @"30.584105,104.071828",];
            
//            NSMutableArray *marr = [[NSMutableArray alloc] init];
//            for (int i = 0; i < locationcoordinateStringArray.count; i ++) {
//                JJDevice *device = [JJDevice new];
//                device.deviceName = [NSString stringWithFormat:@"设备%d",i];
//                device.deviceID = [NSString stringWithFormat:@"xa84747%d",i];
//                device.deviceCommunicationType = @"触摸屏";
//                device.deviceAnalyticalParameter = @[
//                                                     [NSString stringWithFormat:@"触摸屏x2-%2d",i],
//                                                     [NSString stringWithFormat:@"%@-定制触摸式多功能键盘%2d",device.deviceName,i],
//                                                     ][arc4random()%2];
//                device.deviceState = arc4random()%2;
//
//                NSArray *arr = [locationcoordinateStringArray[i] componentsSeparatedByString:@","];
//                device.deviceCoordinate = CLLocationCoordinate2DMake([arr[0] doubleValue],[arr[1] doubleValue]);
//
//                device.deviceAddress = @[
//                                         [NSString stringWithFormat:@"河北省石家庄市桥西区1%d号",i],
//                                         [NSString stringWithFormat:@"河北省石家庄市桥西区红旗大街1%d号",i],
//                                         [NSString stringWithFormat:@"河北省石家庄市桥西区红旗大街南二环交叉口1%d号",i],][arc4random()%3];
//
//                [marr addObject:device];
//            }
//            self.devices = marr;
            //______________________________
            return self;
        }
        return nil;
    }
}

- (void)setUsername:(NSString *)username{
    _username = username;
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setPassword:(NSString *)password{
    _password = password;
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setToken:(NSString *)token{
    _token = token;
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setCurrentDeviceID:(NSString *)currentDeviceID{
    _currentDeviceID = currentDeviceID;
    [[NSUserDefaults standardUserDefaults] setObject:currentDeviceID forKey:[NSString stringWithFormat:@"%@currentDeviceID",self.username]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setDevices:(NSArray<NSDictionary *> *)devices{
    _devices = devices;
    if (self.currentDeviceID) {
        for (int i = 0; i < devices.count; i ++) {
            if ([devices[i][@"eqId"] isEqualToString:self.currentDeviceID]) {
                self.currentDevice = devices[i];
                break;
            }
        }
    }else{
//        if (devices.count) {
            self.currentDevice = devices[0];
            self.currentDeviceID = devices[0][@"eqId"];
//        }else{
//            self.currentDevice = nil;
//            self.currentDeviceID = nil;
//        }
    }
}

- (void)setUserid:(NSString *)userid{
    _userid = userid;
    [[NSUserDefaults standardUserDefaults] setObject:userid forKey:@"userid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setPhone:(NSString *)phone{
    _phone = phone;
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setName:(NSString *)name{
    _name = name;
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setSex:(NSString *)sex{
    _sex = sex;
    [[NSUserDefaults standardUserDefaults] setObject:sex forKey:@"sex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setHeadimageurlstring:(NSString *)headimageurlstring{
    _headimageurlstring = headimageurlstring;
    [[NSUserDefaults standardUserDefaults] setObject:headimageurlstring forKey:@"headimageurlstring"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//- (void)setDevicesWithArray:(NSArray *)deviceDicArray;
//{
//    NSMutableArray *mArray = [[NSMutableArray alloc] init];
//    for (int i = 0; i < deviceDicArray.count; i ++) {
//        JJDevice *device = [[JJDevice alloc] init];
////        device.deviceName = JJSTRING(deviceDicArray[i][@"eqName"]);
//        [device setValuesForKeysWithDictionary:deviceDicArray[i]];
//        [mArray addObject:device];
//    }
//}

- (void)getDevicesList{
    //    NSDictionary *parameter = @{
    //                                };
    JJWEAKSELF
    //    [self showHudInView:self.view hint:@""];
    [JJDownload getData_Method:@"POST"
                  andURLString:JJURLSTRING_api_eq_list_my
                  andParameter:nil
                  andNeedToken:1
               andSuccessBlock: ^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
                   NSLog(@"%@",responseObject);
                   if ([responseObject[@"content"] count]) {
                       weakself.devices = responseObject[@"content"];
                   }else{
                       weakself.token = nil;
                   }
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   NSLog(@"%@",error);
               }];
}




@end






#import <sys/utsname.h>

@implementation JJOther

+ (BOOL)is_iPhoneX {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform hasPrefix:@"iPhone"]) {
        if ([platform isEqualToString:@"iPhone10,3"]
            ||[platform isEqualToString:@"iPhone10,6"]
            ||[platform isEqualToString:@"iPhone11,2"]
            ||[platform isEqualToString:@"iPhone11,4"]
            ||[platform isEqualToString:@"iPhone11,6"]
            ||[platform isEqualToString:@"iPhone11,8"]
            ) {
            return 1;
        }
        return 0;
    }else {
        return 0;
    }
}

+ (UIColor*)colorWithHexString:(NSString*)stringToConvert{
    if([stringToConvert hasPrefix:@"#"])
    {
        stringToConvert = [stringToConvert substringFromIndex:1];
    }
    NSScanner*scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if(![scanner scanHexInt:&hexNum])
    {
        return nil;
    }
    return [self colorWithRGBHex:hexNum];
}

+ (UIColor*)colorWithRGBHex:(UInt32)hex{
    int r = (hex >>16) &0xFF;
    int g = (hex >>8) &0xFF;
    int b = (hex) &0xFF;
    return[UIColor colorWithRed:r /255.f green:g /255.f blue:b /255.f alpha:1.f];
}


+ (NSString *)getDifferentString{
    NSDate *date = [NSDate date];
    NSTimeInterval timeInterval =[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", timeInterval];//转为字符型
    //    NSLog(@"%@",timeString);
    NSString *arcString = [NSString stringWithFormat:@"%c%c%c",arc4random()%26 + 97,arc4random()%26 + 97,arc4random()%26 + 97];
    return [NSString stringWithFormat:@"%@%@",timeString,arcString];
}


//压缩图片
+ (NSData *)compressImage:(UIImage *)image MaxLength:(NSUInteger)maxLength;
{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}

@end

@implementation JJDate
/*
 获取当前 时间戳
 */
+ (NSTimeInterval)getTimeNowTimestamp;
{
    NSDate *date = [NSDate date];
    NSString *timestampString = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timestampString);//时间戳的值
    return (long)[date timeIntervalSince1970];
}
/*
 获取当前 时间
 @"yyyy-MM-dd"
 @"yyyy-MM-dd HH:mm"
 @"yyyy-MM-dd HH:mm:ss"
 */
+ (NSString *)getTimeNowTimeStringWithFormatString:(NSString *)formatString;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    
    NSDate *date = [NSDate date];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

/*
 根据 时间 获取 时间戳
 2000-01-01 12:00:00
 @"yyyy-MM-dd"
 @"yyyy-MM-dd HH:mm"
 @"yyyy-MM-dd HH:mm:ss"
 */
+ (NSTimeInterval)getTimestampStringWithTimeString:(NSString *)timeString andFormatString:(NSString *)formatString;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:formatString]; //设定时间的格式
    NSDate *date = [dateFormatter dateFromString:timeString];//将字符串转换为时间对象
    //    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];//字符串转成时间戳,精确到毫秒*1000
    return (long)[date timeIntervalSince1970];
}

/*
 根据时间戳获取时间
 @"yyyy-MM-dd"
 @"yyyy-MM-dd HH:mm"
 @"yyyy-MM-dd HH:mm:ss"
 */
+ (NSString *)getTimeTimeStringWithTimestampString:(NSString *)timestampString andFormatString:(NSString *)formatString;
{
    if (timestampString.length > 10) {
        timestampString = [timestampString substringToIndex:10];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    [dateFormatter setDateFormat:formatString];
    
    NSTimeInterval timeinterval = [timestampString doubleValue];//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeinterval];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
    
    
}


//根据date获取年
+ (NSInteger)calendar_yearFromDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear) fromDate:date];
    return [components year];
}

//根据date获取月
+ (NSInteger)calendar_monthFromDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitMonth) fromDate:date];
    return [components month];
}

//根据date获取日
+ (NSInteger)calendar_dayFromDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay) fromDate:date];
    return [components day];
}

//根据date 获取 当日 周几 (美国时间周日-周六为 1-7,改为0-6方便计算)
+ (NSInteger)calendar_weekdayFromDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar]
                                    components:
                                    NSCalendarUnitYear
                                    |NSCalendarUnitMonth
                                    |NSCalendarUnitDay
                                    //                                    |NSCalendarUnitHour
                                    //                                    |NSCalendarUnitMinute
                                    //                                    |NSCalendarUnitSecond
                                    |NSCalendarUnitWeekday
                                    fromDate:date];
    NSInteger weekDay = [components weekday] - 1;
    weekDay = MAX(weekDay, 0);//对比大数,取大数,事实上应该用不到
    return weekDay;
}

//根据date获取 当月第一天 周几
+ (NSInteger)calendar_weekdayOfMonthFromDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear
                                                   | NSCalendarUnitMonth
                                                   | NSCalendarUnitDay)
                                         fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstDayOfMonth = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstDayOfMonth - 1;  //美国时间周日为星期的第一天，所以周日-周六为1-7，改为0-6方便计算
}

//根据date获取当月总天数
+ (NSInteger)calendar_totalDaysOfMonthFromDate:(NSDate *)date {
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}




@end





//#import "CALayer+Extension.h"

@implementation CALayer (Extension)
- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

@end




