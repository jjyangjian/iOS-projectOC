//
//  JJShebeiliebiaoCell.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/9.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJShebeiliebiaoCell.h"
@interface JJShebeiliebiaoCell ()

//@property (nonatomic,strong)NSDictionary *attributesDic;

@end


@implementation JJShebeiliebiaoCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    style.firstLineHeadIndent = 40.f;
//    self.attributesDic = @{NSFontAttributeName:[UIFont systemFontOfSize:14.f],
//                           NSForegroundColorAttributeName:[UIColor darkGrayColor],
//                           NSParagraphStyleAttributeName:style,
//                           };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)loadDataWithDictionary:(NSDictionary *)dictionary{
    
//    self.label3.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"地址:河北省石家庄市桥西区东二环南路99999号"] attributes:self.attributesDic];
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    self.buttonBlock(sender.tag);
}

- (void)loadDataWithDevice:(NSDictionary *)device buttonBlock:(JJButtonBlock)buttonBlock;
{
    self.buttonBlock = buttonBlock;
    self.label0.text = [NSString stringWithFormat:@"%@",device[@"eqName"]];
//    self.label1.text = [NSString stringWithFormat:@"解析参数:%@",device.deviceCommunicationType];
//    self.label2.text = [NSString stringWithFormat:@"通信类型:%@",device.deviceAnalyticalParameter];
//    self.label3.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"地址:%@",device.deviceAddress] attributes:self.attributesDic];
    
//    self.label1.text = [NSString stringWithFormat:@"设备id:%@",device[@"eqId"]];
    self.label1.text = [NSString stringWithFormat:@"%@",device[@"eqId"]];

    self.label2.text = @[@"离线",@"在线",@"",@"",@"",@"",@""][[device[@"status"] intValue]];
    if ([device[@"status"] intValue] == 0) {
        self.label2.backgroundColor = [UIColor redColor];
    }else if ([device[@"status"] intValue] == 1) {
        self.label2.backgroundColor = [UIColor colorWithRed:0.21f green:0.64f blue:0.89f alpha:1.00f];
    }else{
        self.label2.backgroundColor = [UIColor colorWithRed:0.90f green:0.73f blue:0.00f alpha:1.00f];;
    }
    self.button0.selected = [device[@"eqId"] isEqualToString:[JJExtern sharedJJ].currentDeviceID];

//    if ([device[@"eqId"] isEqualToString:[JJExtern sharedJJ].currentDeviceID]) {
//        [self.button0 setTitle:@"已关注" forState:UIControlStateNormal];
//        self.button0.enabled = 0;
//    }else{
//        [self.button0 setTitle:@"关注" forState:UIControlStateNormal];
//        self.button0.enabled = 1;
//    }
}

@end
