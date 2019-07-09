//
//  JJDownload.m
//  jjxinfadi
//
//  Created by CMP on 2018/7/14.
//  Copyright © 2018年 ChiefCadet. All rights reserved.
//

#import "JJDownload.h"

//static AFHTTPSessionManager *manager;

@implementation JJDownload

//正常请求
+ (void)downloadDataWithIsPost:(BOOL)isPost andURLString:(NSString *)urlString andParameter:(NSDictionary *)parameter andSuccessBlock:(JJUpdateDataSuccessBlock)successBlock andFailBlock:(JJUpdateDataFailBlock)failBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
    manager.requestSerializer.timeoutInterval = 10.0f;
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    if (isPost) {
        [manager POST:urlString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (!responseObject) {
                NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_NULL code:CODE_VALUE_NULL.intValue userInfo:nil];
                failBlock(error,error.domain,CODE_VALUE_NULL);
                return ;
            }
            NSDictionary * dic = responseObject ;
            if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_SUCCESS]) {
                successBlock(dic);
            }else if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_OTHERLOGIN]){
//                [JJExtern gotoDengluController];
                //账号在其他地方登录
            }else{
                NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_SUCCESSERROR code:[JJSTRING(dic[CODE_KEY]) intValue] userInfo:nil];
                failBlock(error,dic[CODEMESSAGE_KEY],dic[CODE_KEY]);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            failBlock(error,CODEMESSAGE_VALUE_ERROR,[NSString stringWithFormat:@"%ld",(long)error.code]);
        }];
    }else{
        [manager GET:urlString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (!responseObject) {
                NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_NULL code:CODE_VALUE_NULL.intValue userInfo:nil];
                failBlock(error,error.domain,CODE_VALUE_NULL);
                return ;
            }
            NSDictionary * dic = responseObject ;
            if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_SUCCESS]) {
                successBlock(dic);
            }else if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_OTHERLOGIN]){
                //账号在其他地方登录
            }else{
                NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_SUCCESSERROR code:[JJSTRING(dic[CODE_KEY]) intValue] userInfo:nil];
                failBlock(error,dic[CODEMESSAGE_KEY],dic[CODE_KEY]);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            failBlock(error,CODEMESSAGE_VALUE_ERROR,[NSString stringWithFormat:@"%ld",(long)error.code]);
        }];
    }
}

//测试
+ (void)ceshidownloadDataWithIsPost:(BOOL)isPost andURLString:(NSString *)urlString andParameter:(NSDictionary *)parameter andSuccessBlock:(JJUpdateDataSuccessBlock)successBlock andFailBlock:(JJUpdateDataFailBlock)failBlock{
    //
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    if (isPost) {
        [manager POST:urlString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSJSONReadingAllowFragments];
            NSLog(@"%@",str);
            NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_SUCCESSERROR code:999 userInfo:nil];
            failBlock(error,error.domain,[NSString stringWithFormat:@"%ld",(long)error.code]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"failure!!! %@",error);
            failBlock(error,CODEMESSAGE_VALUE_ERROR,[NSString stringWithFormat:@"%ld",(long)error.code]);
        }];
    }else{
        [manager GET:urlString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if ([@"1" hasSuffix:JJSTRING(dic[CODE_KEY])]) {
                successBlock(dic);
            }else{
                NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_SUCCESSERROR code:[JJSTRING(dic[CODE_KEY]) intValue] userInfo:nil];
                failBlock(error,dic[CODEMESSAGE_KEY],JJSTRING(dic[CODE_KEY]));
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failBlock(error,CODEMESSAGE_VALUE_ERROR,[NSString stringWithFormat:@"%ld",(long)error.code]);
        }];
    }
}



