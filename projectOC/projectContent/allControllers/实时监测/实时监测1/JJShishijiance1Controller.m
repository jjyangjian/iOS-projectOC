//
//  JJShishijiance1Controller.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/11.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJShishijiance1Controller.h"
@interface JJShishijiance1Controller ()

@property (nonatomic,strong)NSMutableDictionary *cellDictionary;
@property (nonatomic,strong)NSArray <NSString *>*keyArray;

@end

@implementation JJShishijiance1Controller

static NSString *cellName = @"JJShishijiance1Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
}

- (void)createTableView{
    [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellName];

}

- (void)updateDataWithArray:(NSArray *)array {
    BOOL refresh = 0;
    if (!self.cellDictionary) {
        refresh = 1;
        self.cellDictionary = [NSMutableDictionary new];
        NSMutableArray *mKeyArray = [NSMutableArray new];
        for (int i = 0; i < array.count; i ++) {
            [mKeyArray addObject:array[i][@"key"]];
        }
        self.keyArray = mKeyArray;
    }
//    CGFloat minLabelValue = 0.f;
//    CGFloat maxLabelValue = 0.f;
    
    for (int i = 0; i < array.count; i ++) {
        JJShishijiance1Cell *cell = self.cellDictionary[array[i][@"key"]];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
            self.cellDictionary[array[i][@"key"]] = cell;
            
            NSString *unit = @"";
            unit = JJSTRING(array[i][@"unit"]);
            unit = [unit stringByReplacingOccurrencesOfString:@" " withString:@""];
            unit = [unit stringByReplacingOccurrencesOfString:@"(" withString:@""];
            unit = [unit stringByReplacingOccurrencesOfString:@")" withString:@""];
            unit = [unit stringByReplacingOccurrencesOfString:@"null" withString:@""];
            [cell setChartInfoWithMinValue:-1.f MaxValue:7.f Unit:unit];

        }
        
        
        [cell updateDataWithDictionary:array[i]];
    }
    
    
    
    
    if (refresh) {
        [self.tableView reloadData];
    }
}




- (void)rightBarButtonItemAction:(UIBarButtonItem *)buttonItem{
    //    JJDitushebeiController *controller = [[JJDitushebeiController alloc] init];
    //    controller.hidesBottomBarWhenPushed = 1;
    //    [self.navigationController pushViewController:controller animated:1];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellDictionary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    JJShishijiance1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
//    //    [cell loadDataWithDictionary:@{}];
  return  self.cellDictionary[self.keyArray[indexPath.row]];
//    return cell;
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

@end
