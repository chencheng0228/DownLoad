//
//  SecondViewController.h
//  Test_下载
//
//  Created by admin on 15-1-29.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

- (IBAction)back:(id)sender;
- (IBAction)addTask:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *addressFiled;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)goDownLoadInterface:(id)sender;


@end
