//
//  JJBaojingjilu1Controller.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/10.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJBaojingjilu1Controller : UIViewController

typedef void(^JJBaojingjilu1ControllerDetailBlock)(NSString *time);

@property (strong, nonatomic) JJBaojingjilu1ControllerDetailBlock detailBlock;


@property (weak, nonatomic) IBOutlet UIButton *timeButton;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *label0;



@end

NS_ASSUME_NONNULL_END
