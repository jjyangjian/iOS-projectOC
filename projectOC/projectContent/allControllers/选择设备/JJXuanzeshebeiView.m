//
//  JJXuanzeshebeiView.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/17.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJXuanzeshebeiView.h"

@interface JJXuanzeshebeiView ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property (nonatomic,strong)NSArray <NSDictionary *>*dataArray;

@end

@implementation JJXuanzeshebeiView
static NSString *cellName = @"UITableViewCell";

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (instancetype)initWithFrame:(CGRect)frame andSelectedDevice:(JJXuanzeshebeiViewSelectedDeviceBlock)selectedDeviceBlock andHideBlock:(JJXuanzeshebeiViewHideBlock)hideBlock ;
{
    
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
    self.frame = frame;
    self.selectedDeviceBlock = selectedDeviceBlock;
    self.hideBlock = hideBlock;
    
    self.dataArray = [JJExtern sharedJJ].devices;
    
    [self createTableView];
    return self;
}





//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    if (!self.tableView) {
//        [self createTableView];
//    }
//}

- (void)createTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width / 2, self.frame.size.height) style:UITableViewStylePlain];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    
//    [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellName];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellName];
}


- (void)showCompletion:(void(^)(BOOL finished))completion{
    self.tableView.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width / 2, self.frame.size.height);
    
    [UIView animateWithDuration:0.2f animations:^{
//        self.hideButton.backgroundColor = [UIColor colorWithRed:0.7f green:0.7f blue:0.7f alpha:0.7f];
        self.hideButton.alpha = 0.7;
        
        self.tableView.frame = CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width / 2, self.frame.size.height);
    } completion:^(BOOL finished) {
        completion (finished);
    }];
}


- (IBAction)hideButtonClick:(UIButton *)sender {
    [self hide];
}

- (void)hide{
    [UIView animateWithDuration:0.2 animations:^{
        self.hideButton.alpha = 0.f;
        self.tableView.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width / 2, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.hideBlock) {
            self.hideBlock();
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 66;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.f;
    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10.f;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return nil;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    cell.textLabel.text = self.dataArray[indexPath.row] [@"eqName"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    if (self.selectedDeviceBlock) {
        self.selectedDeviceBlock(self.dataArray[indexPath.row]);
    }
    [self hide];
}








@end
