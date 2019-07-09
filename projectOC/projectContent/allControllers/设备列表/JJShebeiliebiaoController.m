//
//  JJShebeiliebiaoController.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/9.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJShebeiliebiaoController.h"


//cell
#import "JJShebeiliebiaoCell.h"

//设备详情
#import "JJShebeixiangqingController.h"

//地图内展示设备
#import "JJDitushebeiController.h"


//实时监测
#import "JJShishijianceController.h"

//历史
#import "JJLishijiluController.h"

//报警记录
#import "JJBaojingjiluController.h"

//统计
#import "JJTongjiController.h"

#import "JJTabbarController.h"

@interface JJShebeiliebiaoController ()

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation JJShebeiliebiaoController

static NSString *cellName = @"JJShebeiliebiaoCell";

- (instancetype)initWithSelectedDeviceBlock:(JJShebeiliebiaoControllerSelectedDeviceBlock)block;
{
    self = [super init];
    if (self) {
        self.selectedDeviceBlock = block;
        self.type = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设备列表";
    self.tableView.delaysContentTouches = 0;

//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        // Fallback on earlier versions
//    }3

    // Uncomment the following line to preserve selection between presentations.
//    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellName];
    
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(rightBarButtonItemClick:)];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"shebei_earth"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction:)];
    
//    self.dataArray = [[NSMutableArray alloc] initWithArray:[JJExtern sharedJJ].devices];
//    [self.tableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.dataArray = [[NSMutableArray alloc] initWithArray:[JJExtern sharedJJ].devices];
    [self.tableView reloadData];
}

- (void)rightBarButtonItemClick:(UIBarButtonItem *)buttonItem{
//    JJDitushebeiController *controller = [[JJDitushebeiController alloc] init];
//    controller.hidesBottomBarWhenPushed = 1;
//    [self.navigationController pushViewController:controller animated:1];
    
    self.navigationController.navigationBar.userInteractionEnabled = 0;
    
    [JJExtern showXuanzeshebeiViewForViewController:self andSelectedDevice:^(NSDictionary * _Nonnull device) {
        
    } andHideBlock:^{
        self.navigationController.navigationBar.userInteractionEnabled = 1;
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JJShebeiliebiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
//    [cell loadDataWithDictionary:@{}];
    JJWEAKSELF;
    [cell loadDataWithDevice:self.dataArray[indexPath.row] buttonBlock:^(long buttonTag) {
        [weakself guanzhu:indexPath.row];
    }];
    
    return cell;
}

- (void)guanzhu:(long)index{
    JJWEAKSELF
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [controller addAction:[UIAlertAction actionWithTitle:@"关注" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [JJExtern sharedJJ].currentDeviceID = weakself.dataArray[index][@"eqId"];
        [JJExtern sharedJJ].currentDevice = weakself.dataArray[index];
        
        if ([weakself.tabBarController isKindOfClass:[JJTabbarController class]]) {
            [((JJTabbarController *)weakself.tabBarController) qiehuanShebei];
        }
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:controller animated:1 completion:^{
    }];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    return;
    if (self.type == 0) {
        if (self.selectedDeviceBlock) {
            [JJExtern sharedJJ].currentDeviceID = self.dataArray[indexPath.row][@"eqId"];
            [JJExtern sharedJJ].currentDevice = self.dataArray[indexPath.row];
            self.selectedDeviceBlock(self.dataArray[indexPath.row]);
            [self.navigationController popViewControllerAnimated:1];
        }
    }else if (self.type == 1){
        JJWEAKSELF
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"实时监测" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [JJExtern sharedJJ].currentDeviceID = weakself.dataArray[indexPath.row][@"eqId"];
            [JJExtern sharedJJ].currentDevice = weakself.dataArray[indexPath.row];
            
            [weakself shishijiance];
        }]];
        [controller addAction:[UIAlertAction actionWithTitle:@"历史记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [JJExtern sharedJJ].currentDeviceID = weakself.dataArray[indexPath.row][@"eqId"];
            [JJExtern sharedJJ].currentDevice = weakself.dataArray[indexPath.row];

            [weakself lishijilu];
        }]];
        [controller addAction:[UIAlertAction actionWithTitle:@"数据统计" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [JJExtern sharedJJ].currentDeviceID = weakself.dataArray[indexPath.row][@"eqId"];
            [JJExtern sharedJJ].currentDevice = weakself.dataArray[indexPath.row];

            [weakself tongji];
        }]];
        [controller addAction:[UIAlertAction actionWithTitle:@"报警记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [JJExtern sharedJJ].currentDeviceID = weakself.dataArray[indexPath.row][@"eqId"];
            [JJExtern sharedJJ].currentDevice = weakself.dataArray[indexPath.row];

            [weakself baojingjilu];
        }]];
        [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:controller animated:1 completion:^{
        }];
    }else{
    }
    
