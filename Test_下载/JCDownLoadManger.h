//
//  JCDownLoadManger.h
//  Test_下载
//
//  Created by admin on 15-1-26.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface JCDownLoadManger : NSObject

@property (nonatomic) NSInteger tag;

@property (nonatomic,strong) NSString *downLoadName;

@property(nonatomic) BOOL isComplited;//判断是否完成

@property (nonatomic) BOOL isPause;//判断暂停

@property(nonatomic , strong) NSURL* url;

@property (nonatomic) CGFloat percent;

@property(nonatomic,strong) NSString *error;

@property (nonatomic,strong) NSString *btyeProgress;  //已下载和文件总大小：12/50 M

@property(nonatomic,copy) NSString *(^cachePath)(void);

@property(nonatomic , strong) AFHTTPRequestOperation* requestOperation;

@property(nonatomic, copy) void(^progressBlock)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead);

@property(nonatomic ,copy) void(^downLoadSuccess)(AFHTTPRequestOperation *operation, id responseObject);

@property(nonatomic,copy) void(^downLoadFailed)(NSString *error);

-(void)downloadWithUrl:(id)url
             cachePath:(NSString* (^) (void))cacheBlock
         progressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))progressBlock
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
         VcacheResponse:(void(^)(NSCachedURLResponse *cachedResponse))VcacheResponse;


-(instancetype)initWithURL:(NSURL*)URL andfileName:(NSString *)name;

-(void)startDownLoad;

-(void)stopDownLoad;


//获取路径下所以的文件
+(NSArray *)getFileNameInThePath:(NSString *)path;


/**
   *  写数据的文件句柄
*/
 @property (nonatomic, strong) NSFileHandle *writeHandle;

@property (nonatomic,strong) NSString *myPath;

@end
