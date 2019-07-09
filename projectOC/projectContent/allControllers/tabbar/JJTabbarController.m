//
//  JJTabbarController.m
//  xiaoyulvtu
//
//  Created by 杨剑 on 2018/10/19.
//  Copyright © 2018年 贱贱. All rights reserved.
//

#import "JJTabbarController.h"


@interface JJTabbarController ()
<
UITabBarControllerDelegate
>

@property (nonatomic,strong)JJJianceController *controller0;
@property (nonatomic,strong)JJDitushebeiController *controller1;
@property (nonatomic,strong)JJShebeiliebiaoController *controller2;
@property (nonatomic,strong)JJWodeController *controller3;



@end

@implementation JJTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    //    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    //    self.tabBar.shadowImage = [UIImage imageNamed:@"tabbar_background"];
    
    //    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.translucent = 0;
    
    self.tabBar.tintColor = [UIColor colorWithRed:0.10f green:0.41f blue:0.72f alpha:1.00f];
    
    self.controller0 = [[JJJianceController alloc] init];
    UINavigationController *nc0 = [self createNCWithViewController:self.controller0
                                                          andTitle:@"监测"
                                                andNormalImageName:@"tabbar_jiance_n"
                                              andSelectedImageName:@"tabbar_jiance_s"];
    
    self.controller1 = [[JJDitushebeiController alloc] init];
    UINavigationController *nc1 = [self createNCWithViewController:self.controller1
                                                          andTitle:@"地图"
                                                andNormalImageName:@"tabbar_ditu_n"
                                              andSelectedImageName:@"tabbar_ditu_s"];
    
    self.controller2 = [[JJShebeiliebiaoController alloc] init];
    self.controller2.type = 1;
    UINavigationController *nc2 = [self createNCWithViewController:self.controller2
                                                          andTitle:@"设备"
                                                andNormalImageName:@"tabbar_shebei_n"
                                              andSelectedImageName:@"tabbar_shebei_s"];
    
    self.controller3 = [[JJWodeController alloc] init];
    UINavigationController *nc3 = [self createNCWithViewController:self.controller3
                                                          andTitle:@"我的"
                                                andNormalImageName:@"tabbar_wode_n"
                                              andSelectedImageName:@"tabbar_wode_s"];
    
    self.viewControllers = @[nc0,nc1,nc2,nc3,];
}

- (void)qiehuanShebei;
{

    NSMutableArray *mutableControllers = [[NSMutableArray alloc] initWithArray:self.viewControllers];

    self.controller0 = [[JJJianceController alloc] init];
    UINavigationController *nc0 = [self createNCWithViewController:self.controller0
                                                          andTitle:@"监测"
                                                andNormalImageName:@"tabbar_jiance_n"
                                              andSelectedImageName:@"tabbar_jiance_s"];
    mutableControllers[0] = nc0;
    self.viewControllers = mutableControllers;
    self.selectedIndex = 0;
}

- (UINavigationController *)createNCWithViewController:(UIViewController *)viewController andTitle:(NSString *)title andNormalImageName:(NSString *)normalImageName andSelectedImageName:(NSString *)selectedImageName{
    
//    viewController.tabBarItem.image = [[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    nc.view.backgroundColor = [UIColor whiteColor];
    
    nc.tabBarItem.image = [[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //半透明
    nc.navigationBar.translucent = 0;
//    nc.navigationBar.shadowImage = [UIImage new];
    
    //设置导航栏图片
    [nc.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [nc.navigationBar setTitleTextAttributes:@{
                                               NSFontAttributeName:[UIFont systemFontOfSize:19],
                                            NSForegroundColorAttributeName:[UIColor darkGrayColor],}];
    
    nc.tabBarItem.title = title;
//    [nc.navigationBar setTintColor:[UIColor whiteColor]];
    return nc;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0);
{
    return 1;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
{
//    while (1) {
//         AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    };
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    kSystemSoundID_UserPreferredAlert   = 0x00001000,
//    kSystemSoundID_FlashScreen          = 0x00000FFE,
//    // this has been renamed to be consistent
//    kUserPreferredAlert     = kSystemSoundID_UserPreferredAlert
//    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
{
    
}

- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
{
    
}



@end



