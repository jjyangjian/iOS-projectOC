//
//  JJShishijiance1Cell.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/11.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJShishijiance1Cell.h"

#import "projectOC-Bridging-Header.h"


@interface JJShishijiance1Cell ()
<
ChartViewDelegate
>

@property (nonatomic, strong) LineChartView *lineChartView;

@property (nonatomic, strong) LineChartData *data;

//@property (nonatomic, strong) LineChartDataSet *dataSet;
@property (nonatomic,strong)NSMutableArray *x_values;
//@property (nonatomic,strong)NSMutableArray *y_values;

//@property (nonatomic)CGFloat minLabelValue;
//@property (nonatomic)CGFloat maxLabelValue;

@property (nonatomic,strong)NSString *unit;


@end

@implementation JJShishijiance1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.x_values = [[NSMutableArray alloc] init];
    for (int i = 0; i < X_COUNT; i++) {
        [self.x_values addObject:[NSString stringWithFormat:@""]];
    }
//    self.y_values = [[NSMutableArray alloc] init];

    [self createLineChartView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setChartInfoWithMinValue:(CGFloat)minValue MaxValue:(CGFloat)maxValue Unit:(NSString *)unit;
{
    self.unit = unit;
    
    ChartYAxis *leftAxis = self.lineChartView.leftAxis;//获取左边Y轴
//    leftAxis.axisMinimum = minValue;//设置Y轴的最小值
//    leftAxis.axisMaximum = maxValue;//设置Y轴的最大值
    
    NSNumberFormatter *axisFormatter = [[NSNumberFormatter alloc] init];
//    //负数的后缀
//    axisFormatter.negativeSuffix = unit;
//    //正数的后缀
//    axisFormatter.positiveSuffix = unit;
//    axisFormatter.minimum = [NSNumber numberWithFloat:0.1];
        axisFormatter.numberStyle = NSNumberFormatterDecimalStyle;
//    [axisFormatter setPositiveFormat:@"#####0.00;"];

    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:axisFormatter];
}

- (void)updateDataWithDictionary:(NSDictionary *)dictionary{
    
    if (self.unit.length) {
        self.label0.text = [NSString stringWithFormat:@"%@(%@)",dictionary[@"name"],self.unit];
    }else{
        self.label0.text = [NSString stringWithFormat:@"%@",dictionary[@"name"]];
    }
    
//    if (!self.data) {
//        self.data  = [[LineChartData alloc] init];
//    }
    
    //x轴的设定展示
//    [self.x_values removeObjectAtIndex:0];
//    [self.x_values addObject:[JJDate getTimeTimeStringWithTimestampString:JJSTRING(dictionary[@"time"]) andFormatString:@"HH:mm:ss"]];
    [self.x_values addObject:dictionary[@"time"]];
    while (self.x_values.count > X_COUNT) {
        [self.x_values removeObjectAtIndex:0];
    }
    ((ChartIndexAxisValueFormatter *)(self.lineChartView.xAxis.valueFormatter)).values = self.x_values;
//    self.lineChartView.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:self.x_values];

    NSLog(@"%@",self.x_values);
    
    if (self.lineChartView.data.dataSetCount) {
        
//        if (floor([dictionary[@"value"] floatValue]) < self.minLabelValue) {
//            self.minLabelValue = floor([dictionary[@"value"] floatValue]);
//        }
//        if (ceil([dictionary[@"value"] floatValue]) < self.maxLabelValue) {
//            self.maxLabelValue = ceil([dictionary[@"value"] floatValue]);
//        }
        
        NSLog(@"%ld",(long)self.lineChartView.data.entryCount);

        LineChartDataSet *dataSet = (LineChartDataSet *)self.lineChartView.data.dataSets[0];
        NSMutableArray <ChartDataEntry *>*y_values = [[NSMutableArray alloc] initWithArray:dataSet.values];
        if (!(y_values[0].x > 0) ) {
            [y_values removeObjectAtIndex:0];
        }
        for (int i = 0; i < y_values.count; i ++) {
            ChartDataEntry *entry = y_values[i];
            entry.x -= 1;
        }
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:X_COUNT - 1 y:[dictionary[@"value"] floatValue]];

        [y_values addObject:entry];

        dataSet.values = y_values;
        
        [self.lineChartView.data notifyDataChanged];
        [self.lineChartView notifyDataSetChanged];
        
        NSLog(@"%ld",(long)self.lineChartView.data.entryCount);

    }else{
        LineChartDataSet *dataSet = [self createDataSet];
        NSMutableArray <ChartDataEntry *>*y_values = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < y_values.count; i ++) {
            ChartDataEntry *entry = y_values[i];
            entry.x -= 1;
        }
        
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:X_COUNT - 1 y:[dictionary[@"value"] floatValue]];
        NSLog(@"%f,%f",entry.x,entry.y);
        
