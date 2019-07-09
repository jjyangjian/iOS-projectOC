//
//  JJTongji1Cell.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/13.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJTongji1Cell.h"

#import "projectOC-Bridging-Header.h"

#define X_COUNT 500

@interface JJTongji1Cell ()

<
ChartViewDelegate
>

//@property (nonatomic, strong) LineChartView *lineChartView;

@property (nonatomic, strong) BarChartData *data;

//@property (nonatomic, strong) LineChartDataSet *dataSet;
@property (nonatomic,strong)NSMutableArray *x_values;
//@property (nonatomic,strong)NSMutableArray *y_values;


@property (nonatomic,strong) BarChartView *barChartView;

@end

@implementation JJTongji1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.x_values = [[NSMutableArray alloc] init];
//    for (int i = 0; i < X_COUNT; i++) {
//        [self.x_values addObject:[NSString stringWithFormat:@"数据%d",i + 1]];
//    }
    //    self.y_values = [[NSMutableArray alloc] init];
    
    [self createBarChartView];
    
//    [self setDataCount:X_COUNT];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)setChartInfoWithMinValue:(CGFloat)minValue MaxValue:(CGFloat)maxValue Unit:(NSString *)unit;
{
    
    if (unit.length) {
        self.label0.text = [NSString stringWithFormat:@"%@(%@)",self.label0.text,unit];
    }else{
        self.label0.text = [NSString stringWithFormat:@"%@",self.label0.text];
    }
    
    ChartYAxis *leftAxis = self.barChartView.leftAxis;//获取左边Y轴
//    leftAxis.axisMinimum = minValue;//设置Y轴的最小值
//    leftAxis.axisMaximum = maxValue;//设置Y轴的最大值
    
    NSNumberFormatter *axisFormatter = [[NSNumberFormatter alloc] init];
    
//    //负数的后缀
//    axisFormatter.negativeSuffix = unit;
//    //正数的后缀
//    axisFormatter.positiveSuffix = unit;
    
//    axisFormatter.minimum = [NSNumber numberWithFloat:0.1];
    axisFormatter.numberStyle = NSNumberFormatterDecimalStyle;

    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:axisFormatter];
    
    
}

- (void)updateDataWithDictionary:(NSDictionary *)dictionary{
    
    
}

- (void)updateDataWithValueArray:(NSArray *)valueArray;
{
    
    [self.x_values removeAllObjects];
    NSMutableArray <BarChartDataEntry *>*avgy_values = [[NSMutableArray alloc] init];
    NSMutableArray <BarChartDataEntry *>*miny_values = [[NSMutableArray alloc] init];
    NSMutableArray <BarChartDataEntry *>*maxy_values = [[NSMutableArray alloc] init];
    for (int i = 0; i < valueArray.count; i ++) {
        [self.x_values addObject:JJSTRING(valueArray[i][@"xvalue"])];
        
        BarChartDataEntry *avgentry = [[BarChartDataEntry alloc] initWithX:i y:[valueArray[i][@"avgyvalue"] floatValue]];
        [avgy_values addObject:avgentry];
        
        BarChartDataEntry *minentry = [[BarChartDataEntry alloc] initWithX:i y:[valueArray[i][@"minyvalue"] floatValue]];
        [miny_values addObject:minentry];

        BarChartDataEntry *maxentry = [[BarChartDataEntry alloc] initWithX:i y:[valueArray[i][@"maxyvalue"] floatValue]];
        [maxy_values addObject:maxentry];
    }
//    @"avgyvalue"
//    @"minyvalue"
//    @"maxyvalue"
    
    ((ChartIndexAxisValueFormatter *)(self.barChartView.xAxis.valueFormatter)).values = self.x_values;
    
    BarChartDataSet *avgDataSet = [self createDataSetWithColor:[UIColor colorWithRed:0.25f green:0.74f blue:0.29f alpha:1.00f] andLabelString:@"平均值"];
    BarChartDataSet *minDataSet = [self createDataSetWithColor:[UIColor colorWithRed:0.76f green:0.41f blue:0.00f alpha:1.00f] andLabelString:@"最小值"];
    BarChartDataSet *maxDataSet = [self createDataSetWithColor:[UIColor colorWithRed:0.96f green:0.15f blue:0.01f alpha:1.00f] andLabelString:@"最大值"];

    avgDataSet.values = avgy_values;
    minDataSet.values = miny_values;
    maxDataSet.values = maxy_values;

    self.data = [[BarChartData alloc] initWithDataSets:@[avgDataSet,minDataSet,maxDataSet]];
    [self.data setBarWidth:0.2];
    [self.data setValueFont:[UIFont systemFontOfSize:10]];
    [self.data groupBarsFromX: -.5f groupSpace: 0.4f barSpace: 0.f];

    self.barChartView.data = self.data;
//    [self.barChartView animateWithXAxisDuration:0.f];
    [_barChartView.data notifyDataChanged];
    [_barChartView notifyDataSetChanged];
    
    ChartViewPortHandler *handler = self.barChartView.viewPortHandler;
    CGFloat count = valueArray.count;
    
    if (count > 3) {
        CGFloat count_x =  count / 3.f ;
        NSLog(@"%f",count_x);
        NSLog(@"%f",handler.scaleX);
        NSLog(@"%f",handler.scaleY);
        [handler setMinimumScaleX:count_x];
        [handler setMinimumScaleX:1.f];
    }

    
}

