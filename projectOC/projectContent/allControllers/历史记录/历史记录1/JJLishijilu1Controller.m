//
//  JJLishijilu1Controller.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/12.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJLishijilu1Controller.h"

#import "JJLishijilu1Cell.h"


@interface JJLishijilu1Controller ()

@property (nonatomic,strong)NSMutableArray *cellInfoArray;
@property (nonatomic,strong)NSArray <NSString *>*keyArray;

@property (nonatomic,strong)NSArray *titleInfoArray;
@property (nonatomic,strong)NSMutableArray *dataArray;


@property (nonatomic,strong)NSString *timekey;
@property (nonatomic,strong)NSString *timetitle;

@end

@implementation JJLishijilu1Controller

static NSString *cellName = @"JJLishijilu1Cell";


- (instancetype)initWithTitleInfoArray:(NSArray *)titleInfoArray
{
    self = [super init];
    if (self) {
        self.titleInfoArray = titleInfoArray;
        
        self.cellInfoArray = [NSMutableArray new];
        for (int i = 0; i < titleInfoArray.count; i ++) {
            if ([titleInfoArray[i][@"field"] hasSuffix:@"time"]) {
                self.timekey = titleInfoArray[i][@"field"];
                self.timetitle = titleInfoArray[i][@"title"];
            }else{
                NSMutableDictionary *cellInfoDic = [[NSMutableDictionary alloc] initWithDictionary:titleInfoArray[i]];
                JJLishijilu1Cell *cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
//                cell.label0.text = titleInfoArray[i][@"title"];
                cell.title = titleInfoArray[i][@"title"];
                cellInfoDic[@"cell"] = cell;
                [self.cellInfoArray addObject:cellInfoDic];
            }
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}

- (void)createTableView{
    [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellName];
}


- (void)updateDataWithArray:(NSArray *)dataArray;
{
    self.dataArray = [[NSMutableArray alloc] initWithArray:dataArray];

//    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    
    
    
    for (int cellIndex = 0; cellIndex < self.cellInfoArray.count; cellIndex ++) {
        NSString *key = self.cellInfoArray[cellIndex][@"field"];
        NSMutableArray *valueArray = [[NSMutableArray alloc] init];
        NSMutableDictionary *valueDic = [[NSMutableDictionary alloc] init];
        NSString *unit = @"";
        
//        CGFloat minLabelValue = 0.f;
//        CGFloat maxLabelValue = 0.f;

        
        for (int valueIndex = 0; valueIndex < dataArray.count; valueIndex ++) {
            valueDic[@"xvalue"] = dataArray[valueIndex][self.timekey];
            valueDic[@"yvalue"] = JJSTRING((dataArray[valueIndex][[NSString stringWithFormat:@"%@_d",key]]));
            [valueArray addObject:valueDic];
            
            if (valueIndex == 0) {
                unit =JJSTRING((dataArray[valueIndex][[NSString stringWithFormat:@"%@_u",key]]));
                //            NSString *unit = @"";
                //            unit = JJSTRING(array[i][@"unit"]);
                unit = [unit stringByReplacingOccurrencesOfString:@" " withString:@""];
                unit = [unit stringByReplacingOccurrencesOfString:@"(" withString:@""];
                unit = [unit stringByReplacingOccurrencesOfString:@")" withString:@""];
                unit = [unit stringByReplacingOccurrencesOfString:@"null" withString:@""];
            }
            
//            if (valueIndex == 0) {
//                minLabelValue = floor([valueDic[@"yvalue"] floatValue]);
//                maxLabelValue = ceil([valueDic[@"yvalue"] floatValue]);
//            }else{
//                if (floor([valueDic[@"yvalue"] floatValue]) < minLabelValue) {
//                    minLabelValue = floor([valueDic[@"yvalue"] floatValue]);
//                }
//                if (ceil([valueDic[@"yvalue"] floatValue]) > minLabelValue) {
//                    maxLabelValue = ceil([valueDic[@"yvalue"] floatValue]);
//                }
//            }
        }
        JJLishijilu1Cell *cell = self.cellInfoArray[cellIndex][@"cell"];
        [cell setChartInfoWithMinValue:0.f MaxValue:0.f Unit:unit];
        [cell updateDataWithValueArray:valueArray];
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
    return self.cellInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    JJShishijiance1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    //    //    [cell loadDataWithDictionary:@{}];
    return  self.cellInfoArray[indexPath.row][@"cell"];
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
