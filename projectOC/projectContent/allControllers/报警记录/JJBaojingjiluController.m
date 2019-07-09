//
//  JJBaojingjiluController.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/10.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJBaojingjiluController.h"

#import "JJBaojingjilu0Controller.h"
#import "JJBaojingjilu1Controller.h"

@interface JJBaojingjiluController ()

@property (nonatomic,strong)JJBaojingjilu0Controller *subController0;
@property (nonatomic,strong)JJBaojingjilu1Controller *subController1;

@property (nonatomic)long currentIndex;
@property (nonatomic,weak)UIViewController *currentSubController;



@property (nonatomic,strong)NSArray *titleInfoArray;


@end

@implementation JJBaojingjiluController

- (instancetype)initWithTitleInfoArray:(NSArray *)titleInfoArray
{
    self = [super init];
    if (self) {
        self.titleInfoArray = titleInfoArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"报警记录";
    self.label0.text = [JJExtern sharedJJ].currentDevice[@"eqName"];

    self.view.backgroundColor = JJCOLOR_BAISE;
    
    [self createSubViewControllers];
//    [self createFakeNavigationBar];
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
    
    self.subController0 = [[JJBaojingjilu0Controller alloc] init];
//    self.subController0.view.frame = CGRectMake(0, 0, SIZE.width, height);
    [self addChildViewController:self.subController0];
    
    self.subController1 = [[JJBaojingjilu1Controller alloc] init];
//    self.subController1.view.frame = self.contentView.bounds;
    JJWEAKSELF
    self.subController1.detailBlock = ^(NSString * _Nonnull time) {
        [weakself switchSubControllerToIndex:0 andCompletion:^(BOOL finished) {
            if (finished) {
//                weakself.topButton0.selected = 1;
//                weakself.topButton1.selected = 0;
                weakself.segmentControl.selectedSegmentIndex = 0;
                [weakself.subController0 detailWithTime:time];
            }
        }];
    };
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
