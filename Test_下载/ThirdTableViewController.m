//
//  ThirdTableViewController.m
//  Test_下载
//
//  Created by admin on 15-1-30.
//  Copyright (c) 2015年 ___CC___. All rights reserved.
//

#import "ThirdTableViewController.h"
#import "MyTaskSingle.h"
#import "TaskTableViewCell.h"
#import "NSString+encryption.h"

@interface ThirdTableViewController ()<myTaskDelegate>

@end

@implementation ThirdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [MyTaskSingle sharedMyTaskSingle].delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      return [MyTaskSingle sharedMyTaskSingle].taskArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskTableViewCell" forIndexPath:indexPath];
     JCDownLoadManger *manger = [[MyTaskSingle sharedMyTaskSingle].taskArr objectAtIndex:indexPath.row];
    
    if (manger.btyeProgress.length) {
        cell.percentLab.text = manger.btyeProgress;
        [cell.byteProgress setProgress:manger.percent];
        cell.nameLab.text = manger.downLoadName;
    }
    
    else if (manger.error)//下载出错的时候TODO:::
    {
        cell.nameLab.textColor = [UIColor redColor];
        cell.nameLab.text = manger.downLoadName;
    }
    
    else{
        
        long long nowBtye = [manger.myPath cacheFileWithPath];
        long long totalBtye = [manger.downLoadName getFilesize];
        
        cell.percentLab.text = [NSString stringWithFormat:@"%lld/%lld",nowBtye,totalBtye];
        [cell.byteProgress setProgress:(double)nowBtye/totalBtye];
        cell.nameLab.text = manger.downLoadName;
    }
    
    
    
    
    
     return cell;
}

-(void)taskPrigress:(JCDownLoadManger *)manger  andState:(NSString *)state
{
    if ([state isEqual:@"btyeProgress"]) {
        TaskTableViewCell *cell = (TaskTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[[MyTaskSingle sharedMyTaskSingle].taskArr indexOfObject:manger] inSection:0]];
        cell.percentLab.text = manger.btyeProgress;
        [cell.byteProgress setProgress:manger.percent];
        cell.nameLab.text = manger.downLoadName;

    }
    else if ([state isEqual:@"isComplited"])
    {
        TaskTableViewCell *cell = (TaskTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[[MyTaskSingle sharedMyTaskSingle].taskArr indexOfObject:manger] inSection:0]];
        cell.percentLab.text = @"下载完成";
        [cell.byteProgress setProgress:1];
        cell.nameLab.text = manger.downLoadName;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JCDownLoadManger *manger = [[MyTaskSingle  sharedMyTaskSingle].taskArr objectAtIndex:indexPath.row];
    
    if (manger.isPause) {
        
    [manger stopDownLoad];
        
        }
    else{
        
    [manger startDownLoad];
        
    }
    
 
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
