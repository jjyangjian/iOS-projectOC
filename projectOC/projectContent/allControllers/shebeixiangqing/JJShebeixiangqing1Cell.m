//
//  JJShebeixiangqing1Cell.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/3/28.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJShebeixiangqing1Cell.h"

#import "projectOC-Bridging-Header.h"

@interface JJShebeixiangqing1Cell ()


@property (nonatomic,strong)PieChartView *pieChartView;

@end

@implementation JJShebeixiangqing1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self createPieChart];
    
}

- (void)createPieChart{
    // 初始化
    _pieChartView = [[PieChartView alloc] initWithFrame:CGRectZero];
    _pieChartView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pieChartView];
    self.pieChartView.frame = CGRectMake(0, 0, SIZE.width , SIZE.width);
//    -------------------- 饼状图的配置----------------------
    
    // 动画[self.pieChartView animateWithXAxisDuration:1];
    [self.pieChartView animateWithYAxisDuration:1];
    
    // 饼状图距离边缘的间隙
    [_pieChartView setExtraOffsetsWithLeft:35 top:10 right:35 bottom:10];
    
    // 是否根据所提供的数据, 将显示数据转换为百分比格式
    _pieChartView.usePercentValuesEnabled = NO;
    
    // 拖拽饼状图后是否有惯性效果
    _pieChartView.dragDecelerationEnabled = YES;
    
    // 是否显示区块文本
    _pieChartView.drawCenterTextEnabled = NO;
    
    // 饼状图是否是空心
    _pieChartView.drawHoleEnabled = NO;
    
    // 空心半径占比
    _pieChartView.holeRadiusPercent = 0.8;
    
    // 空心颜色
    _pieChartView.holeColor = [UIColor clearColor];
    
    // 半透明空心半径占比
    _pieChartView.transparentCircleRadiusPercent = 0.52;
    
    // 半透明空心的颜色
    _pieChartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];
    
    //  设置空心文字
    if (_pieChartView.isDrawHoleEnabled == YES) {
        // 是否显示中间文字
        _pieChartView.drawCenterTextEnabled = YES;
        //  普通文本//  中间文字
        _pieChartView.centerText = @"西瓜";
        //  富文本
        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"西瓜详情"];
        [centerText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                                    NSForegroundColorAttributeName: [UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.f]}
                            range:NSMakeRange(0, centerText.length)];
        _pieChartView.centerAttributedText = centerText;

    }
    //   设置饼状图描述
    //  是否开启描述label
    _pieChartView.chartDescription.enabled = NO;
//     _pieChartView.descriptionFont = [UIFont systemFontOfSize:10];
//     _pieChartView.descriptionTextColor = [UIColor grayColor];
//    self.pieChartView.font
    
    
//    -------------------------legend图例的属性配置-------------------------------
    // 是否开启图例_pieChartView.legend.enabled = NO;
    // 图例在饼状图中的大小占比, 这会影响图例的宽高
    _pieChartView.legend.maxSizePercent = 1;
    //  文本间隔
    _pieChartView.legend.formToTextSpace = 5;
    //   图例间隔大小
    _pieChartView.legend.yEntrySpace = 5;//10;
    _pieChartView.legend.xEntrySpace = 6;
    //   字体大小
    _pieChartView.legend.font = [UIFont systemFontOfSize:20];
    //  字体颜色
    _pieChartView.legend.textColor = [UIColor grayColor];
    //   图例在饼状图中的位置
//    _pieChartView.legend.position = ChartLegendPositionBelowChartCenter;
    self.pieChartView.legend.horizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.pieChartView.legend.verticalAlignment = UIControlContentVerticalAlignmentCenter;

    
    
    
    //    图示样式: 方形、线条、圆形
    _pieChartView.legend.form = ChartLegendFormSquare;
    //    图示大小
    _pieChartView.legend.formSize =20;
//    ------------------------饼状图的数据配置----------------------
    //   每个区块的金额数
    NSMutableArray* moneyArray =[NSMutableArray arrayWithArray:@[@33.33,@33,@12,@50.66,@10]];
    //  每个区块的颜色
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObject:[UIColor colorWithRed:141/255.f green:116/255.f blue:244/255.f alpha:1]];
    [colors addObject:[UIColor colorWithRed:245/255.f green:101/255.f blue:103/255.f alpha:1]];
    // 每个区块的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for(int i =0; i < moneyArray.count; i++) {
        double randomVal = [moneyArray[i]doubleValue];
//        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:randomVal xIndex:i];
//        ChartDataEntry * entry = [[ChartDataEntry alloc] initWithValue:randomVal xIndex:i];
//        ChartDataEntry* entry = [[ChartDataEntry alloc] initWithX:iy:randomVal];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:randomVal];
        [yVals addObject:entry];
        
        
        
        
        
    }
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:yVals label:@""];
    
    // 是否绘制显示数据dataSet.drawValuesEnabled = NO;
    // 区块颜色
    dataSet.colors= colors;
    // 相邻区块之间的间距
    dataSet.sliceSpace=3;
    // 选中区块时, 放大的半径
    dataSet.selectionShift=12;
    // 名称位置
    dataSet.xValuePosition = PieChartValuePositionInsideSlice;
    // 数据位置
    // 数据与区块之间的用于指示的折线样式
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;
    // 折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
    dataSet.valueLinePart1OffsetPercentage = 0.85f;
    // 折线中第一段长度占比
    dataSet.valueLinePart1Length = 0.4;
    // 折线中第二段长度最大占比
    dataSet.valueLinePart2Length = 1.f;
    // 折线的粗细\
    dataSet.valueLineWidth=.6;
    // 折线颜色
    dataSet.valueLineColor= [UIColor orangeColor];
    dataSet.valueLineVariableLength = YES;
    dataSet.valueTextColor= [UIColor blackColor];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    //NSNumberFormatterPercentStyle; [formattersetPositiveFormat:@"###,##0.00;"];
    // 小数位数
    formatter.maximumFractionDigits = 2;
    formatter.multiplier=@1.f;
    formatter.paddingPosition = kCFNumberFormatterPadBeforeSuffix;
    // 数据设置上去
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    _pieChartView.data = data;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
