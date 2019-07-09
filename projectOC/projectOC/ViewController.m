//
//  ViewController.m
//  projectOC
//
//  Created by 杨剑 on 2019/6/11.
//  Copyright © 2019 杨剑. All rights reserved.
//

#import "ViewController.h"

#import "JJTabbarController.h"

#import "JJDengluController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    //    [UIView animateWithDuration:2.f animations:^{
    //        CGRect frame = self->_iconhideView.frame;
    //        frame.origin.x = SIZE.width;
    //        self->_iconhideView.frame = frame;
    //    } completion:^(BOOL finished) {
    //        [self gotoController];
    //    }];
    [self gotoController];
}

- (void)gotoController{
#if 1
    //    self.manager = [[JJMQTTManager alloc] init];
    //    [self.manager mqttConnect];
    
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[JJDengluController alloc] init];
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
#else
    //    JJWEAKSELF
    [UIApplication sharedApplication].keyWindow.rootViewController = [[JJTabbarController alloc] init];
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    
    
    
#endif
    
}



@end
