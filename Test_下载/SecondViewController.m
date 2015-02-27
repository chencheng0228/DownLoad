//
//  SecondViewController.m
//  Test_下载
//
//  Created by admin on 15-1-29.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "SecondViewController.h"
#import "JCDownLoadManger.h"
#import "DownLoadTableViewCell.h"
#import "MyTaskSingle.h"
#import "TaskTableViewCell.h"
#import "ThirdTableViewController.h"

#import "NSString+encryption.h"

#define newrsf @"http://222.89.195.226:81/WindowsXP_SP2.exe"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)addTask:(id)sender {
    
    if (self.addressFiled.text.length) {
        //未完成======如何存储文件名===url
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjects:@[self.addressFiled.text,[self.addressFiled.text md5]] forKeys:@[@"url",@"name"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.addressFiled.text forKey:[self.addressFiled.text md5]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[MyTaskSingle sharedMyTaskSingle] downLoadTask:dic];
        
        //执行下载任务
        JCDownLoadManger *manger = [[MyTaskSingle sharedMyTaskSingle].taskArr lastObject];
        //开始下载
        [manger.requestOperation start];
        

        
    }
    
}


//加载下载任务==========================================================

- (IBAction)goDownLoadInterface:(id)sender {
    
    ThirdTableViewController *third = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ThirdTableViewController"];
    [self presentViewController:third animated:YES completion:nil];
}
@end
