//
//  JJXuanzeshebeiView.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/17.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJXuanzeshebeiView : UIView

typedef void (^JJXuanzeshebeiViewSelectedDeviceBlock)(NSDictionary *device);
typedef void (^JJXuanzeshebeiViewHideBlock)(void);


@property (nonatomic, strong) JJXuanzeshebeiViewSelectedDeviceBlock selectedDeviceBlock;
@property (nonatomic, strong) JJXuanzeshebeiViewHideBlock hideBlock;

@property (nonatomic, strong) UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *hideButton;

- (instancetype)initWithFrame:(CGRect)frame andSelectedDevice:(JJXuanzeshebeiViewSelectedDeviceBlock)selectedDeviceBlock andHideBlock:(JJXuanzeshebeiViewHideBlock)hideBlock ;


- (void)showCompletion:(void(^)(BOOL finished))completion;


@end

NS_ASSUME_NONNULL_END
