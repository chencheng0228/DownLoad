//
//  DownLoadTableViewCell.h
//  Test_下载
//
//  Created by admin on 15-1-27.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCDownLoadManger.h"

@interface DownLoadTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *percentLab;

@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@property (weak, nonatomic) IBOutlet UILabel *totalLab;

@property (nonatomic,strong) JCDownLoadManger *mange;

- (IBAction)stop:(id)sender;

-(void)initWithUrl:(NSURL *)url andPathName:(NSString *)name;

@end
