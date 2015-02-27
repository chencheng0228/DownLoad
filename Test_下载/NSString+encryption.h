//
//  NSString+encryption.h
//  Test_下载
//
//  Created by admin on 15-2-2.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (encryption)

-(NSString*) md5 ;

//获取即将要下载文件的大小
-(long long)getFilesize;

//获取本地已经缓存文件的大小
-(long long)cacheFileWithPath;

@end