+ (void)uploadOneImageDataWithURLString:(NSString *)urlString andParameter:(NSDictionary *)parameter andImageInfo:(NSDictionary *)imageInfo andUpdateDataProgressBlock:(JJUpdateDataProgressBlock)progressBlock andSuccessBlock:(JJUpdateDataSuccessBlock)successBlock andFailBlock:(JJUpdateDataFailBlock)failBlock;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager = [AFHTTPSessionManager manager];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"image/gif",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    [manager                        POST:urlString
                              parameters:parameter
               constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                   if (! imageInfo.allKeys.count) {
                       return ;
                   }
                   [formData appendPartWithFileData:imageInfo[@"data"]
                                               name:imageInfo[@"name"] //@"file"//imageName
                                           fileName:@"jj.jpeg"//@"file.jpg"//
                                           mimeType:@"image/jpeg"];
               } progress:^(NSProgress * _Nonnull uploadProgress) {
                   dispatch_sync(dispatch_get_main_queue(), ^{
                       progressBlock(uploadProgress);
                   });
               } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#if 0
                   NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSJSONReadingAllowFragments];
                   NSLog(@"%@",str);
#else
                   if (!responseObject) {
                       NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_NULL code:CODE_VALUE_NULL.intValue userInfo:nil];
                       failBlock(error,error.domain,CODE_VALUE_NULL);
                       return ;
                   }
                   NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                   if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_SUCCESS]) {
                       successBlock(dic);
                   }else if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_OTHERLOGIN]){
                       //账号在其他地方登录

                   }else{
                       NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_SUCCESSERROR code:[JJSTRING(dic[CODE_KEY]) intValue] userInfo:nil];
                       failBlock(error,dic[CODEMESSAGE_KEY],dic[CODE_KEY]);
                   }
#endif
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"%@",error);
                   failBlock(error,CODEMESSAGE_VALUE_ERROR,[NSString stringWithFormat:@"%ld",(long)error.code]);
               }];
}
//上传多张图片

+ (void)uploadMoreImageDataWithURLString:(NSString *)urlString andParameter:(NSDictionary *)parameter andImageInfoArray:(NSArray *)imageInfoArray andUpdateDataProgressBlock:(JJUpdateDataProgressBlock)progressBlock andSuccessBlock:(JJUpdateDataSuccessBlock)successBlock andFailBlock:(JJUpdateDataFailBlock)failBlock;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager = [AFHTTPSessionManager manager];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"image/gif",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    [manager                        POST:urlString
                              parameters:parameter
               constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                   for (int i = 0; i < imageInfoArray.count; i ++) {
//                       NSString *nameString = [NSString stringWithFormat:@"%@%d",name,i];
//                       NSString *type = [self contentTypeForImageData:imageInfoArray[i][@"data"]];
//                       NSLog(@"第%d张:格式:(%@);大小(字节):(%lu);大小(kb):(%lu);",i,type,(unsigned long)imageInfoArray[i].length,imageInfoArray[i].length / 1024);
                       [formData appendPartWithFileData:imageInfoArray[i][@"data"]
                                                   name:imageInfoArray[i][@"name"]//@"file"//imageName
                                               fileName:@"jj.jpeg"//@"file.jpg"//
                                               mimeType:@"image/jpeg"];
                       [formData appendPartWithFormData:[@";" dataUsingEncoding:NSUTF8StringEncoding] name:@""];
                   }
               } progress:^(NSProgress * _Nonnull uploadProgress) {
                   dispatch_sync(dispatch_get_main_queue(), ^{
                       progressBlock(uploadProgress);
                   });
               } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#if 0
                   NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSJSONReadingAllowFragments];
                   NSLog(@"%@",str);
#else
                   if (!responseObject) {
                       NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_NULL code:CODE_VALUE_NULL.intValue userInfo:nil];
                       failBlock(error,error.domain,CODE_VALUE_NULL);
                       return ;
                   }
                   NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                   if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_SUCCESS]) {
                       successBlock(dic);
                   }else if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_OTHERLOGIN]){
                       //账号在其他地方登录
                   }else{
                       NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_SUCCESSERROR code:[JJSTRING(dic[CODE_KEY]) intValue] userInfo:nil];
                       failBlock(error,dic[CODEMESSAGE_KEY],dic[CODE_KEY]);
                   }
#endif
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   NSLog(@"%@",error);
                   failBlock(error,CODEMESSAGE_VALUE_ERROR,[NSString stringWithFormat:@"%ld",(long)error.code]);
               }];

}

