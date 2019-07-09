//
//  JJBaojingjilu1Controller.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/10.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJBaojingjilu1Controller.h"

#import "JJBaojingjilu1CollectionCell.h"

#import "JJBaojingjilu1DateDataManager.h"


#import <PGDatePicker.h>
#import <PGDatePicker/PGDatePickManager.h>

@interface JJBaojingjilu1Controller ()
<
PGDatePickerDelegate
,UICollectionViewDelegate,
UICollectionViewDataSource
,UICollectionViewDelegateFlowLayout
>

@property (nonatomic,strong)JJBaojingjilu1DateDataManager *dataManager;
@property (nonatomic,strong)NSArray *dataArray;

@property (nonatomic,strong)NSDate *selectDate;


@end

@implementation JJBaojingjilu1Controller

static NSString *cellName = @"JJBaojingjilu1CollectionCell";
static int cellHeight = 56.f;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createCollectionView];
    self.selectDate = [NSDate date];
    [self getData];
}

- (void)createCollectionView{
    
    if ((SIZE.width - 24) / 7.f > cellHeight) {
        cellHeight = SIZE.width / 7.f ;
    }
    
    [self.collectionView registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellName];
    
}

- (void)getData{
    if (!self.dataManager) {
        self.dataManager = [JJBaojingjilu1DateDataManager new];
    }
    
    //    self.label0.text = [JJDate getTimeTimeStringWithTimestampString:str andFormatString:@"yyyy年MM月"];
    JJWEAKSELF
    [self showHudInView:self.view hint:@""];
    [self.dataManager getDataWithDeviceID:[JJExtern sharedJJ].currentDeviceID TimestampString:[NSString stringWithFormat:@"%ld",(long)[self.selectDate timeIntervalSince1970]] Completion:^(NSString * _Nullable title, NSArray * _Nullable dataArray, NSError * _Nullable error, NSString * _Nullable message) {
        [self hideHud];
        [self showHint:message];
        if (!error) {
            weakself.label0.text = title;
            weakself.dataArray = dataArray;
            [weakself.collectionView reloadData];
        }else{
        }
    }];
}

- (void)setSelectDate:(NSDate *)selectDate{
    _selectDate = selectDate;
    [self.timeButton setTitle:[JJDate getTimeTimeStringWithTimestampString:[NSString stringWithFormat:@"%ld",(long)[selectDate timeIntervalSince1970]] andFormatString:@"yyyy-MM"] forState:UIControlStateNormal];
}






- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 100) {
        [self getData];
    }else if (sender.tag == 101){
        [self selectMonth];
    }else{
    }
}

- (void)selectMonth{
    
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = self;
    datePicker.datePickerMode = PGDatePickerModeYearAndMonth;
    datePicker.maximumDate = [NSDate date];
    [self presentViewController:datePickManager animated:false completion:nil];
    return;
    
//    PGDatePicker *datePicker = [[PGDatePicker alloc] init];
//    datePicker.delegate = self;
//    [datePicker setDate:[NSDate date] animated:1];
//    [self.view addSubview:datePicker];
}

#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSLog(@"dateComponents = %@", dateComponents);
    NSLog(@"dateComponents.date = %@", [NSString stringWithFormat:@"%04ld-%02ld",(long)dateComponents.year,(long)dateComponents.month]);
//    [JJDate getTimestampStringWithTimeString:[NSString stringWithFormat:@"%4d-%2d",dateComponents.year,dateComponents.month] andFormatString:@"yyyy-MM"];
    self.selectDate = [NSDate dateWithTimeIntervalSince1970:[JJDate getTimestampStringWithTimeString:[NSString stringWithFormat:@"%04ld-%02ld",(long)dateComponents.year,(long)dateComponents.month] andFormatString:@"yyyy-MM"]];
    
}


#pragma mark - collection



//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SIZE.width - 24) / 7.f - 2, cellHeight);
}



//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 1, 10, 1);
//}


//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataArray[indexPath.row][@"count"] intValue]) {
        //有问题,可被点击.
        return YES;
    }else{
        return 0;
    }
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JJBaojingjilu1CollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
//    @{@"day":[NSString stringWithFormat:@"%d",i + 1],
//      @"state":@"报警",
//      @"count":[NSString stringWithFormat:@"%d",count],
//      }
    cell.label0.text = self.dataArray[indexPath.row][@"day"];
    cell.label1.text = self.dataArray[indexPath.row][@"state"];
    cell.label2.text = self.dataArray[indexPath.row][@"count"];
    if ([self.dataArray[indexPath.row][@"count"] intValue]) {
        cell.label1.textColor = [UIColor redColor];
        cell.label2.textColor = [UIColor redColor];
    }else{
        cell.label1.textColor = [UIColor blackColor];
        cell.label2.textColor = [UIColor blackColor];
    }
    if ([self.dataArray[indexPath.row][@"empty"] boolValue]) {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return cell;
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
    
    if ([self.dataArray[indexPath.row][@"count"] intValue]) {
        //有问题,可被点击.
        if (self.detailBlock) {
            self.detailBlock(self.dataArray[indexPath.row][@"time"]);
        }
    }else{
    }
}





@end



/*
 */


