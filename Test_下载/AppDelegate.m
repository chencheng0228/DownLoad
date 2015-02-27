//
//  AppDelegate.m
//  Test_下载
//
//  Created by admin on 15-1-26.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTaskSingle.h"
#import <CommonCrypto/CommonDigest.h>

#define newrsf @"http://222.89.195.226:81/WindowsXP_SP2.exe"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    //将地址url加密最为文件名字。。。。
//    NSString *str = [self md5:newrsf];
    
    //添加本地先前下载的任务
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents"]];
   // NSString *path2 = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Cache.db"]];
   // [[NSFileManager defaultManager]moveItemAtPath:path toPath:path2 error:nil];
    
    NSArray *arr = [[NSFileManager defaultManager] subpathsAtPath:path];
    if (arr.count!=0) {
        for (int n=0; n<arr.count; n++) {
            NSString *str = [arr objectAtIndex:n];
             NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:str],@"url",str,@"name", nil];
            [[MyTaskSingle sharedMyTaskSingle] downLoadTask:dic];
        }
       
    }
    
    return YES;
}

//-(NSString*) md5:(NSString *)str {
//    const char * cStrValue = [str UTF8String];
//    unsigned char theResult[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(cStrValue, strlen(cStrValue), theResult);
//    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//            theResult[0], theResult[1], theResult[2], theResult[3],
//            theResult[4], theResult[5], theResult[6], theResult[7],
//            theResult[8], theResult[9], theResult[10], theResult[11],
//            theResult[12], theResult[13], theResult[14], theResult[15]];
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
