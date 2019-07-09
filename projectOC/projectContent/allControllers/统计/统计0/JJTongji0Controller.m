//
//  JJTongji0Controller.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/13.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJTongji0Controller.h"

#import "JJTongji0Cell.h"

#import "JJTongji0HeaderView.h"

@interface JJTongji0Controller ()
<
UITableViewDelegate,
UITableViewDataSource
>


//@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSDictionary *dataDictionary;
@property (nonatomic,strong)NSMutableDictionary *infoDictionary;

@property (nonatomic,strong)NSArray *titleInfoArray;



@end

@implementation JJTongji0Controller

static NSString *cellName = @"JJTongji0Cell";
static NSString *headerName = @"JJTongji0HeaderView";


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
    self.navigationItem.title = @"粉丝互动";
//    _dataArray = [[NSMutableArray alloc] init];
    
    [self createData];
    [self createTableView];
    
    
}

//- (void)rightBarButtonItemClick:(UIBarButtonItem *)buttonItem{
//}

- (void)createData
{
//    [_dataArray addObject:@{@"name":@"温度",
//                            @"key":@"T",
//                            @"value":@"2.1",
//                            @"bigvalue":@"5.1",
//                            @"smallvalue":@"1.5",
//                            @"unit":@"°C",
//                            }];
//
//    [_dataArray addObject:@{@"name":@"余氯",
//                            @"key":@"yulv",
//                            @"value":@"2.3",
//                            @"bigvalue":@"5.6",
//                            @"smallvalue":@"1.1",
//                            @"unit":@"mg/L",
//                            }];
//
//    [_dataArray addObject:@{@"name":@"酸碱度",
//                            @"key":@"ph",
//                            @"value":@"5.5",
//                            @"bigvalue":@"8.2",
//                            @"smallvalue":@"3.3",
//                            @"unit":@"",
//                            }];
}

- (void)updateDataWithDictionary:(NSDictionary *)dataDictionary;
{
    self.dataDictionary = dataDictionary;
    [self.tableView reloadData];
}


- (void)createTableView{
    [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellName];
    [self.tableView registerNib:[UINib nibWithNibName:headerName bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:headerName];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataDictionary[@"timesArray"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataDictionary[@"itemsTitle"] count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 66;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    JJTongji0HeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerName];
    headerView.label0.text = self.dataDictionary[@"timesArray"][section];
    return headerView;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10.f;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return nil;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JJTongji0Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
//    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    
    NSString *str0 = self.dataDictionary[@"itemsTitle"][indexPath.row];
    str0 = [str0 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
//    str0 = [str0 stringByReplacingOccurrencesOfString:@")" withString:@""];
//    str0 = [str0 stringByReplacingOccurrencesOfString:@"null" withString:@""];

    cell.label0.text = str0;
    cell.label1.text = JJSTRING(self.dataDictionary[@"dataMAX"][indexPath.row][indexPath.section]);
    cell.label2.text = JJSTRING(self.dataDictionary[@"dataMIN"][indexPath.row][indexPath.section]);
    cell.label3.text = JJSTRING(self.dataDictionary[@"dataAVG"][indexPath.row][indexPath.section]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    
//    if (indexPath.row == 3) {
//        UIViewController *controller = [[UIViewController alloc] init];
//        controller.hidesBottomBarWhenPushed = 1;
//        [self.navigationController pushViewController:controller animated:1];
//
//        controller.view.backgroundColor = [UIColor orangeColor];
//        return;
//    }
   
}


@end


