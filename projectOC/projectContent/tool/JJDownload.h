//
//  JJDownload.h
//  jjxinfadi
//
//  Created by CMP on 2018/7/14.
//  Copyright © 2018年 ChiefCadet. All rights reserved.
//


#define CODE_KEY                @"code"//返回数据时,code的key,一般为,code,state 等
#define CODEMESSAGE_KEY         @"message"//返回消息的key值






#define CODE_VALUE_SUCCESS              @"0"//成功的code值

#define CODE_VALUE_OTHERLOGIN           @"500"//其他设备登录的code值

#define CODE_VALUE_NOLOGIN              @"499"//未登录的code值
#define CODEMESSAGE_VALUE_NOLOGIN       @"未登录,请登录"//未登录的message

//设定后台返回空的时候
#define CODE_VALUE_NULL                 @"-10"
#define CODEMESSAGE_VALUE_NULL          @"返回值为空"

//设定请求成功但code值有问题的时候
#define CODEMESSAGE_VALUE_SUCCESSERROR  @"正确回调,code错误"

//设定走错误回调时
#define CODE_VALUE_ERROR                @"-11"
#define CODEMESSAGE_VALUE_ERROR         @"错误"




#import <Foundation/Foundation.h>

#import <AFNetworking.h>

@interface JJDownload : NSObject

typedef void (^JJUpdateDataSuccessBlock)(NSDictionary * _Nonnull responseObject);
typedef void (^JJUpdateDataFailBlock)(NSError *error,NSString *message,NSString *code);
typedef void (^JJUpdateDataProgressBlock)(NSProgress *progress);

typedef void (^JJURLSessionManagerSuccessBlock)(NSString * _Nonnull message,NSDictionary * _Nullable responseObject);
typedef void (^JJURLSessionManagerFailureBlock)(NSError * _Nonnull error);




//普通下载数据
+ (void)downloadDataWithIsPost:(BOOL)isPost andURLString:(NSString *)urlString andParameter:(NSDictionary *)parameter andSuccessBlock:(JJUpdateDataSuccessBlock)successBlock andFailBlock:(JJUpdateDataFailBlock)failBlock;

//测试使用
+ (void)ceshidownloadDataWithIsPost:(BOOL)isPost andURLString:(NSString *)urlString andParameter:(NSDictionary *)parameter andSuccessBlock:(JJUpdateDataSuccessBlock)successBlock andFailBlock:(JJUpdateDataFailBlock)failBlock;

//post上传图片,传入data
+ (void)uploadOneImageDataWithURLString:(NSString *)urlString
                           andParameter:(NSDictionary *)parameter
                           andImageInfo:(NSDictionary *)imageInfo
             andUpdateDataProgressBlock:(JJUpdateDataProgressBlock)progressBlock
                        andSuccessBlock:(JJUpdateDataSuccessBlock)successBlock
                           andFailBlock:(JJUpdateDataFailBlock)failBlock;

//post上传多张图片 <图片规则,data,name 两个字典参数>
+ (void)uploadMoreImageDataWithURLString:(NSString *)urlString
                            andParameter:(NSDictionary *)parameter
                       andImageInfoArray:(NSArray *)imageInfoArray
              andUpdateDataProgressBlock:(JJUpdateDataProgressBlock)progressBlock
                         andSuccessBlock:(JJUpdateDataSuccessBlock)successBlock
                            andFailBlock:(JJUpdateDataFailBlock)failBlock;






/*
 可传空
 urlSessionConfiguration $$$        传空即可
 method $$$                         @"GET"或@"POST",也可传空,默认为 @"GET"
 content_Type $$$                   传入的格式,可传空,默认为 @"application/json"
 accept $$$                         接收的格式,可传空,默认为 @"application/json"
 urlString $$$                      请求地址
 needToken $$$                      是否需要token
 (token $$$ 自动在全局中获取了,如果需要另外设置,则改内部)
 bodyDictionary $$$                 请求体,传入个字典进去即可
 uploadProgressBlock $$$            上传的回调  (这个回调好像被调用一次)
 downloadProgressBlock $$$          下载的回调    (这个回调好像还没被调用过)
 
 successBlock $$$                   改进的回调,成功回调
 failureBlock $$$                   改进的回调,失败回调
 completionHandlerBlock $$$         这是原汁原味的任务结束回调,需要根据error来判断成功与否
 
 */
//是否需要原汁原味
#define YUANZHIYUANWEI 0
+ (void)urlSessionWithURLSessionConfiguration:(NSURLSessionConfiguration *_Nullable)urlSessionConfiguration
                              andContent_Type:(NSString * _Nullable )content_Type
                                    andAccept:(NSString * _Nullable )accept
                                    andMethod:(NSString * _Nonnull )method
                                 andURLString:(NSString *_Nonnull)urlString
                            andBodyDictionary:(NSDictionary * _Nullable )bodyDictionary
                                 andNeedToken:(BOOL)needToken
//                                  andToken:(NSString *)token
                       andUploadProgressBlock:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgressBlock
                     andDownloadProgressBlock:(nullable void (^)(NSProgress * _Nullable downloadProgress)) downloadProgressBlock
#if YUANZHIYUANWEI
                 andCompletionHandlerBlock:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandlerBlock
#else
                           andSuccessBlock:(JJURLSessionManagerSuccessBlock _Nonnull )successBlock
                           andFailureBlock:(JJURLSessionManagerFailureBlock _Nonnull )failureBlock
#endif
;

+ (void)login_Method:(NSString * _Nonnull )method
        andURLString:(NSString * _Nonnull )urlString
   andBodyDictionary:(NSDictionary * _Nullable )bodyDictionary
     andSuccessBlock:(JJURLSessionManagerSuccessBlock _Nonnull )successBlock
     andFailureBlock:(JJURLSessionManagerFailureBlock _Nonnull )failureBlock;

//是否需要token获取数据(body)
+ (void)getData_Method:(NSString * _Nonnull )method
          andURLString:(NSString *_Nonnull)urlString
               andBody:(NSDictionary * _Nullable )bodyDictionary
          andNeedToken:(BOOL)needToken
       andSuccessBlock:(JJURLSessionManagerSuccessBlock _Nonnull )successBlock
       andFailureBlock:(JJURLSessionManagerFailureBlock _Nonnull )failureBlock;

//是否需要token获取数据(parameter)
+ (void)getData_Method:(NSString * _Nonnull )method
          andURLString:(NSString *_Nonnull)urlString
          andParameter:(NSDictionary * _Nullable )parameter
          andNeedToken:(BOOL)needToken
       andSuccessBlock:(JJURLSessionManagerSuccessBlock _Nonnull )successBlock
       andFailureBlock:(JJURLSessionManagerFailureBlock _Nonnull )failureBlock;




@end
