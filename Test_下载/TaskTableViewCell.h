//
//  TaskTableViewCell.h
//  Test_下载
//
//  Created by admin on 15-1-29.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *percentLab;
@property (weak, nonatomic) IBOutlet UIProgressView *byteProgress;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
- (IBAction)stop:(id)sender;


@end
