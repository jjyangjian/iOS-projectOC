//
//  JJAnnotationDetailView.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/5/5.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJAnnotationDetailView : UIView




@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentSpacingConstraint;



@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;

//@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UIButton *backgroundButton;
@property (strong, nonatomic) JJButtonBlock buttonBlock;

- (instancetype)initWithTitle:(NSString *)title
                         time:(NSString *)time
                   labelArray:(NSArray <UILabel *>*)labelArray
                        block:(JJButtonBlock)block;


- (void)show ;

- (void)hide ;

@end

NS_ASSUME_NONNULL_END
