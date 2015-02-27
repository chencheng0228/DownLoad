//
//  MyTaskSingle.h
//  Test_下载
//
//  Created by admin on 15-1-29.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCDownLoadManger.h"

@protocol myTaskDelegate <NSObject>
@optional
-(void)taskPrigress:(JCDownLoadManger *)manger  andState:(NSString *)state;


@end


@interface MyTaskSingle : NSObject

@property (nonatomic,strong) NSMutableArray *taskArr;

@property (nonatomic,strong) NSOperationQueue *sharedQueue;

+(MyTaskSingle *)sharedMyTaskSingle;

-(void)downLoadTask:(NSDictionary*)dic;

@property (nonatomic,weak)id<myTaskDelegate>delegate;

@end
