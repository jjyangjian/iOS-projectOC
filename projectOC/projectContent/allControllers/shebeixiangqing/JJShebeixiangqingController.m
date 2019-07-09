//
//  JJShebeixiangqingController.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/3/28.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJShebeixiangqingController.h"

#import "JJShebeixiangqing0Cell.h"
#import "JJShebeixiangqing1Cell.h"
#import "JJShebeixiangqing2Cell.h"
#import "JJShebeixiangqing3Cell.h"
#import "JJShebeixiangqing4Cell.h"
#import "JJShebeixiangqing5Cell.h"
#import "JJShebeixiangqing6Cell.h"



@interface JJShebeixiangqingController ()



@property (nonatomic,strong)JJShebeixiangqing0Cell *cell0;
@property (nonatomic,strong)JJShebeixiangqing1Cell *cell1;
@property (nonatomic,strong)JJShebeixiangqing2Cell *cell2;
@property (nonatomic,strong)JJShebeixiangqing3Cell *cell3;
@property (nonatomic,strong)JJShebeixiangqing4Cell *cell4;
@property (nonatomic,strong)JJShebeixiangqing5Cell *cell5;
@property (nonatomic,strong)JJShebeixiangqing6Cell *cell6;


@end

@implementation JJShebeixiangqingController

static NSString *cellName0 = @"JJShebeixiangqing0Cell";
static NSString *cellName1 = @"JJShebeixiangqing1Cell";
static NSString *cellName2 = @"JJShebeixiangqing2Cell";
static NSString *cellName3 = @"JJShebeixiangqing3Cell";
static NSString *cellName4 = @"JJShebeixiangqing4Cell";
static NSString *cellName5 = @"JJShebeixiangqing5Cell";
static NSString *cellName6 = @"JJShebeixiangqing6Cell";
static int cellCount = 7;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self careateCell];
    self.tableView.rowHeight = SIZE.height - IPHONE_SAFEAREA_NAVIGATIONBAR_HEIGHT;
    self.tableView.estimatedRowHeight = SIZE.height - IPHONE_SAFEAREA_NAVIGATIONBAR_HEIGHT;
    self.tableView.pagingEnabled = 1;
    
}

- (void)careateCell{
    self.cell0 = [[[NSBundle mainBundle] loadNibNamed:cellName0 owner:nil options:nil] lastObject];
    self.cell1 = [[[NSBundle mainBundle] loadNibNamed:cellName1 owner:nil options:nil] lastObject];
    self.cell2 = [[[NSBundle mainBundle] loadNibNamed:cellName2 owner:nil options:nil] lastObject];
    self.cell3 = [[[NSBundle mainBundle] loadNibNamed:cellName3 owner:nil options:nil] lastObject];
    self.cell4 = [[[NSBundle mainBundle] loadNibNamed:cellName4 owner:nil options:nil] lastObject];
    self.cell5 = [[[NSBundle mainBundle] loadNibNamed:cellName5 owner:nil options:nil] lastObject];
    self.cell6 = [[[NSBundle mainBundle] loadNibNamed:cellName6 owner:nil options:nil] lastObject];

    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @[self.cell0,
             self.cell1,
             self.cell2,
             self.cell3,
             self.cell4,
             self.cell5,
             self.cell6,
             ][indexPath.row];
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
