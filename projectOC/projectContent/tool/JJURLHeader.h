//
//  JJURLHeader.h
//  jjxinfadi
//
//  Created by CMP on 2018/7/14.
//  Copyright © 2018年 ChiefCadet. All rights reserved.
//http://www.lolhelper.cn/analyse_word.php?

#ifndef JJURLHeader_h
#define JJURLHeader_h


//前面固定部分
#define JJBASEURLSTRING @"http://39.105.114.156:8084"
//#define JJBASEURLSTRING @"http://192.168.1.150:8084"

/*
 接口登录获取token
 请求类型    POST
 接口地址    /api/login
 参数类型    json
 返回类型    json
 请求参数示例    {
 "username":"zyf3","password":"123"
 }
 */
#define JJURLSTRING_api_login [NSString stringWithFormat:@"%@/api/login",JJBASEURLSTRING]

/*
 接口名称    设备列表
 请求类型    POST
 接口地址    /api/eq/list/my
 参数类型    PathVariable
 返回类型    JSON
 请求参数示例    /api/eq/list/my
 */
#define JJURLSTRING_api_eq_list_my [NSString stringWithFormat:@"%@/api/eq/list/my",JJBASEURLSTRING]


/*
 接口名称    设备信息
 请求类型    GET
 接口地址    /api/eq/info/{eqid}
 参数类型    PathVariable
 返回类型    json
 请求参数示例    /api/eq/info/300000
 */
#define JJURLSTRING_api_eq_info_(deviceID) [NSString stringWithFormat:@"%@/api/eq/info/%@",JJBASEURLSTRING,deviceID]

/*
 接口名称    历史列表
 请求类型    GET
 接口地址    /api/history/data/list/title
 参数类型    RequestParam
 
 historyDataType:列表类型1（数据）、2(报警)、3(报表);eqId:设备id
 
 返回类型    json
 
 请求参数示例    /api/history/data/list/title?historyDataType=1&eqId=300000
 */
#define JJURLSTRING_api_history_data_list_title [NSString stringWithFormat:@"%@/api/history/data/list/title",JJBASEURLSTRING]

/*
 接口名称    历史列表
 请求类型    POST
 接口地址    /api/history/data/list
 参数类型    json
 
 eqId:设备id ;
 historyDataType: 列表类型1（数据）、2(报警)、3(报表);
 beginTime:开始时间；
 endTime:结束时间；
 pageSize:每页显示条数；
 pageNum:页码；
 orderByColumn：排序字段；
 isAsc:排序方式；
 
 返回类型    json
 请求参数示例    {"eqId":"300000","historyDataType":"1","beginTime":"2019-04-17","endTime":"2019-04-17","pageSize":15,"pageNum":1,"orderByColumn":"addTime","isAsc":"desc"}
 
 
 */
#define JJURLSTRING_api_history_data_list [NSString stringWithFormat:@"%@/api/history/data/list",JJBASEURLSTRING]


/*
 6.报警-日列表
 接口名称    历史列表    备注
 请求类型    POST
 接口地址    /api/alarm/list/day
 参数类型    json
 返回类型    json
 请求参数示例        {"eqId":"300000","beginTime":"2019-04-01","endTime":"2019-04-01","historyDataType":"2","pageSize":15,"pageNum":1,"orderByColumn":"addTime","isAsc":"desc"}
 
 */
#define JJURLSTRING_api_alarm_list_day [NSString stringWithFormat:@"%@/api/alarm/list/day",JJBASEURLSTRING]

/*
 8.报警数量-月统计
 接口名称    报警数量    按月统计每日报警数量
 请求类型    GET
 接口地址    /api/alarm/report/month/{eqId}/{dateMonth}    eqId （设备id）
 dateMonth（某月） 2019-04
 参数类型    PathVariable
 返回类型    json
 请求参数示例    /api/alarm/report/month/300000/2019-04
 */
#define JJURLSTRING_api_alarm_report_month_(deviceID,YearMonth) [NSString stringWithFormat:@"%@/api/alarm/report/month/%@/%@",JJBASEURLSTRING,deviceID,YearMonth]


/*
 11.峰值统计
 接口名称    平均值-最大值-最小值    备注
 请求类型    POST    日期相同为一天内时报，否则日报
 接口地址    /api/report/peak/{eqId}/{daterange}    eqid 设备id
 daterange 时间段
 参数类型    pathvalue
 返回类型    json
 请求参数示例    /api/report/peak/300000/2019-04-15_2019-04-19
 */
#define JJURLSTRING_api_report_peak_(deviceID,startTime,endTime) [NSString stringWithFormat:@"%@/api/report/peak/%@/%@_%@",JJBASEURLSTRING,deviceID,startTime,endTime]


/*
 5.历史数据-指定数量
 接口名称    历史数据    返回指定数量的历史数据
 请求类型    GET
 接口地址    /api/history/data/top/{num}/{eqId}
 参数类型    PathVariable    num(数量)
 eqId(设备id)
 返回类型    json
 请求参数示例    /api/history/data/top/1/300000
 */
#define JJURLSTRING_api_history_data_top_(count,deviceID) [NSString stringWithFormat:@"%@/api/history/data/top/%@/%@",JJBASEURLSTRING,count,deviceID]



#endif








