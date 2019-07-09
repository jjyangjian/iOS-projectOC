//
//  JJLishijilu0Controller.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/12.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJLishijilu0Controller.h"

#import "JJLishijilu0Cell.h"
#import "JJLishijilu0HeaderView.h"


@interface JJLishijilu0Controller ()
<
UITableViewDelegate,
UITableViewDataSource
>


@property (nonatomic,strong)NSMutableArray *dataArray;
//@property (nonatomic,strong)NSMutableDictionary *infoDictionary;
@property (nonatomic,strong)JJLishijilu0HeaderView *onlyHeaderView;

@property (nonatomic,strong)NSArray *titleInfoArray;

@end

@implementation JJLishijilu0Controller

static NSString *cellName = @"JJLishijilu0Cell";
static NSString *headerViewName = @"JJLishijilu0HeaderView";

- (instancetype)initWithTitleInfoArray:(NSArray *)titleInfoArray
{
    self = [super init];
    if (self) {
        self.titleInfoArray = titleInfoArray;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.title = @"粉丝互动";
    self.dataArray = [[NSMutableArray alloc] init];
    
//    [self createData];
    [self createTableView];
    
    
}

//- (void)rightBarButtonItemClick:(UIBarButtonItem *)buttonItem{
//}

- (void)updateDataWithArray:(NSArray *)dataArray;
{
    self.dataArray = [[NSMutableArray alloc] initWithArray:dataArray];
    
    [self.tableView reloadData];
    if (self.dataArray.count) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
//    [self.tableView setContentOffset:CGPointMake(0, 0)];
    if (!self.onlyHeaderView) {
        [self createTableViewHeader];
    }
}



- (void)createData
{
}



- (void)createTableView{
    [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellName];
    
//    [self.tableView registerNib:[UINib nibWithNibName:headerName bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:headerName];
    
}

- (void)createTableViewHeader{
    
    self.onlyHeaderView = [[NSBundle mainBundle] loadNibNamed:headerViewName owner:nil options:nil][0];
    
    NSMutableArray *labelArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < self.titleInfoArray.count ; i ++) {
        NSDictionary *dic = self.titleInfoArray[i];
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = 1;
        label.font = [UIFont systemFontOfSize:11.f];
        label.numberOfLines = 2;
        
        NSString *title = [NSString stringWithFormat:@"%@",dic[@"title"]];
//        self.dataArray
        if (self.dataArray.count) {
            NSString *key = self.titleInfoArray[i][@"field"];
            NSString *unit = JJSTRING((self.dataArray[0][[NSString stringWithFormat:@"%@_u",key]]));
            unit = [unit stringByReplacingOccurrencesOfString:@"(" withString:@""];
            unit = [unit stringByReplacingOccurrencesOfString:@")" withString:@""];
            unit = [unit stringByReplacingOccurrencesOfString:@"null" withString:@""];

            title = [NSString stringWithFormat:@"%@\n%@",title,unit];
        }
        
        label.text = title;
        [labelArray addObject:label];
    }
    [self.onlyHeaderView addLabels:labelArray];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
    return self.dataArray.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 66;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 20.f;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    JJLishijilu0HeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewName];
    
//    headerView.label0.text = @[@"2000年8月25日",
//                               @"2000年8月26日",
//                               @"2000年8月27日",
//                               @"2000年8月28日",
//                               @"2000年8月29日",
//                               ][section];
    
    return self.onlyHeaderView;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10.f;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return nil;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJLishijilu0Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    //    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
//    cell.label0.text = self.dataArray[indexPath.row][@"name"];
//    cell.label1.text = self.dataArray[indexPath.row][@"value"];
//    cell.label2.text = self.dataArray[indexPath.row][@"unit"];
    NSMutableArray *labels = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.titleInfoArray.count; i ++) {
        [labels addObject:[self createLabelWithTitleIndex:i andDataIndex:indexPath.row]];
    }
    [cell addLabels:labels];
    return cell;
}

- (UILabel *)createLabelWithTitleIndex:(int)titleIndex andDataIndex:(long)dataIndex{
    
    NSString *key = self.titleInfoArray[titleIndex][@"field"];
    NSString *value = JJSTRING((self.dataArray[dataIndex][[NSString stringWithFormat:@"%@_d",key]]));
    
    NSString *unit = self.dataArray[dataIndex][[NSString stringWithFormat:@"%@_u",key]];
    

    if (!(unit && unit.length)) {
        value = self.dataArray[dataIndex][[NSString stringWithFormat:@"%@",key]];
        unit = @"";
    }
    unit = @"";

    UILabel *label = [[UILabel alloc] init];
    
    label.text = [NSString stringWithFormat:@"%@%@",value,unit];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11.f];
    label.numberOfLines = 2;
    return label;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    
    //    if (indexPath.row == 3) {
    //        UIViewController *controller = [[UIViewController alloc] init];
    //        controller.hidesBottomBarWhenPushed = 1;
    //        [self.navigationController pushViewController:controller animated:1];
    //
    //        controller.view.backgroundColor = [UIColor orangeColor];
    //
    //
    //        return;
    //    }
    //
    //
    
    
    
}


@end



