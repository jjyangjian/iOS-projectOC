//
//  JJMQTTManager.m
//  shebeijiance
//
//  Created by 杨剑 on 2019/3/30.
//  Copyright © 2019 jjyangjian. All rights reserved.
//

#import "JJMQTTManager.h"

#import <arpa/inet.h>


@interface JJMQTTManager ()

<
//MQTTSessionManagerDelegate
MQTTSessionDelegate
>

@property (nonatomic,strong)MQTTSession *mySession;

@end

@implementation JJMQTTManager

- (instancetype)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)dealloc{
}


- (void)mqttConnect;
{
    
//    MQTTSessionManager *manager = nil;
//    [manager connectTo:nil port:nil tls:nil keepalive:nil clean:nil auth:nil user:nil pass:nil will:nil willTopic:nil willMsg:nil willQos:nil willRetainFlag:nil withClientId:nil securityPolicy:nil certificates:nil protocolLevel:nil connectHandler:^(NSError *error) {
//
//    }];
//
    
    
    
    MQTTCFSocketTransport *transport = [[MQTTCFSocketTransport alloc] init]; // 初始化对象
    
    transport.host = JJMQTT_HOST;//[self domainNameToIP:JJMQTT_HOST]; // 设置MQTT服务器的地址
    transport.port = JJMQTT_PORT; // 设置MQTT服务器的端口（默认是1883，问后台）
    
    self.mySession = [[MQTTSession alloc] init]; // 初始化MQTTSession对象
    
//    self.mySession.host = JJMQTT_HOST;
//    self.mySession.port = 1883;
    
    self.mySession.transport = transport; // 给mySession对象设置基本信息
    self.mySession.delegate = self; // 设置代理，
    [self.mySession setUserName:JJMQTT_USER];//账号(问后台)
    [self.mySession setPassword:JJMQTT_PASS];//密码 (问后台)
    
//    [self.mySession setWillFlag:1];//设定为yes
//    [self.mySession setWillTopic:@""];
    
    self.mySession.willQoS = 1;
    
    NSString *str = [NSString stringWithFormat:@"%@%@",[JJExtern sharedJJ].username,[JJOther getDifferentString]];
    self.mySession.clientId = str;
    
    self.mySession.keepAliveInterval = JJMQTT_KEEPALIVE;
    
//    [self.mySession connectAndWaitTimeout:0]; // 似乎不是异步执行
    JJWEAKSELF
    [self.mySession connectWithConnectHandler:^(NSError *error) {
        if (error) {
            [weakself.delegate mqttManager:weakself connectionError:weakself.mySession error:error];
        }
    }];
}

- (void)mqttClose{
    
    [self.mySession unsubscribeTopic:self.topic];
    [self.mySession closeWithDisconnectHandler:^(NSError *error) {
    }];
}

- (void)handleEvent:(MQTTSession *)session event:(MQTTSessionEvent)eventCode error:(NSError *)error{
    [self.delegate mqttManager:self handleEvent:session event:eventCode error:error];
}

- (void)session:(MQTTSession*)session handleEvent:(MQTTSessionEvent)eventCode;
{
    NSLog(@"handleEvent:%ld",(long)eventCode);
    NSLog(@"handleEvent:status:%ld",(long)session.status);
    
}

- (void)connectionError:(MQTTSession *)session error:(NSError *)error {
    [self.delegate mqttManager:self connectionError:session error:error];
    
}

- (void)connected:(MQTTSession *)session {
    //2
    [self.delegate mqttManager:self connected:session];
}

- (void)connectionClosed:(MQTTSession *)session {
    [self.delegate mqttManager:self connectionClosed:session];
}

- (void)connectionRefused:(MQTTSession *)session error:(NSError *)error {
    [self.delegate mqttManager:self connectionRefused:session error:error];
}

- (void)session:(MQTTSession*)session newMessage:(NSData*)data onTopic:(NSString*)topic;
{
    [self.delegate mqttManager:self session:session newMessage:data onTopic:topic];
}

- (void)received:(MQTTSession *)session type:(MQTTCommandType)type qos:(MQTTQosLevel)qos retained:(BOOL)retained duped:(BOOL)duped mid:(UInt16)mid data:(NSData *)data{
    //1
    [self.delegate mqttManager:self received:session type:type qos:qos retained:retained duped:duped mid:mid data:data];
}

- (void)newMessage:(MQTTSession *)session data:(NSData*)data onTopic:(NSString*)topic qos:(MQTTQosLevel)qos retained:(BOOL)retained mid:(unsigned int)mid {
    [self.delegate mqttManager:self newMessage:session data:data onTopic:topic qos:qos retained:retained mid:mid];
}


@end
