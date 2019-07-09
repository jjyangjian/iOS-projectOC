//
//  JJTongji1Controller.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/13.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJTongji1Controller : UITableViewController


- (instancetype)initWithTitleInfoArray:(NSArray *)titleInfoArray;


- (void)updateDataWithDictionary:(NSDictionary *)dataDictionary;

@end

NS_ASSUME_NONNULL_END
