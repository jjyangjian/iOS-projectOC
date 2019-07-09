//
//  JJDitushebeiController.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/3/28.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJDitushebeiController.h"
#import "JJPointAnnotation.h"

//设备详情
#import "JJLishijiluController.h"



//实时监测
#import "JJShishijianceController.h"

//历史
#import "JJLishijiluController.h"

//报警记录
#import "JJBaojingjiluController.h"

//统计
#import "JJTongjiController.h"

#import "JJAnnotationDetailView.h"


#import "JJDitushebeiCell.h"


@interface JJDitushebeiController ()
<
MKMapViewDelegate
>

@property (nonatomic,strong)NSMutableArray <JJPointAnnotation *>*pointAnnotationArray;
@property (nonatomic) BOOL isCreate;


@property (nonatomic,strong)NSArray <NSDictionary *>*dataArray;
@property (nonatomic,strong)NSDictionary *selectedDevice;
@property (nonatomic,strong)JJPointAnnotation *selectedAnnotation;

@property (nonatomic) BOOL pop_up;


@end

@implementation JJDitushebeiController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"地图";

    self.pointAnnotationArray = [[NSMutableArray alloc] init];
    self.isCreate = 1;
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设备" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.pop_up = 1;

    [self loadData];
//    [self createTableView];

}

- (void)rightBarButtonItemClick:(UIBarButtonItem *)buttonItem{
    JJWEAKSELF

    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"选择设备" message:nil preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < self.dataArray.count; i ++) {
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        if ([self.dataArray[i][@"eqId"] isEqualToString:self.selectedDevice[@"eqId"]]) {
            style = UIAlertActionStyleDestructive;
        }
        [controller addAction:[UIAlertAction actionWithTitle:self.dataArray[i][@"eqName"] style:style handler:^(UIAlertAction * _Nonnull action) {
            [weakself.mapView deselectAnnotation:self.selectedAnnotation animated:1];
            [weakself.mapView selectAnnotation:self.pointAnnotationArray[i] animated:1];
            self.pop_up = 1;
        }]];
    }
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.pop_up = 1;

    }]];
    [self presentViewController:controller animated:1 completion:^{
        self.pop_up = 0;
    }];
    
    
    
}

- (void)loadData{
    
    self.dataArray = [JJExtern sharedJJ].devices;
    
    for (int i = 0; i < self.dataArray.count; i ++) {
        NSDictionary *device = self.dataArray[i];
        
        NSArray *lon_lat = [device[@"mapXy"] componentsSeparatedByString:@","];
        
        CGFloat lon = [lon_lat[0] doubleValue];
        CGFloat lat = [lon_lat[1] doubleValue];
        JJPointAnnotation *pointAnnotation = [JJPointAnnotation new];
        pointAnnotation.identity = i;
//        pointAnnotation.
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(lat, lon);
        
        pointAnnotation.title = device[@"eqName"];
        pointAnnotation.subtitle = device[@"eqId"];
        
        [self.pointAnnotationArray addObject:pointAnnotation];
    }
    [self.mapView addAnnotations:self.pointAnnotationArray];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.isCreate) {
        [self zoomMapViewToFitAnnotations:self.mapView animated:1];
        self.isCreate = 0;
    }
}

