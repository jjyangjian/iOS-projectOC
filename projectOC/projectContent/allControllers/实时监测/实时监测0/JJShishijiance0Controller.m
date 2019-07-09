//
//  JJShishijiance0Controller.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/5/16.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJShishijiance0Controller.h"
#import "JJShishijiance0Cell.h"

@interface JJShishijiance0Controller ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
,UICollectionViewDelegateFlowLayout
>

@property (nonatomic,strong)NSArray *dataArray;

@end

@implementation JJShishijiance0Controller

static NSString *cellName = @"JJShishijiance0Cell";
static int cellWidth = 80.f;
static int cellHeight = 70.f;


-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(cellWidth, cellHeight);
    // 设置最小行间距
    layout.minimumLineSpacing = 0;
    // 设置垂直间距
    layout.minimumInteritemSpacing = 0;
    // 设置边缘的间距，默认是{0，0，0，0}
//    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = UIColor.whiteColor;
    self.collectionView.backgroundColor = UIColor.whiteColor;

    [self createCollectionView];
}

- (void)createCollectionView{
    cellWidth = SIZE.width / 2.f ;
    [self.collectionView registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellName];
}


- (void)updateDataWithArray:(NSArray *)array{
    self.dataArray = array;
//    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(cellWidth, cellHeight);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JJShishijiance0Cell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    
    //    [cell loadDataWithDictionary:@{}];
    //    cell.label0.text = [NSString stringWithFormat:@"%@(%@)",self.dataArray[indexPath.row][@"name"],self.dataArray[indexPath.row][@"key"]];
    cell.label0.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"name"]];
    
    cell.label1.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"value"]];
    
    NSString *unit = @"";
    unit = JJSTRING(self.dataArray[indexPath.row][@"unit"]);
    unit = [unit stringByReplacingOccurrencesOfString:@" " withString:@""];
    unit = [unit stringByReplacingOccurrencesOfString:@"(" withString:@""];
    unit = [unit stringByReplacingOccurrencesOfString:@")" withString:@""];
    unit = [unit stringByReplacingOccurrencesOfString:@"null" withString:@""];
    cell.label2.text = unit;
//    cell.label3.text = JJSTRING(self.dataArray[indexPath.row][@"time"]);
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