//通过图片Data数据第一个字节 来获取图片扩展名
+ (NSString *)contentTypeForImageData:(NSData *)data{
    uint8_t c;
    [data getBytes:&c length:1];
    printf("%c",c);
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return @"jpg";
    }
    return @"jpg";
}

//是否需要原汁原味
+ (void)urlSessionWithURLSessionConfiguration:(NSURLSessionConfiguration *)urlSessionConfiguration
                              andContent_Type:(NSString * _Nullable )content_Type
                                    andAccept:(NSString * _Nullable )accept
                                    andMethod:(NSString * _Nonnull )method
                                 andURLString:(NSString *)urlString
                            andBodyDictionary:(NSDictionary * _Nullable )bodyDictionary
                                 andNeedToken:(BOOL)needToken
//                                  andToken:(NSString *)token
                       andUploadProgressBlock:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                     andDownloadProgressBlock:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
#if YUANZHIYUANWEI
                    andCompletionHandlerBlock:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandlerBlock
#else
                              andSuccessBlock:(JJURLSessionManagerSuccessBlock)successBlock
                              andFailureBlock:(JJURLSessionManagerFailureBlock)failureBlock
#endif
{
    
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:urlSessionConfiguration];
    
    if (method && method.length) {
    }else{
        method = @"GET";
    }
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:urlString parameters:nil error:nil];
    //        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    //        request.HTTPMethod = @"POST";
    //设置超时时长
    request.timeoutInterval= 8;
    //设置上传数据type
    if (content_Type && content_Type.length) {
        [request setValue:accept forHTTPHeaderField:@"Content-Type"];
    }else{
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    //设置接受数据type
    if (accept && accept.length) {
        [request setValue:accept forHTTPHeaderField:@"Accept"];
    }else{
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    
    NSString *token = [JJExtern sharedJJ].token;
    if (needToken) {
        if (token && token.length) {
            [request setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
        }else{
            NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_NOLOGIN
                                                        code:CODE_VALUE_NOLOGIN.intValue
                                                    userInfo:nil];
            failureBlock(error);
            return;
        }
    }
    if (bodyDictionary) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyDictionary options:0 error:nil];
        //        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [request setHTTPBody:jsonData];
    }else{
    }

    NSURLSessionDataTask *task =
#if YUANZHIYUANWEI
    [sessionManager dataTaskWithRequest:request
                         uploadProgress:uploadProgressBlock
                       downloadProgress:downloadProgressBlock
                      completionHandler:completionHandlerBlock];
#else
    [sessionManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgressBlock) {
            uploadProgressBlock(uploadProgress);
        }
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        if (downloadProgressBlock) {
            downloadProgressBlock(downloadProgress);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
            return ;
        }
        if (!responseObject) {
            NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_NULL
                                                        code:CODE_VALUE_NULL.intValue
                                                    userInfo:nil];
            failureBlock(error);
            return ;
        }
        NSDictionary * dic = responseObject ;
        if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_SUCCESS]) {
            successBlock(dic[CODEMESSAGE_KEY],dic);
            return;
        }else if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_OTHERLOGIN]){
            //账号在其他地方登录
            NSError *error = [[NSError alloc] initWithDomain:dic[CODEMESSAGE_KEY]
                                                        code:CODE_VALUE_OTHERLOGIN.intValue
                                                    userInfo:nil];
            failureBlock(error);
            return;
        }else{
            NSError *error = [[NSError alloc] initWithDomain:JJSTRING(dic[CODEMESSAGE_KEY]) code:[JJSTRING(dic[CODE_KEY]) intValue] userInfo:nil];
            failureBlock(error);
            return;
        }
    }];
#endif
    [task resume];
    return;
    
}

+ (void)login_Method:(NSString * _Nonnull )method
        andURLString:(NSString * _Nonnull )urlString
   andBodyDictionary:(NSDictionary * _Nullable )bodyDictionary
     andSuccessBlock:(JJURLSessionManagerSuccessBlock _Nonnull )successBlock
     andFailureBlock:(JJURLSessionManagerFailureBlock _Nonnull )failureBlock;
{
    [self urlSessionWithURLSessionConfiguration:nil
                                andContent_Type:nil
                                      andAccept:nil
                                      andMethod:method
                                   andURLString:urlString
                              andBodyDictionary:bodyDictionary
                                   andNeedToken:0
                         andUploadProgressBlock:nil andDownloadProgressBlock:nil andSuccessBlock:successBlock andFailureBlock:failureBlock];
}

