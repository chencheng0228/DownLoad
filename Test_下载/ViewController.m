//
//  ViewController.m
//  Test_下载
//
//  Created by admin on 15-1-26.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

#import "DownLoadTableViewCell.h"
#import "JCDownLoadManger.h"

#import "SecondViewController.h"

#define Vedio @"http://221.228.249.82/youku/697A5CA0CEB3582FB91C4E3A88/03002001004E644FA2997704E9D2A7BA1E7B9D-6CAB-79A9-E635-3B92A92B3500.mp4"
#define newrsf @"http://222.89.195.226:81/WindowsXP_SP2.exe"

#define Picture @"http://x1.zhuti.com/down/2012/11/29-win7/3D-1.jpg"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *urlArr;
@property (nonatomic,strong) NSArray *pathName;

@property (nonatomic,strong) JCDownLoadManger *mange;

@property (nonatomic, strong)     NSURLSessionDownloadTask *downloadTask;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
// Do any additional setup after loading the view, typically from a nib.
    
    self.urlArr = [NSArray arrayWithObjects:newrsf,newrsf,Picture,nil];
    self.pathName = [NSArray arrayWithObjects:@"newrsf",@"newrsf",@"Picture",nil];
    
    
//    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/temp"];
//    NSLog(@"path = %@",path);
//   JCDownLoadManger *  operation = [[JCDownLoadManger alloc] init];
//    [operation downloadWithUrl:newrsf cachePath:^NSString *{
//        return path;
//    } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        NSLog(@"bytesRead = %u ,totalBytesRead = %llu totalBytesExpectedToRead = %llu",bytesRead,totalBytesRead,totalBytesExpectedToRead);
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
    
   // [self test2];
    
    
    
    
}







- (void)test2{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    

    
    NSURL *URL = [NSURL URLWithString:newrsf];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    self.downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL*(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) firstObject]];

            return [documentsDirectoryPath URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL*filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);        
    }];
    
    [self.downloadTask resume];
    

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;//self.urlArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *intertifer = @"DownLoadCell";
    DownLoadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:intertifer forIndexPath:indexPath];
    //[cell initWithUrl:[NSURL URLWithString:[self.urlArr objectAtIndex:indexPath.row]] andPathName:[self.pathName objectAtIndex:indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SecondViewController *second = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]  instantiateViewControllerWithIdentifier:@"SecondViewController"];
    [self presentViewController:second animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
