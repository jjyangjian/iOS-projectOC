//
//  JJShebeiliebiaoController.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/9.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJShebeiliebiaoController : UITableViewController

typedef void (^JJShebeiliebiaoControllerSelectedDeviceBlock)(NSDictionary *device);


@property (nonatomic,strong)JJShebeiliebiaoControllerSelectedDeviceBlock selectedDeviceBlock;

@property (nonatomic)int type;

- (instancetype)initWithSelectedDeviceBlock:(JJShebeiliebiaoControllerSelectedDeviceBlock)block;

@end

NS_ASSUME_NONNULL_END
