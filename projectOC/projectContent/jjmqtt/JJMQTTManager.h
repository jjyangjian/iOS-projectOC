//
//  JJMQTTManager.h
//  shebeijiance
//
//  Created by 杨剑 on 2019/3/30.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MQTTClient.h>
NS_ASSUME_NONNULL_BEGIN

//host: 服务器地址
#define JJMQTT_HOST         @"101.201.81.161"

//part: 服务器端口
#define JJMQTT_PORT         9090
//#define JJMQTT_PORT         9091

//tls:是否使用tls协议，mosca是支持tls的，如果使用了要设置成true
#define JJMQTT_TLS          1

//keepalive: 心跳时间，单位秒，每隔固定时间发送心跳包, 心跳间隔不得大于120s
#define JJMQTT_KEEPALIVE    20

//clean: session是否清除，这个需要注意，如果是false，代表保持登录，如果客户端离线了再次登录就可以接收到离线消息
#define JJMQTT_CLEAN        1

//auth: 是否使用登录验证
#define JJMQTT_AUTH         true

//user: 用户名
#define JJMQTT_USER         @"zrkj01"

//pass: 密码
#define JJMQTT_PASS         @"5736D48018E1A55AEE47261209114BAC498F33C2FFA5A599600C2D8E10C60CD371DAC5FB47C03D6D56196FB8C18D149DAD810088093A9CEBF41AE960262B181B"

//willTopic: 订阅主题
#define JJMQTT_WILL_TOPIC   @"/cio/01/data/300000/+"

//willMsg: 自定义的离线消息
#define JJMQTT_WILL_MSG     @"mqtt"

//willQos: 接收离线消息的级别
#define JJMQTT_WILL_QOS     1

//clientId: 客户端id，需要特别指出的是这个id需要全局唯一，因为服务端是根据这个来区分不同的客户端的，默认情况下一个id登录后，假如有另外的连接以这个id登录，上一个连接会被踢下线, 我使用的设备UUID
#define JJMQTT_CLIENT_ID    @"txm_1554341296"

@class JJMQTTManager;

@protocol JJMQTTManagerDelegate <NSObject>

//接收.好像握手时候用到了
- (void)mqttManager:(JJMQTTManager *)manager received:(MQTTSession *)session type:(MQTTCommandType)type qos:(MQTTQosLevel)qos retained:(BOOL)retained duped:(BOOL)duped mid:(UInt16)mid data:(NSData *)data;

//连接成功
- (void)mqttManager:(JJMQTTManager *)manager connected:(MQTTSession *)session;

//返回内容
- (void)mqttManager:(JJMQTTManager *)manager newMessage:(MQTTSession *)session data:(NSData*)data onTopic:(NSString*)topic qos:(MQTTQosLevel)qos retained:(BOOL)retained mid:(unsigned int)mid;

//关闭
- (void)mqttManager:(JJMQTTManager *)manager connectionClosed:(MQTTSession *)session;

//错误
- (void)mqttManager:(JJMQTTManager *)manager connectionError:(MQTTSession *)session error:(NSError *)error;

//拒绝
- (void)mqttManager:(JJMQTTManager *)manager connectionRefused:(MQTTSession *)session error:(NSError *)error;

//向后兼容,暂时无用
- (void)mqttManager:(JJMQTTManager *)manager session:(MQTTSession*)session newMessage:(NSData*)data onTopic:(NSString*)topic;

//处理事件
- (void)mqttManager:(JJMQTTManager *)manager handleEvent:(MQTTSession *)session event:(MQTTSessionEvent)eventCode error:(NSError *)error;


@end



@interface JJMQTTManager : NSObject


@property (nonatomic,weak)id <JJMQTTManagerDelegate> delegate;

@property (nonatomic,strong)NSString *topic;

- (instancetype)initWithDelegate:(id)delegate;

- (void)mqttConnect;





@end

NS_ASSUME_NONNULL_END