+ (void)getData_Method:(NSString * _Nonnull )method
          andURLString:(NSString *_Nonnull)urlString
               andBody:(NSDictionary * _Nullable )bodyDictionary
          andNeedToken:(BOOL)needToken
       andSuccessBlock:(JJURLSessionManagerSuccessBlock _Nonnull )successBlock
       andFailureBlock:(JJURLSessionManagerFailureBlock _Nonnull )failureBlock;
{
    [self urlSessionWithURLSessionConfiguration:nil
                                andContent_Type:nil
                                      andAccept:nil
                                      andMethod:method
                                   andURLString:urlString
                              andBodyDictionary:bodyDictionary
                                   andNeedToken:1
                         andUploadProgressBlock:nil
                       andDownloadProgressBlock:nil
                                andSuccessBlock:successBlock
                                andFailureBlock:failureBlock];
}

//是否需要token获取数据
+ (void)getData_Method:(NSString * _Nonnull )method
          andURLString:(NSString *_Nonnull)urlString
          andParameter:(NSDictionary * _Nullable )parameter
          andNeedToken:(BOOL)needToken
       andSuccessBlock:(JJURLSessionManagerSuccessBlock _Nonnull )successBlock
       andFailureBlock:(JJURLSessionManagerFailureBlock _Nonnull )failureBlock;
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
    manager.requestSerializer.timeoutInterval = 10.0f;
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
    //                                                         @"text/html",
    //                                                         @"image/jpeg",
    //                                                         @"image/png",
    //                                                         @"application/octet-stream",
    //                                                         @"text/json",
    //                                                         nil];
    manager.responseSerializer.acceptableContentTypes = nil;
    
    NSString *token = [JJExtern sharedJJ].token;
    if (needToken) {
        if (token && token.length) {
            [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
        }else{
            NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_NOLOGIN
                                                        code:CODE_VALUE_NOLOGIN.intValue
                                                    userInfo:nil];
            failureBlock(error);
            return;
        }
    }
    if ([method isEqualToString:@"GET"]) {
        [manager GET:urlString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (!responseObject) {
                NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_NULL code:CODE_VALUE_NULL.intValue userInfo:nil];
                failureBlock(error);
                return ;
            }
            NSDictionary * dic = responseObject ;
            if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_SUCCESS]) {
                successBlock(dic[CODEMESSAGE_KEY],dic);
            }else if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_OTHERLOGIN]){
                //                [JJExtern gotoDengluController];
                //账号在其他地方登录
            }else{
                NSError *error = [[NSError alloc] initWithDomain:JJSTRING(dic[CODEMESSAGE_KEY]) code:[JJSTRING(dic[CODE_KEY]) intValue] userInfo:nil];
                failureBlock(error);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            failureBlock(error);
        }];
    }else if ([method isEqualToString:@"POST"]) {
        //        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter options:0 error:NULL];

        [manager POST:urlString
           parameters:parameter
             progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (!responseObject) {
                NSError *error = [[NSError alloc] initWithDomain:CODEMESSAGE_VALUE_NULL code:CODE_VALUE_NULL.intValue userInfo:nil];
                failureBlock(error);
                return ;
            }
            NSDictionary * dic = responseObject ;
            if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_SUCCESS]) {
                successBlock(dic[CODEMESSAGE_KEY],dic);
            }else if ([JJSTRING(dic[CODE_KEY]) isEqualToString:CODE_VALUE_OTHERLOGIN]){
                //                [JJExtern gotoDengluController];
                //账号在其他地方登录
            }else{
                NSError *error = [[NSError alloc] initWithDomain:JJSTRING(dic[CODEMESSAGE_KEY]) code:[JJSTRING(dic[CODE_KEY]) intValue] userInfo:nil];
                failureBlock(error);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            failureBlock(error);
        }];
    }else{
    }
}


@end
