//
//  JJDengluController.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/17.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJDengluController.h"

#import "JJTabbarController.h"

@interface JJDengluController ()

@end

@implementation JJDengluController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.textField0.text = @"user001";
//    self.textField1.text = @"123123";
    self.textField0.text = [JJExtern sharedJJ].username;
    self.textField1.text = [JJExtern sharedJJ].password;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonClick:(UIButton *)sender {
    
    NSDictionary *bodyDictionary = @{
                                @"username":self.textField0.text,
                                @"password":self.textField1.text,
                                };
    JJWEAKSELF
    [self showHudInView:self.view hint:@""];
    [JJDownload login_Method:@"POST" andURLString:JJURLSTRING_api_login andBodyDictionary:bodyDictionary andSuccessBlock:^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
        
//        [weakself hideHud];
//        [weakself showHint:message];
        
        [JJExtern sharedJJ].username = weakself.textField0.text;
        [JJExtern sharedJJ].password = weakself.textField1.text;
        [JJExtern sharedJJ].token = responseObject[@"content"][@"token"];
        
        [weakself getDevicesList];
        
    } andFailureBlock:^(NSError * _Nonnull error) {
        [weakself hideHud];
        NSLog(@"%@",error);
        [weakself showHint:error.domain];
    }];
    
}

//2.设备列表/api/eq/info/{eqid}
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
                   [weakself hideHud];
                   NSLog(@"%@",responseObject);
                   if ([responseObject[@"content"] count]) {
                       [weakself showHint:message];
                       [JJExtern sharedJJ].devices = responseObject[@"content"];
                       [UIApplication sharedApplication].keyWindow.rootViewController = [[JJTabbarController alloc] init];
                       [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
                   }else{
                       [JJExtern sharedJJ].token = nil;
                       [self showHint:@"当前账号无设备"];
                   }
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   [weakself hideHud];
                   [weakself showHint:error.domain];
                   NSLog(@"%@",error);
               }];
}

//3.设备信息/api/eq/info/{eqid}
- (void)jiekou3{
    //    "username":"zyf3","password":"123"
//    NSDictionary *parameter = @{
//                                };
    JJWEAKSELF
    [self showHudInView:self.view hint:@""];
    [JJDownload getData_Method:@"GET"
                  andURLString:JJURLSTRING_api_eq_info_(@"300000")
                  andParameter:nil
                  andNeedToken:1
               andSuccessBlock: ^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
                   [weakself hideHud];
                   [weakself showHint:message];
                   NSLog(@"%@",responseObject);
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   [weakself hideHud];
                   [weakself showHint:error.domain];
                   NSLog(@"%@",error);
               }];
}





@end


/*
 
 */
