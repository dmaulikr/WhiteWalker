//  通用操作类
//  ToolsUtil.h
//  WhiteWalker
//
//  Created by Amon on 2017/3/13.
//  Copyright © 2017年 GodPlace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolsUtil : NSObject

+ (void)saveToUserDefaults:(NSDictionary *)dic dictName:(NSString *)dictName;

+ (void)saveUserConfigToNSUserDefaults:(NSDictionary *)dic;

+ (void)saveAppConfigToNSUserDefaults:(NSDictionary *)dic;

+ (NSDictionary *)getUserDefaults:(NSString *)dictName;

+ (NSDictionary *)getUserConfig;

+ (NSDictionary *)getAppConfig;

@end