//    JJShebeixiangqingController *controller = [[JJShebeixiangqingController alloc] init];
//    controller.hidesBottomBarWhenPushed = 1;
//    [self.navigationController pushViewController:controller animated:1];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)shishijiance{
    JJShishijianceController *controller = [[JJShishijianceController alloc] init];
    [self.navigationController pushViewController:controller animated:1];
}

//- (void)lishijilu{
//    JJLishijiluController *controller = [[JJLishijiluController alloc] init];
//    [self.navigationController pushViewController:controller animated:1];
//}
//历史列表-标题/api/history/data/list/title
- (void)lishijilu{
    //    "username":"zyf3","password":"123"
    NSDictionary *parameter = @{
                                @"historyDataType":@"1",
                                @"eqId":[JJExtern sharedJJ].currentDeviceID,
                                };
    JJWEAKSELF
    [self showHudInView:self.view hint:@""];
    [JJDownload getData_Method:@"GET"
                  andURLString:JJURLSTRING_api_history_data_list_title
                  andParameter:parameter
                  andNeedToken:1
               andSuccessBlock: ^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
                   [weakself hideHud];
                   [weakself showHint:message];
                   NSLog(@"%@",responseObject);
                   JJLishijiluController *controller = [[JJLishijiluController alloc] initWithTitleInfoArray:responseObject[@"content"]];
                   [self.navigationController pushViewController:controller animated:1];
                   
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   [weakself hideHud];
                   [weakself showHint:error.domain];
                   NSLog(@"%@",error);
               }];
}



- (void)tongji{
    NSDictionary *parameter = @{
                                @"historyDataType":@"3",
                                @"eqId":[JJExtern sharedJJ].currentDeviceID,
                                };
    JJWEAKSELF
    [self showHudInView:self.view hint:@""];
    [JJDownload getData_Method:@"GET"
                  andURLString:JJURLSTRING_api_history_data_list_title
                  andParameter:parameter
                  andNeedToken:1
               andSuccessBlock: ^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
                   [weakself hideHud];
                   [weakself showHint:message];
                   NSLog(@"%@",responseObject);
                   JJTongjiController *controller = [[JJTongjiController alloc] initWithTitleInfoArray:responseObject[@"content"]];
                   [self.navigationController pushViewController:controller animated:1];
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   [weakself hideHud];
                   [weakself showHint:error.domain];
                   NSLog(@"%@",error);
               }];
}

- (void)baojingjilu{
    
    NSDictionary *parameter = @{
                                @"historyDataType":@"2",
                                @"eqId":[JJExtern sharedJJ].currentDeviceID,
                                };
    JJWEAKSELF
    [self showHudInView:self.view hint:@""];
    [JJDownload getData_Method:@"GET"
                  andURLString:JJURLSTRING_api_history_data_list_title
                  andParameter:parameter
                  andNeedToken:1
               andSuccessBlock: ^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
                   [weakself hideHud];
                   [weakself showHint:message];
                   NSLog(@"%@",responseObject);
                   JJBaojingjiluController *controller = [[JJBaojingjiluController alloc] init];
                   [self.navigationController pushViewController:controller animated:1];
                   
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   [weakself hideHud];
                   [weakself showHint:error.domain];
                   NSLog(@"%@",error);
               }];
    
    
}

@end
