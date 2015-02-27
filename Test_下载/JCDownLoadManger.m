//
//  JCDownLoadManger.m
//  Test_下载
//
//  Created by admin on 15-1-26.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "JCDownLoadManger.h"

@implementation JCDownLoadManger

-(NSFileHandle*)writeHandle
{
    if (!_writeHandle) {
                 _writeHandle = [NSFileHandle fileHandleForWritingAtPath:self.myPath];
             }
        return _writeHandle;
}


-(instancetype)initWithURL:(NSURL*)URL andfileName:(NSString *)name
{
    self = [super init];
    if (self) {
        NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",name]];
        self.myPath = path;
        __weak JCDownLoadManger *weakSelf = self;
        [self downloadWithUrl:URL cachePath:^NSString *{
            return path;
        } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            
            weakSelf.btyeProgress = [NSString stringWithFormat:@"%@/%@",[weakSelf formatByteCount:totalBytesRead],[weakSelf formatByteCount:totalBytesExpectedToRead]];
            weakSelf.percent = (double)totalBytesRead/totalBytesExpectedToRead;
            
            // NSLog(@"%f===%@ ===%@",(double)totalBytesRead/totalBytesExpectedToRead,weakSelf.btyeProgress,path);
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            weakSelf.isComplited = YES;
            //weakSelf.downLoadSuccess(operation,responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            weakSelf.error = error.localizedDescription;
        }VcacheResponse:^(NSCachedURLResponse *cachedResponse) {
            NSLog(@"hello=====%@",cachedResponse.data);
        }
         ];
          //开始下载
          // [self.requestOperation start];
    }
    return self;
}

-(void)startDownLoad
{
     self.isPause = YES;
    [self.requestOperation resume];
}

-(void)stopDownLoad
{
    self.isPause = NO;
    [self.requestOperation pause];
}


-(void)downloadWithUrl:(id)url
             cachePath:(NSString* (^) (void))cacheBlock
         progressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))progressBlock
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
         VcacheResponse:(void(^)(NSCachedURLResponse *cachedResponse))VcacheResponse
{
    
    //获取下载的名字：使用url当做名字
    self.downLoadName = [NSString stringWithFormat:@"%@",url];
    
    //存储路径
    self.cachePath = cacheBlock;
    
    //获取存储的长度
    long long cacheLength = [[self class] cacheFileWithPath:self.cachePath()];
    NSLog(@"cacheLength = %llu",cacheLength);
    
    //获取请求
    NSMutableURLRequest* request = [[self class] requestWithUrl:url Range:cacheLength];
    
    self.requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    //实例化NSOutputStream对象，并且open为保存文件做准备。
    [self.requestOperation setOutputStream:[NSOutputStream outputStreamToFileAtPath:self.cachePath() append:NO]];
    
    //处理流 ==通过输出流对象，将数据写入到指定的文件中
    [self readCacheToOutStreamWithPath:self.cachePath()];
    
    
    
    //获取进度块
    self.progressBlock = progressBlock;
    
    //重组进度block
    [self.requestOperation setDownloadProgressBlock:[self getNewProgressBlockWithCacheLength:cacheLength]];

     //  [self.requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
    
     //        progressBlock(bytesRead,totalBytesRead+cacheLength,totalBytesExpectedToRead);
     //    }];
    
    
    [self.requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
    
   
    
    
    
}

#pragma mark - 获取本地缓存的字节
+(long long)cacheFileWithPath:(NSString*)path
{
    NSFileHandle* fh = [NSFileHandle fileHandleForReadingAtPath:path];
    
    NSData* contentData = [fh readDataToEndOfFile];
    return contentData ? contentData.length : 0;
    
}

#pragma mark - 获取请求

+(NSMutableURLRequest*)requestWithUrl:(id)url Range:(long long)length
{
    NSURL* requestUrl = [url isKindOfClass:[NSURL class]] ? url : [NSURL URLWithString:url];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:requestUrl
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:5];
    
    
    if (length) {
        [request setValue:[NSString stringWithFormat:@"bytes=%lld-",length] forHTTPHeaderField:@"Range"];
    }
    
    NSLog(@"request.head = %@",request.allHTTPHeaderFields);
    
    return request;
    
}

#pragma mark - 读取本地缓存入流
-(void)readCacheToOutStreamWithPath:(NSString*)path
{
    NSFileHandle* fh = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData* currentData = [fh readDataToEndOfFile];
    
    if (currentData.length) {
        //打开流，写入data ， 未打卡查看 streamCode = NSStreamStatusNotOpen
        [self.requestOperation.outputStream open];
        
        NSInteger       bytesWritten;
        NSInteger       bytesWrittenSoFar;
        
        NSInteger  dataLength = [currentData length];
        const uint8_t * dataBytes  = [currentData bytes];
        
        bytesWrittenSoFar = 0;
        do {
            bytesWritten = [self.requestOperation.outputStream write:&dataBytes[bytesWrittenSoFar] maxLength:dataLength - bytesWrittenSoFar];
            assert(bytesWritten != 0);
            if (bytesWritten == -1) {
                break;
            } else {
                bytesWrittenSoFar += bytesWritten;
            }
        } while (bytesWrittenSoFar != dataLength);
        
        
    }
}

#pragma mark - 重组进度块
-(void(^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))getNewProgressBlockWithCacheLength:(long long)cachLength
{
    typeof(self)newSelf = self;
    void(^newProgressBlock)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) = ^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead)
    {
        //此部分会引起内存大量增加，未及时释放。
        // NSData* data = [NSData dataWithContentsOfFile:self.cachePath()];
        // [newSelf.requestOperation setValue:data forKey:@"responseData"];
        
        newSelf.progressBlock(bytesRead,totalBytesRead + cachLength,totalBytesExpectedToRead + cachLength);
       
    };
    
    return newProgressBlock;
}



- (NSString*)formatByteCount:(long long)size
{
    return [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
}


//获取路径下的所有的文件。。。。。...........................
+(NSArray *)getFileNameInThePath:(NSString *)path
{
    NSArray *array = [[NSFileManager defaultManager] subpathsAtPath:path];
    return array;
}


@end
