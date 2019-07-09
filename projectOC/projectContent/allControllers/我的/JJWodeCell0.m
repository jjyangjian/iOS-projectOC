//
//  JJWodeCell0.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/9.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJWodeCell0.h"

@implementation JJWodeCell0

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.label0.text = [JJExtern sharedJJ].username;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