//        self.minLabelValue = floor(entry.y);
//        self.maxLabelValue = ceil(entry.y);
        
        [y_values addObject:entry];
        dataSet.values = y_values;
        self.data = [[LineChartData alloc] initWithDataSets:@[dataSet,[self createFillDataSet]]];
        self.lineChartView.data = self.data;
        [self.lineChartView animateWithXAxisDuration:0.f];

    }
    
//    ChartYAxis *leftAxis = self.lineChartView.leftAxis;//获取左边Y轴
//    leftAxis.axisMinimum = self.minLabelValue - 1.f;//设置Y轴的最小值
//    leftAxis.axisMaximum = self.maxLabelValue + 1.f;//设置Y轴的最大值

    
    return;
//    LineChartDataSet *dataSet = nil;
//    NSMutableArray <ChartDataEntry *>*y_values = [[NSMutableArray alloc] init];
//    if (!self.lineChartView.data.entryCount) {
//        dataSet = [self createDataSet];
////        NSMutableArray <ChartDataEntry *>*y_values = [[NSMutableArray alloc] init];
//    }else{
//        dataSet = (LineChartDataSet *)self.lineChartView.data.dataSets[0];
//        NSMutableArray <ChartDataEntry *>*y_values = [[NSMutableArray alloc] initWithArray:dataSet.values];
//    }

}

- (LineChartDataSet *)createDataSet{
    //        LineChartDataSet *dataSet = [[LineChartDataSet alloc] initWithValues:y_values label:@"fuck"];
    LineChartDataSet *dataSet = [[LineChartDataSet alloc] init];//WithValues:y_values];
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"#####0.00;"];
    
    dataSet.valueFormatter = [[ChartDefaultValueFormatter alloc] initWithFormatter:formatter];

    
    dataSet.label = self.label0.text;
    dataSet.formSize = 13.f;
    //设置折线的样式
    dataSet.lineWidth = 1.0/[UIScreen mainScreen].scale;//折线宽度
    dataSet.drawValuesEnabled = YES;//是否在拐点处显示数据
    dataSet.valueColors = @[[UIColor brownColor]];//折线拐点处显示数据的颜色
    [dataSet setColor:[self colorWithHexString:@"#007FFF"]];//折线颜色
    dataSet.drawFilledEnabled = NO;//是否开启绘制阶梯样式的折线图
    
    //折线拐点样式
    dataSet.drawCirclesEnabled = 1;//是否绘制拐点
    dataSet.circleRadius = 2.0f;//拐点半径
    dataSet.circleColors = @[[UIColor brownColor]];//拐点颜色
    //拐点中间的空心样式
//    dataSet.drawCircleHoleEnabled = YES;//是否绘制中间的空心
//    dataSet.circleHoleRadius = 2.0f;//空心的半径
//    dataSet.circleHoleColor = [UIColor blackColor];//空心的颜色
    
    //第二种填充样式:渐变填充
    dataSet.drawFilledEnabled = YES;//是否填充颜色
    NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,
                                (id)[ChartColorTemplates colorFromString:@"#FF007FFF"].CGColor];
    CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
    dataSet.fillAlpha = 0.3f;//透明度
    dataSet.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
    CGGradientRelease(gradientRef);//释放gradientRef
    
    //点击选中拐点的交互样式
    dataSet.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
    dataSet.highlightColor = [self colorWithHexString:@"#c83c23"];//点击选中拐点的十字线的颜色
    dataSet.highlightLineWidth = 1.0/[UIScreen mainScreen].scale;//十字线宽度
    dataSet.highlightLineDashLengths = @[@5, @5];//十字线的虚线样式
    return dataSet;
}

- (LineChartDataSet *)createFillDataSet{
    //        LineChartDataSet *dataSet = [[LineChartDataSet alloc] initWithValues:y_values label:@"fuck"];
    NSMutableArray <ChartDataEntry *>*y_values = [[NSMutableArray alloc] init];
    for (int i = 0; i < X_COUNT; i ++) {
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:0.f];
        [y_values addObject:entry];
    }
    ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:(X_COUNT - 1) + X_COUNT / 10.f y:0.f];
    [y_values addObject:entry];
    LineChartDataSet *dataSet = [[LineChartDataSet alloc] initWithValues:y_values label:@""];
    dataSet.formSize = 13.f;
    //设置折线的样式
    dataSet.lineWidth = 0.0/[UIScreen mainScreen].scale;//折线宽度
    dataSet.drawValuesEnabled = 0;//是否在拐点处显示数据
    dataSet.valueColors = @[[UIColor clearColor]];//折线拐点处显示数据的颜色
    [dataSet setColor:[UIColor clearColor]];//折线颜色
    
    dataSet.drawCirclesEnabled = NO;//是否绘制拐点

