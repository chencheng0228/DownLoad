//
//  NSString+encryption.m
//  Test_下载
//
//  Created by admin on 15-2-2.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "NSString+encryption.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (encryption)

-(NSString*) md5 {
    const char * cStrValue = [self UTF8String];
    unsigned char theResult[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStrValue, strlen(cStrValue), theResult);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            theResult[0], theResult[1], theResult[2], theResult[3],
            theResult[4], theResult[5], theResult[6], theResult[7],
            theResult[8], theResult[9], theResult[10], theResult[11],
            theResult[12], theResult[13], theResult[14], theResult[15]];
}

//获取即将要下载文件的大小
-(long long)getFilesize
{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self]];
    request.HTTPMethod = @"HEAD";
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.expectedContentLength/(1024*1024);
    
}


#pragma mark - 获取本地缓存的字节
-(long long)cacheFileWithPath
{
    NSFileHandle* fh = [NSFileHandle fileHandleForReadingAtPath:self];
    
    NSData* contentData = [fh readDataToEndOfFile];
    return contentData ? contentData.length/(1024*1024) : 0;
    
}

@end