#pragma mark - 根据所有的大头针坐标,计算显示范围,屏幕能够刚好显示大头针
#define CW_MINIMUM_ZOOM_ARC 0.014
#define CW_ANNOTATION_REGION_PAD_FACTOR 1.15
#define CW_MAX_DEGREES_ARC 360
- (void)zoomMapViewToFitAnnotations:(MKMapView *)mapView animated:(BOOL)animated
{
    NSArray *annotations = mapView.annotations;
    NSInteger count = [mapView.annotations count];
    if ( count == 0) { return; }
    MKMapPoint points[count];
    for( int i=0; i<count; i++ )
    {
        CLLocationCoordinate2D coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        points[i] = MKMapPointForCoordinate(coordinate);
    }
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
    // 因为,中间的一个大头针居中显示,所以这里的size要减一半.所以乘以二
    //    mapRect.size.width = mapRect.size.width * 2;
    //    mapRect.size.height = mapRect.size.height * 2;
    
    mapRect.size.width = mapRect.size.width;
    mapRect.size.height = mapRect.size.height;
    
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    
    region.span.latitudeDelta  *= CW_ANNOTATION_REGION_PAD_FACTOR;
    region.span.longitudeDelta *= CW_ANNOTATION_REGION_PAD_FACTOR;
    
    if( region.span.latitudeDelta > CW_MAX_DEGREES_ARC ) { region.span.latitudeDelta  = CW_MAX_DEGREES_ARC; }
    if( region.span.longitudeDelta > CW_MAX_DEGREES_ARC ){ region.span.longitudeDelta = CW_MAX_DEGREES_ARC; }
    
    if( region.span.latitudeDelta  < CW_MINIMUM_ZOOM_ARC ) { region.span.latitudeDelta  = CW_MINIMUM_ZOOM_ARC; }
    if( region.span.longitudeDelta < CW_MINIMUM_ZOOM_ARC ) { region.span.longitudeDelta = CW_MINIMUM_ZOOM_ARC; }
    if( count == 1 )
    {
        region.span.latitudeDelta = CW_MINIMUM_ZOOM_ARC;
        region.span.longitudeDelta = CW_MINIMUM_ZOOM_ARC;
    }
    //    region.center = self.location1;
    [mapView setRegion:region animated:animated];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //创建一个系统大头针对象
    
//    MKMarkerAnnotationView
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"MKPinAnnotationView"];
    if (!annotationView) {
        CGFloat height = 51.f;
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MKPinAnnotationView"];
        annotationView.tintColor = [UIColor greenColor];//设置颜色为绿色
        
        UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, height, height)];
        leftView.tag = 100;
//        leftView.backgroundColor = [UIColor redColor];
//        leftView.image = [UIImage imageNamed:@"main_xiaoxi_s"];
//        annotationView.leftCalloutAccessoryView = leftView;

        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.backgroundColor = [UIColor orangeColor];
        rightButton.frame = CGRectMake(0, 0, height, height);
        [rightButton setTitle:@"详情" forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(shebeixiangqingAction:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.rightCalloutAccessoryView = rightButton;
        
//        NSMutableArray *arr = [[NSMutableArray alloc] init];
//        for (int i = 0; i < 3; i ++) {
//            [arr addObject:[self createLabelWithKey:@"fds" value:@"fdsfds" unit:@"f"]];
//        }
//
//        JJSelectedAnnotationView *detailView = [[JJSelectedAnnotationView alloc] initWithLabelArray:arr block:^{
//        }];
//                                   JJSelectedAnnotationView *detailView = [[JJSelectedAnnotationView alloc] initWithLabelArray:@[] block:^{
//                                   }];
//
//        annotationView.detailCalloutAccessoryView = detailView;
        
        
        annotationView.canShowCallout = 1;
        
    }
    
//    ((UIImageView *) annotationView.leftCalloutAccessoryView).image = [UIImage imageNamed:@"main_xiaoxi_s"];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    //    [mapView deselectAnnotation:view.annotation animated:1];
    
    self.selectedAnnotation = (JJPointAnnotation *)(view.annotation);
    self.selectedDevice = self.dataArray[((JJPointAnnotation *)(view.annotation)).identity];
//    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:((JJPointAnnotation *)(view.annotation)).identity inSection:0] animated:1 scrollPosition:UITableViewScrollPositionTop];
    
    MKCoordinateRegion region = MKCoordinateRegionMake(view.annotation.coordinate, MKCoordinateSpanMake(0.4, 0.4));
    [mapView setRegion:region animated:1];
    NSLog(@"%@",self.mapView.selectedAnnotations);
    
    if (self.pop_up) {
        [self updateCurrentDataWithDeviceID:self.selectedDevice[@"eqId"]];
    }
    //    view.selected = 0;
    
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
}

- (UILabel *)createLabelWithKey:(NSString *)key value:(NSString *)value unit:(NSString *)unit{
    
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"%@\n\n%@\n%@",key,value,unit];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11.f];
    label.numberOfLines = 4;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}