//    dataSet.drawCircleHoleEnabled = 0;//是否绘制中间的空心

    
    //点击选中拐点的交互样式
    dataSet.highlightEnabled = 0;//选中拐点,是否开启高亮效果(显示十字线)
    return dataSet;
}

- (void)createLineChartView{
    
    //添加LineChartView
    self.lineChartView = [[LineChartView alloc] init];
    self.lineChartView.delegate = self;//设置代理
    [self addSubview:self.lineChartView];
    //    [self.lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width-20, 300));
    //        make.center.mas_equalTo(self.view);
    //    }];
    self.lineChartView.frame = CGRectMake(0, 32, SIZE.width , 200.f);
    //基本样式
    self.lineChartView.backgroundColor =  [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
    self.lineChartView.noDataText = @"暂无数据";
    //交互样式
    self.lineChartView.scaleYEnabled = NO;//取消Y轴缩放
    self.lineChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    self.lineChartView.dragEnabled = YES;//启用拖拽图标
    self.lineChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    self.lineChartView.dragDecelerationFrictionCoef = 0.5f;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
//    self.lineChartView.pinchZoomEnabled = 0;
    
    
    
    //X轴样式
    ChartXAxis *xAxis = self.lineChartView.xAxis;
    xAxis.labelFont = [UIFont systemFontOfSize:9.f];
    xAxis.granularityEnabled = 1;//粒度,禁止自行添加数值
    xAxis.centerAxisLabelsEnabled = 0;
//    xAxis. = 1;
    xAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    //    xAxis.spaceBetweenLabels = 4;//设置label间隔
    xAxis.spaceMin = 0;
    self.lineChartView.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:self.x_values];
    
    xAxis.labelTextColor = [self colorWithHexString:@"#057748"];//label文字颜色
    //Y轴样式
    self.lineChartView.rightAxis.enabled = NO;//不绘制右边轴
    ChartYAxis *leftAxis = self.lineChartView.leftAxis;//获取左边Y轴
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//Y轴线宽
    leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
    
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.labelTextColor = [self colorWithHexString:@"#057748"];//文字颜色
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    //网格线样式
    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    
    leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
//    leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
    
//        leftAxis.min = NO;//是否只显示最大值和最小值
//        leftAxis.startAtZeroEnabled = YES;//从0开始绘制
    
//    leftAxis.drawZeroLineEnabled = 0;
    
    leftAxis.minWidth = 30.f;
    leftAxis.maxWidth = 30.f;
    
    leftAxis.spaceTop = 0.35;

//    leftAxis.axisMinimum = 0;//设置Y轴的最小值
//    leftAxis.axisMaximum = 10;//设置Y轴的最大值
    
    
//    NSNumberFormatter *axisFormatter = [[NSNumberFormatter alloc] init];
//    //负数的后缀
//    axisFormatter.negativeSuffix = @" %";
//    //正数的后缀
//    axisFormatter.positiveSuffix = @" %";
//    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:axisFormatter];
    
    //添加限制线
//    ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
//    limitLine.lineWidth = 2;
//    limitLine.lineColor = [UIColor greenColor];
//    limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
//    limitLine.labelPosition = ChartLimitLabelPositionRightTop;//位置
//    limitLine.valueTextColor = [self colorWithHexString:@"#057748"];//label文字颜色
//    limitLine.valueFont = [UIFont systemFontOfSize:12];//label字体
//    [leftAxis addLimitLine:limitLine];//添加到Y轴上
//    leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在折线图的后面
    
    //描述及图例样式
    //    [self.lineChartView setDescriptionText:@"折线图"];
    //    [self.lineChartView setDescriptionTextColor:[UIColor darkGrayColor]];
    
    //    self.lineChartView setChartDescription:(ChartDescription * _Nullable)
    
    self.lineChartView.legend.form = ChartLegendFormLine;
    self.lineChartView.legend.formSize = 30;
    self.lineChartView.legend.textColor = [UIColor darkGrayColor];
    
//    [self updateData];
    //    self.data = [self setData];
    //    self.lineChartView.data = self.data;
    //    [self.lineChartView animateWithXAxisDuration:1.0f];
    
}


-(void)updateData{
    //    self.data = [self setData];
    self.lineChartView.data = self.data;
    [self.lineChartView animateWithXAxisDuration:0.5f];
    
    
}

