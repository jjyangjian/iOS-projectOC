//
//  JJJianceController.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/5/9.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJJianceController.h"

#import "JJTabbarController.h"


//选择设备
#import "JJXuanzeshebeiView.h"

//实时监测
#import "JJShishijianceController.h"

//历史
#import "JJLishijiluController.h"

//设备列表
#import "JJShebeiliebiaoController.h"

//报警记录
#import "JJBaojingjiluController.h"

//统计
#import "JJTongjiController.h"



@interface JJJianceController ()

@property (nonatomic,strong)JJShishijianceController *subController0;
@property (nonatomic,strong)JJLishijiluController *subController1;
@property (nonatomic,strong)JJTongjiController *subController2;
@property (nonatomic,strong)JJBaojingjiluController *subController3;

@property (nonatomic)long currentIndex;
@property (nonatomic,weak)UIViewController *currentSubController;

@end

@implementation JJJianceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationItem.title = @"监测";
    self.navigationItem.title = [JJExtern sharedJJ].currentDevice[@"eqName"];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换设备" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick:)];
    
    [self createSubViewControllers];
    
}

- (void)rightBarButtonItemClick:(UIBarButtonItem *)buttonItem{
    JJWEAKSELF
    self.navigationItem.rightBarButtonItem.enabled = 0;

    JJXuanzeshebeiView *view = [[JJXuanzeshebeiView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height) andSelectedDevice:^(NSDictionary * _Nonnull device) {
        
        [JJExtern sharedJJ].currentDevice = device;
        [JJExtern sharedJJ].currentDeviceID = device[@"eqId"];
        
        if ([weakself.tabBarController isKindOfClass:[JJTabbarController class]]) {
            [((JJTabbarController *)weakself.tabBarController) qiehuanShebei];
        }
    } andHideBlock:^{
        weakself.navigationItem.rightBarButtonItem.enabled = 1;
    }];
    [self.view addSubview:view];
    [view showCompletion:^(BOOL finished) {
    }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return 1;
}

- (void)createSubViewControllers{
    
    self.subController0 = [[JJShishijianceController alloc] init];
    //    self.subController0.view.frame = CGRectMake(0, 0, SIZE.width, height);
    [self addChildViewController:self.subController0];
    
    self.subController1 = [[JJLishijiluController alloc] init];
    [self addChildViewController:self.subController1];
    
    self.subController2 = [[JJTongjiController alloc] init];
    [self addChildViewController:self.subController2];
    
    self.subController3 = [[JJBaojingjiluController alloc] init];
    [self addChildViewController:self.subController3];
    
    self.subController0.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.subController0.view];
    self.currentIndex = 0;
    self.currentSubController = self.subController0;
    
}

- (IBAction)segmentControlClick:(UISegmentedControl *)sender {
    
    NSLog(@"%ld",(long)sender.selectedSegmentIndex);
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


@end

