//
//  JJExtern.h
//  jjxinfadi
//
//  Created by CMP on 2018/7/13.
//  Copyright © 2018年 ChiefCadet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#import "JJXuanzeshebeiView.h"


@interface JJExtern : NSObject
//+(instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));
//+(instancetype) new __attribute__((unavailable("call sharedInstance instead")));
//-(instancetype) copy __attribute__((unavailable("call sharedInstance instead")));
//-(instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));

typedef void (^JJExternBlock)(NSDictionary *dic ,NSString *msg,int code);

@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *password;

@property (nonatomic,strong)NSString *token;

/*  设备的参数
 categoryId = 110;
 categoryName = "<null>";
 deptId = 104;
 eqId = 300000;
 eqName = "ph\U4f20\U611f\U5668";
 mapXy = "114.434634,38.035341";
 orderNum = 2;
 remark = "<null>";
 status = 0;
 userId = "<null>";
 */
@property (nonatomic,strong)NSArray <NSDictionary *>*devices;//多台设备
@property (nonatomic,strong)NSString *currentDeviceID;//当前设备的id
@property (nonatomic,strong)NSDictionary *currentDevice;//当前设备的id

@property (nonatomic,strong)NSString *userid;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *headimageurlstring;//头像地址
@property (nonatomic,strong)NSString *name;//姓名
//@property (nonatomic,strong)NSString *nickname;//姓名
@property (nonatomic,strong)NSString *sex;//性别


+ (void)showXuanzeshebeiViewForViewController:(UIViewController *)viewController andSelectedDevice:(JJXuanzeshebeiViewSelectedDeviceBlock)selectedDeviceBlock andHideBlock:(JJXuanzeshebeiViewHideBlock)hideBlock;

+ (instancetype)sharedJJ;

+ (void)gotoDengluController;


@end




//other类,比较杂的东西

@interface JJOther : NSObject

typedef void (^JJButtonBlock)(long buttonTag);

//判断是否异形屏
+ (BOOL)is_iPhoneX;

+ (UIColor*)colorWithHexString:(NSString*)stringToConvert;

+ (NSString *)getDifferentString;

+ (NSData *)compressImage:(UIImage *)image MaxLength:(NSUInteger)maxLength;

@end

@interface JJDate : NSObject

/*
 获取当前 时间戳
 */
+ (NSTimeInterval)getTimeNowTimestamp;

/*
 获取当前 时间
 @"yyyy-MM-dd"
 @"yyyy-MM-dd HH:mm"
 @"yyyy-MM-dd HH:mm:ss"
 */
+ (NSString *)getTimeNowTimeStringWithFormatString:(NSString *)formatString;

/*
 根据 时间 获取 时间戳
 2000-01-01 12:00:00
 @"yyyy-MM-dd"
 @"yyyy-MM-dd HH:mm"
 @"yyyy-MM-dd HH:mm:ss"
 */
+ (NSTimeInterval)getTimestampStringWithTimeString:(NSString *)timeString andFormatString:(NSString *)formatString;

/*
 根据时间戳获取时间
 @"yyyy-MM-dd"
 @"yyyy-MM-dd HH:mm"
 @"yyyy-MM-dd HH:mm:ss"
 */
+ (NSString *)getTimeTimeStringWithTimestampString:(NSString *)timestampString andFormatString:(NSString *)formatString;


//根据date获取年
+ (NSInteger)calendar_yearFromDate:(NSDate *)date ;

//根据date获取月
+ (NSInteger)calendar_monthFromDate:(NSDate *)date ;

//根据date获取日
+ (NSInteger)calendar_dayFromDate:(NSDate *)date ;


//根据date 获取 当日 周几 (美国时间周日-周六为 1-7,改为0-6方便计算)
+ (NSInteger)calendar_weekdayFromDate:(NSDate *)date ;

//根据date获取 当月第一天 周几
+ (NSInteger)calendar_weekdayOfMonthFromDate:(NSDate *)date ;

//根据date获取当月总天数
+ (NSInteger)calendar_totalDaysOfMonthFromDate:(NSDate *)date ;



@end








#import <QuartzCore/QuartzCore.h>

@interface CALayer (Extension)

/*
 
 1.layer.cornerRadius ，注意该 key 对应 Value 的 type 应该设置为 String/Number 两种类型均可
 2.layer.masksToBounds ,注意该 key 对应 Value 的 type 应该设置为 Boolean
 3.layer.borderWidth ，注意该 key 对应 Value 的 type 应该设置为 String/Number 两种类型均可
 4.layer.borderColorFromUIColor 注意该 key 对应 Value 的 type 应该设置为color 并且需要加CALayer的分类、
 
layer.borderColorFromUIColor
 
 */
- (void)setBorderColorFromUIColor:(UIColor *)color;


@end

/*

 
 */