- (void)shebeixiangqingAction:(UIButton *)button{
    NSLog(@"%@",self.mapView.selectedAnnotations);
//    self.navigationController.tabBarController.selectedIndex = 0;
    [self updateCurrentDataWithDeviceID:self.selectedDevice[@"eqId"] ];
    return;
    
    JJWEAKSELF
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"实时监测" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [JJExtern sharedJJ].currentDeviceID = weakself.selectedDevice[@"eqId"];
        [JJExtern sharedJJ].currentDevice = weakself.selectedDevice;
        [weakself shishijiance];
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"历史记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [JJExtern sharedJJ].currentDeviceID = weakself.selectedDevice[@"eqId"];
        [JJExtern sharedJJ].currentDevice = weakself.selectedDevice;
        [weakself lishijilu];
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"数据统计" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [JJExtern sharedJJ].currentDeviceID = weakself.selectedDevice[@"eqId"];
        [JJExtern sharedJJ].currentDevice = weakself.selectedDevice;
        [weakself tongji];
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"报警记录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [JJExtern sharedJJ].currentDeviceID = weakself.selectedDevice[@"eqId"];
        [JJExtern sharedJJ].currentDevice = weakself.selectedDevice;
        [weakself baojingjilu];
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:controller animated:1 completion:^{
    }];

    return;
    
//    [self lishijilu];
    
//    JJLishijiluController *controller = [[JJLishijiluController alloc] init];
//    controller.hidesBottomBarWhenPushed = 1;
//    [self.navigationController pushViewController:controller animated:1];
}


- (void)updateCurrentDataWithDeviceID:(NSString *)deviceID{
    JJWEAKSELF
    [self showHudInView:self.view hint:@""];
    [JJDownload getData_Method:@"GET"
                  andURLString:
     JJURLSTRING_api_history_data_top_([NSString stringWithFormat:@"1"],deviceID)
                       andBody:nil
                  andNeedToken:1
               andSuccessBlock: ^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
                   [weakself hideHud];
                   [weakself showHint:message];
                   
                   NSMutableArray *marr = [NSMutableArray new];
                   NSString *title = weakself.selectedDevice[@"eqName"];
                   NSString *time = @"";
                   if ([responseObject[@"content"][@"data"] count]) {
                       NSArray *arr = responseObject[@"content"][@"data"][0];
                       for (int i = 0; i < arr.count; i ++) {
                           if (i == 0) {
                               time = [NSString stringWithFormat:@"%@",arr[i][@"time"]];
                           }
                           NSString *unit = arr[i][@"unit"];
                               unit = [unit stringByReplacingOccurrencesOfString:@"(" withString:@""];
                               unit = [unit stringByReplacingOccurrencesOfString:@")" withString:@""];
                               unit = [unit stringByReplacingOccurrencesOfString:@"null" withString:@""];
                           if (!unit.length) {
                               unit = @" ";
                           }
                           [marr addObject:[self createLabelWithKey:arr[i][@"name"] value:arr[i][@"data"] unit:unit]];
                       }
                   }
                   JJAnnotationDetailView *detailView = [[JJAnnotationDetailView alloc]
                                                         initWithTitle:title
                                                         time:time
                                                         labelArray:marr
                                                         block:^(long buttonTag) {
                       if (buttonTag == 101) {
                           [JJExtern sharedJJ].currentDeviceID = weakself.selectedDevice[@"eqId"];
                           [JJExtern sharedJJ].currentDevice = weakself.selectedDevice;
                           [weakself shishijiance];

                       }else if (buttonTag == 102) {
                           [JJExtern sharedJJ].currentDeviceID = weakself.selectedDevice[@"eqId"];
                           [JJExtern sharedJJ].currentDevice = weakself.selectedDevice;
                           [weakself lishijilu];

                       }else if (buttonTag == 103) {
                           [JJExtern sharedJJ].currentDeviceID = weakself.selectedDevice[@"eqId"];
                           [JJExtern sharedJJ].currentDevice = weakself.selectedDevice;
                           [weakself tongji];

                       }else if (buttonTag == 104) {
                           [JJExtern sharedJJ].currentDeviceID = weakself.selectedDevice[@"eqId"];
                           [JJExtern sharedJJ].currentDevice = weakself.selectedDevice;
                           [weakself baojingjilu];

                       }else{
                       }
                   }];
                   [detailView show];
                   
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   [weakself hideHud];
                   [weakself showHint:error.domain];
                   NSLog(@"%@",error);
               }];
}




- (void)shishijiance{
    JJShishijianceController *controller = [[JJShishijianceController alloc] init];
    [self.navigationController pushViewController:controller animated:1];
}

