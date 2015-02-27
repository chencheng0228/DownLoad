//
//  MyTaskSingle.m
//  Test_下载
//
//  Created by admin on 15-1-29.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "MyTaskSingle.h"
#import "JCDownLoadManger.h"
#import "SecondViewController.h"

static MyTaskSingle *sharedMyTask = nil;
@implementation MyTaskSingle

+(MyTaskSingle *)sharedMyTaskSingle
{
    @synchronized(self)
    {
        if (sharedMyTask==nil) {
            
            sharedMyTask = [[[self class]alloc] init];
            sharedMyTask.taskArr = [NSMutableArray array];
            
        }
    }
    return sharedMyTask;
    
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self)
    {
        if (sharedMyTask==nil) {
            sharedMyTask = [super allocWithZone:zone];
            return sharedMyTask;
        }
        
    }
    return nil;
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}




-(void)downLoadTask:(NSDictionary*)dic
{
    
    JCDownLoadManger *mange = [[JCDownLoadManger alloc] initWithURL:[NSURL URLWithString:[dic objectForKey:@"url"]] andfileName:[dic objectForKey:@"name"]];
    
    mange.tag = self.taskArr.count+1;
    [mange addObserver:self forKeyPath:@"btyeProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [mange addObserver:self forKeyPath:@"isComplited" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [self.taskArr addObject:mange];
        
    
    
    
    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    JCDownLoadManger *manger = object;
    NSLog(@"hope====%@",manger.btyeProgress);
    if ([keyPath isEqualToString:@"btyeProgress"]) {
        
        if ([self.delegate respondsToSelector:@selector(taskPrigress:andState:)]) {
            [self.delegate taskPrigress:manger andState:@"btyeProgress"];
        }

        
            }
    else if ([keyPath isEqualToString:@"isComplited"])
    {
        if ([self.delegate respondsToSelector:@selector(taskPrigress:andState:)]) {
            [self.delegate taskPrigress:manger andState:@"isComplited"];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
