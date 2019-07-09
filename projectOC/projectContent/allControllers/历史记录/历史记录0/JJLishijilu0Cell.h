//
//  JJLishijilu0Cell.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/13.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJLishijilu0Cell : UITableViewCell

//@property (weak, nonatomic) IBOutlet UILabel *label0;
//@property (weak, nonatomic) IBOutlet UILabel *label1;
//
//@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UIStackView *stackView;


- (void)addLabels:(NSArray <UILabel *>*)labels;


@end

NS_ASSUME_NONNULL_END