- (BarChartDataSet *)createDataSetWithColor:(UIColor *)color andLabelString:(NSString *)labelString{
    BarChartDataSet *dataSet = [[BarChartDataSet alloc] init];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"#####0.00;"];
    dataSet.valueFormatter = [[ChartDefaultValueFormatter alloc] initWithFormatter:formatter];

    dataSet.label =labelString;
    // bar的颜色
    [dataSet setColor:color];
    // 数值的颜色
    [dataSet setValueTextColor:color];
    // 是 否在bar上显示数值
    [dataSet setDrawValuesEnabled:1];
    // 是否点击有高亮效果，为NO是不会显示marker的效果
    [dataSet setHighlightEnabled:NO];
    BarChartData*data = [[BarChartData alloc]initWithDataSet:dataSet];
    // 设置宽度  柱形之间的间隙占整个柱形(柱形+间隙)的比例
    [data setBarWidth:0.2];
    [data setValueFont:[UIFont systemFontOfSize:10]];
//    _barChartView.data = data;
    
    return dataSet;
}

- (void)setDataCount:(int)count {
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for(int i =0; i < count; i++) {
        int val = (double) (arc4random_uniform(60))+2;
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
    }
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    for(int i =0; i < count; i++) {
        int val2 = (double) (arc4random_uniform(60));
        [yVals2 addObject:[[BarChartDataEntry alloc] initWithX:i y:val2]];
    }
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"数据1"];
    [set1 setColor:[UIColor colorWithRed:219/255.f green:50/255.f blue:59/255.f alpha:1]];
    //bar的颜色
    [set1 setDrawValuesEnabled:NO];
    [set1 setHighlightEnabled:NO];
    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithValues:yVals2 label:@"数据2"];
    
    //bar的颜色
    [set2 setColor:[UIColor colorWithRed:255/255.f green:152/255.f blue:46/255.f alpha:1]];
    
    //是否在bar上显示数值
    [set2 setDrawValuesEnabled:1];
    //是否点击有高亮效果，为NO是不会显示marker的效果
    [set2 setHighlightEnabled:0];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    
    BarChartData*data = [[BarChartData alloc]initWithDataSets:dataSets];
    [data setBarWidth:0.2];
    [data setValueFont:[UIFont systemFontOfSize:10]];
    
    [data groupBarsFromX: -.5f groupSpace: 0.4f barSpace: 0.f];
    
//    [data groupBarsFromX:0.f groupSpace:10.f barSpace:0.f];

    
    _barChartView.data = data;
    [_barChartView.data notifyDataChanged];
    [_barChartView notifyDataSetChanged];
    
    //    [self.barChartView zoomToCenterWithScaleX:xxx scaleY:1.f];
    //    self.barChartView  = xxx;
//    ChartXAxis *xAxis = self.barChartView.xAxis;
    ChartViewPortHandler *handler = self.barChartView.viewPortHandler;
    CGFloat xx = X_COUNT;
    CGFloat xxx =  xx / 20.f ;
    
    NSLog(@"%f",xxx);
    
    NSLog(@"%f",handler.scaleX);
    NSLog(@"%f",handler.scaleY);
//    handler.scaleX = xxx;
    
