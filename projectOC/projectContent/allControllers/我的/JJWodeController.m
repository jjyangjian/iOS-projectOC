//
//  JJWodeController.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/9.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJWodeController.h"

#import "JJWodeCell0.h"
#import "JJWodeCell1.h"

#import "JJDengluController.h"

@interface JJWodeController ()

@property (nonatomic,strong) JJWodeCell0 *cell0;
@property (nonatomic,strong) NSArray *cellInfoArray;


@end

@implementation JJWodeController

static NSString *cellName0 = @"JJWodeCell0";
static NSString *cellName1 = @"JJWodeCell1";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.cellInfoArray = @[
                           @{@"title":@"系统消息",
                             @"imagename":@"main_wode_s.png",
                             },
//                           @{@"title":@"意见反馈",
//                             @"imagename":@"main_wode_s.png",
//                             },
//                           @{@"title":@"系统设置",
//                             @"imagename":@"main_wode_s.png",
//                             },
//                           @{@"title":@"使用帮助",
//                             @"imagename":@"main_wode_s.png",
//                             },
//                           @{@"title":@"关于",
//                             @"imagename":@"main_wode_s.png",
//                             },
//                           @{@"title":@"系统升级(苹果不具备升级功能)",
//                             @"imagename":@"main_wode_s.png",
//                             },
                           @{@"title":@"退出",
                             @"imagename":@"main_wode_s.png",
                             },
                           ];
    
    self.cell0 = [[[NSBundle mainBundle] loadNibNamed:cellName0 owner:nil options:nil] lastObject];
    [self.tableView registerNib:[UINib nibWithNibName:cellName1 bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellName1];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.cellInfoArray.count;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 100.f;
        }
    }
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return self.cell0;
        }
    }else if (indexPath.section == 1){
        JJWodeCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellName1 forIndexPath:indexPath];
        cell.textLabel.text = self.cellInfoArray[indexPath.row][@"title"];
        return cell;
    }
    return nil;
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

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        }
        if (indexPath.row == 1) {
            JJWEAKSELF
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退出登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [weakself logout];
            }]];
            [self presentViewController:alertController animated:1 completion:^{
            }];
        }
    }
//    JJWiFiController *controller = [[JJWiFiController alloc] init];
//    [self.navigationController pushViewController:controller animated:1];
}

- (void)logout{
    
    [JJExtern sharedJJ].token = @"";
    [UIApplication sharedApplication].keyWindow.rootViewController = [[JJDengluController alloc] init];
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 
 */

@end