//为折线图设置数据
- (LineChartData *)dxxxxxxata{
    
    int xVals_count = 100;//X轴上要显示多少条数据
    double maxYVal = 100;//Y轴的最大值
    
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        [xVals addObject:[NSString stringWithFormat:@"%d月", i+1]];
    }
    
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        double mult = maxYVal + 1;
        double val = (double)(arc4random_uniform(mult));
        //        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithValue:val xIndex:i];
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:(double)i y:val];
        [yVals addObject:entry];
    }
    
    LineChartDataSet *set1 = nil;
    if (self.lineChartView.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)self.lineChartView.data;
        set1 = (LineChartDataSet *)data.dataSets[0];
        
        //===================================
        //        set1.values = yVals;
        //===================================
        NSMutableArray <ChartDataEntry *>*marr = [[NSMutableArray alloc] initWithArray:set1.values];
        [marr removeObjectAtIndex:0];
        
        for (int i = 0; i < marr.count; i ++) {
            ChartDataEntry *entry = marr[i];
            entry.x -= 1;
        }
        
        
        double val = (double)(arc4random_uniform(100));
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:xVals_count - 1.f y:val];
        [marr addObject:entry];
        
        set1.values = marr;
        
        //===================================
        
        //        set1.yVals = yVals;
        return data;
    }else{
        //创建LineChartDataSet对象
        //        set1 = [[LineChartDataSet alloc] initWithYVals:yVals label:@"lineName"];
        
        set1 = [[LineChartDataSet alloc] initWithValues:yVals label:@"fuck"];
        
        
        
        //设置折线的样式
        set1.lineWidth = 1.0/[UIScreen mainScreen].scale;//折线宽度
        set1.drawValuesEnabled = YES;//是否在拐点处显示数据
        set1.valueColors = @[[UIColor brownColor]];//折线拐点处显示数据的颜色
        [set1 setColor:[self colorWithHexString:@"#007FFF"]];//折线颜色
        set1.drawFilledEnabled = NO;//是否开启绘制阶梯样式的折线图
        
        //折线拐点样式
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.circleRadius = 4.0f;//拐点半径
        set1.circleColors = @[[UIColor redColor], [UIColor greenColor]];//拐点颜色
        
        //拐点中间的空心样式
        set1.drawCircleHoleEnabled = YES;//是否绘制中间的空心
        set1.circleHoleRadius = 2.0f;//空心的半径
        set1.circleHoleColor = [UIColor blackColor];//空心的颜色
        //折线的颜色填充样式
        //第一种填充样式:单色填充
        //        set1.drawFilledEnabled = YES;//是否填充颜色
        //        set1.fillColor = [UIColor redColor];//填充颜色
        //        set1.fillAlpha = 0.3;//填充颜色的透明度
        
        //第二种填充样式:渐变填充
        set1.drawFilledEnabled = YES;//是否填充颜色
        NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,
                                    (id)[ChartColorTemplates colorFromString:@"#FF007FFF"].CGColor];
        CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        set1.fillAlpha = 0.3f;//透明度
        set1.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
        CGGradientRelease(gradientRef);//释放gradientRef
        
        //点击选中拐点的交互样式
        set1.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
        set1.highlightColor = [self colorWithHexString:@"#c83c23"];//点击选中拐点的十字线的颜色
        set1.highlightLineWidth = 1.0/[UIScreen mainScreen].scale;//十字线宽度
        set1.highlightLineDashLengths = @[@5, @5];//十字线的虚线样式
        
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        //添加第二个LineChartDataSet对象
        LineChartDataSet *set2 = [set1 copy];
        NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
        for (int i = 0; i < xVals_count; i++) {
            double mult = maxYVal + 1;
            double val = (double)(arc4random_uniform(mult));
            //                    ChartDataEntry *entry = [[ChartDataEntry alloc] initWithValue:val xIndex:i];
            
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:val];
            
            
            [yVals2 addObject:entry];
        }
        set2.values = yVals2;
        [set2 setColor:[UIColor redColor]];
        set2.drawFilledEnabled = YES;//是否填充颜色
        set2.fillColor = [UIColor redColor];//填充颜色
        set2.fillAlpha = 0.1;//填充颜色的透明度
        [dataSets addObject:set2];
        
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        //        LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];
        LineChartData *data  = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:[UIColor grayColor]];//文字颜色
        
        //initWithDataSets:dataSets];
        

        
        //        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:8.f]];//文字字体
        //        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        //        //自定义数据显示格式
        //        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        //        [formatter setPositiveFormat:@"#0.0"];
        //        [data setValueFormatter:formatter];
        
        return data;
    }
}

#pragma mark - ChartViewDelegate

//点击选中折线拐点时回调
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * _Nonnull)highlight{
    //    NSLog(@"---chartValueSelected---value: %g", entry.value);
}
//没有选中折线拐点时回调
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView{
    NSLog(@"---chartValueNothingSelected---");
}
//放大折线图时回调
- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
    NSLog(@"---chartScaled---scaleX:%g, scaleY:%g", scaleX, scaleY);
}
//拖拽折线图时回调
- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
    NSLog(@"---chartTranslated---dX:%g, dY:%g", dX, dY);
}

//将十六进制颜色转换为 UIColor 对象
- (UIColor *)colorWithHexString:(NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip "0X" or "#" if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


@end