//    handler.scaleX = xxx;
    [handler setMinimumScaleX:xxx];
    [handler setMinimumScaleX:1.f];

//    let maxTransX = -width * (_scaleX - 1.0)
//    _transX = min(max(matrix.tx, maxTransX - _transOffsetX), _transOffsetX)
//
//    let maxTransY = height * (_scaleY - 1.0)
//    _transY = max(min(matrix.ty, maxTransY + _transOffsetY), -_transOffsetY)
//
//    matrix.tx = _transX
//    matrix.a = _scaleX
//    matrix.ty = _transY
//    matrix.d = _scaleY
    
//    [handler translateWithPt:CGPointMake(xxx, 1.f)];
//    self.barChartView setx
//    self.barChartView.scaleX = 100.f;

    
    
//    [handler setZoomWithScaleX:xxx scaleY:1.f x:0.f y:0.f];
//    [handler setZoomWithScaleX:xxx scaleY:1.f];
//    self.barChartView.viewPortHandler = handler;

    
}


//
//- (LineChartDataSet *)createFillDataSet{
//}

- (void)createBarChartView{
    
    //添加LineChartView
    self.barChartView = [[BarChartView alloc] init];
    self.barChartView.delegate = self;//设置代理
    [self addSubview:self.barChartView];
    //    [self.lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width-20, 300));
    //        make.center.mas_equalTo(self.view);
    //    }];
    self.barChartView.frame = CGRectMake(0, 32, SIZE.width , 200.f);
    //基本样式
    self.barChartView.backgroundColor =  [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
    self.barChartView.noDataText = @"暂无数据";
    //交互样式
    self.barChartView.scaleYEnabled = NO;//取消Y轴缩放
    self.barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    self.barChartView.dragEnabled = YES;//启用拖拽图标
    self.barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    self.barChartView.dragDecelerationFrictionCoef = 0.5f;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    //    self.lineChartView.pinchZoomEnabled = 0;
    // 数值显示是否在条柱上面
    
    self.barChartView.drawValueAboveBarEnabled = YES;
    

    
    
    //X轴样式
    ChartXAxis *xAxis = self.barChartView.xAxis;
    xAxis.labelFont = [UIFont systemFontOfSize:9.f];
    xAxis.granularityEnabled = 1;//粒度,禁止自行添加数值
    xAxis.centerAxisLabelsEnabled = 0;
    //    xAxis. = 1;
    
    xAxis.axisLineWidth = 1.0/[UIScreen mainScreen].scale;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    //    xAxis.spaceBetweenLabels = 4;//设置label间隔
//    xAxis.spaceMin = 0;
    xAxis.labelCount = 5;//
    xAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label

//    xAxis.axisMinimum = - 0.6f;
//    xAxis.axisMinimum = 0.f;

    
    
    self.barChartView.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:self.x_values];
    
    
    xAxis.labelTextColor = [self colorWithHexString:@"#057748"];//label文字颜色
    //Y轴样式
    self.barChartView.rightAxis.enabled = NO;//不绘制右边轴
    ChartYAxis *leftAxis = self.barChartView.leftAxis;//获取左边Y轴
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
    leftAxis.minWidth = 30.f;
    leftAxis.maxWidth = 30.f;
    leftAxis.spaceBottom = 0.0;
    leftAxis.spaceTop = 0.35;
//            leftAxis.showOnlyMinMaxEnabled = NO;//是否只显示最大值和最小值
//            leftAxis.startAtZeroEnabled = YES;//从0开始绘制
    
//    leftAxis.axisMinimum = 0;//设置Y轴的最小值
//    leftAxis.axisMaximum = 60;//设置Y轴的最大值
    
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
    
    
    self.barChartView.legend.form = ChartLegendFormLine;
    self.barChartView.legend.formSize = 30;
    self.barChartView.legend.textColor = [UIColor darkGrayColor];
    
    //    [self updateData];
    //    self.data = [self setData];
    //    self.lineChartView.data = self.data;
    //    [self.lineChartView animateWithXAxisDuration:1.0f];
    
}


-(void)updateData{
    //    self.data = [self setData];
    self.barChartView.data = self.data;
    [self.barChartView animateWithXAxisDuration:0.5f];
    
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
    if (self.barChartView.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)self.barChartView.data;
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
//    NSLog(@"---chartTranslated---dX:%g, dY:%g", dX, dY);
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

/*
 
 */
