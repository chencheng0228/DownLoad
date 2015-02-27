//
//  DownLoadTableViewCell.m
//  Test_下载
//
//  Created by admin on 15-1-27.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "DownLoadTableViewCell.h"
#import "JCDownLoadManger.h"

@implementation DownLoadTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (IBAction)stop:(id)sender {
    //[self.mange stopDownLoad];
}

-(void)initWithUrl:(NSURL *)url andPathName:(NSString *)name
{
    
    
   self.mange = [[JCDownLoadManger alloc] initWithURL:url andfileName:name];
   [self.mange addObserver:self forKeyPath:@"btyeProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
   NSLog(@"sbsbsb===%@===",self.mange.btyeProgress);
    
}

- (void)text1{
     self.percentLab.text = self.mange.btyeProgress;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"btyeProgress"])
    {
        [self performSelectorOnMainThread:@selector(text1) withObject:nil waitUntilDone:NO];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.percentLab.text = self.mange.btyeProgress;
//
//        });
        [self.progress setProgress:self.mange.percent];
        NSLog(@"1111111===%@===",self.mange.btyeProgress);

    }
    
    else
    {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (NSString*)formatByteCount:(long long)size
{
    return [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
