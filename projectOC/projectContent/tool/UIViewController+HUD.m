/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "UIViewController+HUD.h"
#import <MBProgressHUD.h>
#import <objc/runtime.h>
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.label.text = hint;
    [view addSubview:hud];
    [hud showAnimated:1];
//    [hud showAnimated:1 whileExecutingBlock:^{
//    }];//被弃用,若使用建议使用gcd
    [self setHUD:hud];
}

- (void)showHint:(NSString *)hint {
    if ([hint isEqualToString:@"录音没有开始"]) {
       // NSLog(@"dd");
    }
    
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.offset = CGPointMake(hud.offset.x, [UIScreen mainScreen].bounds.size.height /640*150);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
//    hud.yOffset += yOffset;
    hud.offset = CGPointMake(hud.offset.x, hud.offset.y + yOffset);
    
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:1 afterDelay:2];
}

- (void)hideHud{
    [[self HUD] hideAnimated:1];
}

- (void)hideHud:(NSUInteger) delaySeconds
{
    [[self HUD] hideAnimated:1 afterDelay:delaySeconds];
}

- (void)showHudInViewOnlyText:(UIView *)view hint:(NSString *)hint
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeText;
    //    HUD.mode = MBProgressHUDModeCustomView;
    hud.label.text = hint;
    //    hud.yOffset = IS_IPHONE_5?220:150.f;
    //    hud.yOffset = [UIScreen mainScreen].bounds.size.height / 640*150;
    hud.offset = CGPointMake(hud.offset.x, [UIScreen mainScreen].bounds.size.height / 640*150);
    [view addSubview:hud];
    [hud showAnimated:1];
    [self setHUD:hud];
    [hud hideAnimated:1 afterDelay:2];
}
@end