//- (void)lishijilu{
//    JJLishijiluController *controller = [[JJLishijiluController alloc] init];
//    [self.navigationController pushViewController:controller animated:1];
//}
//历史列表-标题/api/history/data/list/title
- (void)lishijilu{
    //    "username":"zyf3","password":"123"
    NSDictionary *parameter = @{
                                @"historyDataType":@"1",
                                @"eqId":[JJExtern sharedJJ].currentDeviceID,
                                };
    JJWEAKSELF
    [self showHudInView:self.view hint:@""];
    [JJDownload getData_Method:@"GET"
                  andURLString:JJURLSTRING_api_history_data_list_title
                  andParameter:parameter
                  andNeedToken:1
               andSuccessBlock: ^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
                   [weakself hideHud];
                   [weakself showHint:message];
                   NSLog(@"%@",responseObject);
                   JJLishijiluController *controller = [[JJLishijiluController alloc] initWithTitleInfoArray:responseObject[@"content"]];
                   [self.navigationController pushViewController:controller animated:1];
                   
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   [weakself hideHud];
                   [weakself showHint:error.domain];
                   NSLog(@"%@",error);
               }];
}

- (void)tongji{
    NSDictionary *parameter = @{
                                @"historyDataType":@"3",
                                @"eqId":[JJExtern sharedJJ].currentDeviceID,
                                };
    JJWEAKSELF
    [self showHudInView:self.view hint:@""];
    [JJDownload getData_Method:@"GET"
                  andURLString:JJURLSTRING_api_history_data_list_title
                  andParameter:parameter
                  andNeedToken:1
               andSuccessBlock: ^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
                   [weakself hideHud];
                   [weakself showHint:message];
                   NSLog(@"%@",responseObject);
                   JJTongjiController *controller = [[JJTongjiController alloc] initWithTitleInfoArray:responseObject[@"content"]];
                   [self.navigationController pushViewController:controller animated:1];
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   [weakself hideHud];
                   [weakself showHint:error.domain];
                   NSLog(@"%@",error);
               }];
}

- (void)baojingjilu{
    
    NSDictionary *parameter = @{
                                @"historyDataType":@"2",
                                @"eqId":[JJExtern sharedJJ].currentDeviceID,
                                };
    JJWEAKSELF
    [self showHudInView:self.view hint:@""];
    [JJDownload getData_Method:@"GET"
                  andURLString:JJURLSTRING_api_history_data_list_title
                  andParameter:parameter
                  andNeedToken:1
               andSuccessBlock: ^(NSString * _Nonnull message, NSDictionary * _Nullable responseObject) {
                   [weakself hideHud];
                   [weakself showHint:message];
                   NSLog(@"%@",responseObject);
                   JJBaojingjiluController *controller = [[JJBaojingjiluController alloc] init];
                   [self.navigationController pushViewController:controller animated:1];
                   
               } andFailureBlock: ^(NSError * _Nonnull error) {
                   [weakself hideHud];
                   [weakself showHint:error.domain];
                   NSLog(@"%@",error);
               }];
}



//static NSString *cellName = @"JJDitushebeiCell";
//
//
//- (void)createTableView{
//    [self.tableView registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellName];
//}
//
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    //    return 1;
//    return self.dataArray.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.f;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return nil;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.f;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return nil;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    JJDitushebeiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
//    //    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
//    //    cell.label0.text = self.dataArray[indexPath.row][@"name"];
//    //    cell.label1.text = self.dataArray[indexPath.row][@"value"];
//    //    cell.label2.text = self.dataArray[indexPath.row][@"unit"];
//    cell.label0.text = self.dataArray[indexPath.row][@"eqName"];
//    cell.label1.text = self.dataArray[indexPath.row][@"eqId"];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    [tableView deselectRowAtIndexPath:indexPath animated:1];
//    NSLog(@"~~~~~~~~~~~~~~%ld", self.mapView.selectedAnnotations.count );
//
//
//    if (self.mapView.selectedAnnotations.count) {
//        if (self.selectedAnnotation.identity == indexPath.row) {
//            return;
//        }
//    }
//
//    [self.mapView deselectAnnotation:self.selectedAnnotation animated:1];
//    [self.mapView selectAnnotation:self.pointAnnotationArray[indexPath.row] animated:1];
//}


@end


/*
 
 */
