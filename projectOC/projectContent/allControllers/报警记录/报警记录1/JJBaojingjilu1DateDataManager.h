//
//  JJDateDataManager.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/4/10.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJBaojingjilu1DateDataManager : NSObject

typedef void (^JJDateDataManagerGetDataCompletion) (NSString *_Nullable title,NSArray *_Nullable dataArray,NSError  *_Nullable error,NSString *_Nullable message);


//- (void)getDataWithNian:(NSString *)nian andYue:(NSString *)yue  andCompletion:(JJDateDataManagerGetDataCompletion)completion;

- (void)getDataWithDeviceID:(NSString *)deviceID
            TimestampString:(NSString *)timestampString
                 Completion:(JJDateDataManagerGetDataCompletion)completion;




@end

NS_ASSUME_NONNULL_END
