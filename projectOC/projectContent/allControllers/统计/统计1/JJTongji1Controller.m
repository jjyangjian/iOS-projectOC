//
//  JJTongji1Controller.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/13.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJTongji1Controller.h"

#import "JJTongji1Cell.h"


@interface JJTongji1Controller ()


@property (nonatomic,strong)NSMutableArray *cellInfoArray;
//@property (nonatomic,strong)NSArray <NSString *>*keyArray;


@property (nonatomic,strong)NSArray *titleInfoArray;

@property (nonatomic,strong)NSArray *dataArray;

//@property (nonatomic)long index_row;



@end

@implementation JJTongji1Controller

static NSString *cellName = @"JJTongji1Cell";

- (instancetype)initWithTitleInfoArray:(NSArray *)titleInfoArray
{
    self = [super init];
    if (self) {
        self.titleInfoArray = titleInfoArray;
        
        self.cellInfoArray = [NSMutableArray new];
//        self.index_row = 0;

//        for (int i = 0; i < titleInfoArray.count; i ++) {
////            if ([titleInfoArray[i][@"field"] hasSuffix:@"time"]) {
////                self.timekey = titleInfoArray[i][@"field"];
////                self.timetitle = titleInfoArray[i][@"title"];
////            }else{
//            NSMutableDictionary *cellInfoDic = [[NSMutableDictionary alloc] initWithDictionary:titleInfoArray[i]];
//            JJTongji1Cell *cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
//            cellInfoDic[@"cell"] = cell;
//            [self.cellInfoArray addObject:cellInfoDic];
////            }
//        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
}

- (void)rightBarButtonItemAction:(UIBarButtonItem *)buttonItem{
    //    JJDitushebeiController *controller = [[JJDitushebeiController alloc] init];
    //    controller.hidesBottomBarWhenPushed = 1;
    //    [self.navigationController pushViewController:controller animated:1];
}



- (void)updateDataWithDictionary:(NSDictionary *)dataDictionary;
{
    
//    self.index_row = 0;
    [self.cellInfoArray removeAllObjects];
    for (int cellIndex = 0; cellIndex < [dataDictionary[@"itemsTitle"] count]; cellIndex ++) {
        NSMutableDictionary *cellInfoDic = [[NSMutableDictionary alloc] init];//WithDictionary:dataDictionary[@"itemsTitle"][cellIndex]];
        JJTongji1Cell *cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
        cellInfoDic[@"cell"] = cell;
        
        NSArray *strs = [dataDictionary[@"itemsTitle"][cellIndex] componentsSeparatedByString:@" "];
        cell.label0.text = strs[0];

        NSString *unit = @"";
        if (strs.count > 1) {
            unit = strs[1];
            unit = [unit stringByReplacingOccurrencesOfString:@"(" withString:@""];
            unit = [unit stringByReplacingOccurrencesOfString:@")" withString:@""];
            unit = [unit stringByReplacingOccurrencesOfString:@"null" withString:@""];
        }
        
        NSMutableArray *valueArray = [[NSMutableArray alloc] init];
        
//        CGFloat minLabelValue = 0.f;
//        CGFloat maxLabelValue = 0.f;

        for (int valueIndex = 0; valueIndex < [dataDictionary[@"timesArray"] count]; valueIndex ++) {
            NSMutableDictionary *valueDic = [[NSMutableDictionary alloc] init];
            valueDic[@"xvalue"] = dataDictionary[@"timesArray"][valueIndex];
            valueDic[@"avgyvalue"] = JJSTRING(dataDictionary[@"dataAVG"][cellIndex][valueIndex]);
            valueDic[@"minyvalue"] = JJSTRING(dataDictionary[@"dataMIN"][cellIndex][valueIndex]);
            valueDic[@"maxyvalue"] = JJSTRING(dataDictionary[@"dataMAX"][cellIndex][valueIndex]);
            [valueArray addObject:valueDic];
            
//            if (valueIndex == 0) {
//                minLabelValue = floor([dataDictionary[@"dataMIN"][cellIndex][valueIndex] floatValue]);
//                maxLabelValue = ceil([dataDictionary[@"dataMAX"][cellIndex][valueIndex] floatValue]);
//            }else{
//                if (floor([dataDictionary[@"dataMIN"][cellIndex][valueIndex] floatValue]) < minLabelValue) {
//                    minLabelValue = floor([dataDictionary[@"dataMIN"][cellIndex][valueIndex] floatValue]);
//                }
//                if (ceil([dataDictionary[@"dataMAX"][cellIndex][valueIndex] floatValue]) > maxLabelValue) {
//                    maxLabelValue = ceil([dataDictionary[@"dataMAX"][cellIndex][valueIndex] floatValue]);f
//                }
//            }
        }
        [cell setChartInfoWithMinValue:0.f MaxValue:0.f Unit:unit];
        
        [cell updateDataWithValueArray:valueArray];
        
        [self.cellInfoArray addObject:cellInfoDic];
    }
    [self.tableView reloadData];
}

- (void)createTableView{
    [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellName];
    
}


//- (void)updateDataWithArray:(NSArray *)array{
//    self.dataArray = array;
//    [self.tableView reloadData];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 5;
    return self.cellInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  self.cellInfoArray[indexPath.row][@"cell"];
    JJTongji1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    //    [cell loadDataWithDictionary:@{}];
//    cell.label0.text = [NSString stringWithFormat:@"%@(%@)",self.dataArray[indexPath.row][@"key"],self.dataArray[indexPath.row][@"name"]];
//    cell.label1.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"value"]];
//    cell.label2.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"unit"]];
    return cell;
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
