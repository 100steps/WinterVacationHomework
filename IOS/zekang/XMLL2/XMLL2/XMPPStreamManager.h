//
//  XMPPStreamManager.h
//  XMLL2
//
//  Created by zzddn on 2017/1/23.
//  Copyright © 2017年 zzddn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#import "XMPPRoster.h"
#import "XMPPRosterCoreDataStorage.h"
#import "XMPPMessage.h"
@class XMPPStreamManager;
@protocol XMPPStreamManagerDelegate <NSObject>
@optional
- (void)didReceiveMessage:(XMPPStreamManager *)sender andChatMessage: (NSString *)chatMessage;
@end
@interface XMPPStreamManager : NSObject
@property (nonatomic,strong)XMPPStream *xmppStream;
@property BOOL registerSucceed;
@property (nonatomic,strong)XMPPRoster *roster;
@property (nonatomic,strong)NSMutableDictionary *indexDic;
@property (nonatomic,weak)id<XMPPStreamManagerDelegate>delegate;
@property (nonatomic,copy)NSString *chatJID;
+ (instancetype)sharedManager;
- (void)loginToServerWithJID:(XMPPJID *)myJID andPassword:(NSString *)password andTitle:(NSString *)title;
@end
