//
//  ShareViewController.m
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareCell.h"
#import "ShareDetailViewController.h"

@implementation ShareViewController

@synthesize shareDataArray;

static int page = 1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"分享"];
    
    if([[[UIDevice currentDevice] systemVersion]floatValue]>=7.0f)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    shareDataArray = [NSArray array];
    _tableView = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44-49) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.pullDelegate = self;
    _tableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    _tableView.pullBackgroundColor = [UIColor whiteColor];
    _tableView.pullTextColor = [UIColor blackColor];
    
    [self.view addSubview:_tableView];

    [self refreshTable];
    
    //[self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return shareDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShareCell *cell = [[ShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    // Configure the cell...
    myShare = [[ShareModel alloc]init];
    
    myShare = [shareDataArray objectAtIndex:indexPath.row];
    
    if([myShare.title isEqualToString:@""] == YES)
    {
        if(myShare.content.length <= 8)
        {
            cell.timelabel.text = myShare.content;
        }
        else
        {
            cell.titelLabel.text = [myShare.content substringToIndex:8];
        }
    }
    else
    {
        cell.titelLabel.text = myShare.title;
    }
    
    if([myShare.thumb isEqualToString:@""] == YES)
    {
        cell.contentLabel.text = myShare.content;
        
        cell.image.hidden = YES;
        cell.rightLabel.hidden = YES;
    }
    else
    {
        //请求图片
        //创建一个队列
        dispatch_queue_t queue = dispatch_queue_create("test", NULL);
        
        //创建异步线程
        dispatch_async(queue, ^{
            
            //多线程
            NSURL *url=[NSURL URLWithString:myShare.thumb];
            NSData *data=[NSData dataWithContentsOfURL:url];
            UIImage *image=[UIImage imageWithData:data];
            
            //回到主线程
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.image.image=image;
            });
        });
        
        cell.rightLabel.text = myShare.content;
        
        cell.contentLabel.hidden = YES;
    }
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[myShare.time floatValue]];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *lastTime = [df stringFromDate:time];
    
    cell.timelabel.text = lastTime;
    cell.shareLikeLabel.text = myShare.favorcount;
    cell.shareLikeImage.image = [UIImage imageNamed:@"img_btn_share_like"];
    
    cell.commentLabel.text = myShare.comment_num;
    cell.commentImage.image = [UIImage imageNamed:@"normal_img_btn_comment"];
    
    cell.lineImage.image = [UIImage imageNamed:@"widget_divider_line"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShareModel *str = [shareDataArray objectAtIndex:indexPath.row];
    
    ShareModel *model = [[ShareModel alloc]init];
    
    if([str.title isEqualToString:@""] == YES)
    {
        if(str.content.length <= 8)
        {
            model.title = str.content;
        }
        else
        {
            model.title = [str.content substringToIndex:8];
        }
    }
    else
    {
        model.title = str.title;
    }
    
    model.content = str.content;
    model.time = str.time;
    model.favorcount = str.favorcount;
    model.comment_num = str.comment_num;
    model.nid = str.nid;
    model.photo_url = str.photo_url;
    ShareDetailViewController *shareDetailView = [[ShareDetailViewController alloc] init];
    shareDetailView.detailMode = model;
     [self.navigationController pushViewController:shareDetailView animated:NO];
     [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
}

#pragma mark - Refresh and load more methods
//下拉刷新
- (void) refreshTable
{
    [ShareLoadData aSynchronous:[NSString stringWithFormat:@"%d",page] block:^(NSArray *arr) {
        shareDataArray = arr;
        
        [_tableView reloadData];
    }];
    
    _tableView.pullLastRefreshDate = [NSDate date];
    _tableView.pullTableIsRefreshing = NO;

}

//上拉加载更多
- (void) loadMoreDataToTable
{
    page++;
    
    [ShareLoadData aSynchronous:[NSString stringWithFormat:@"%d",page] block:^(NSArray *arr) {
        NSArray *arr1 = shareDataArray;
        NSArray *arr2 = arr;
        NSMutableArray *arr3 = [NSMutableArray array];
        [arr3 addObjectsFromArray:arr1];
        [arr3 addObjectsFromArray:arr2];
        shareDataArray = arr3;
        
        [_tableView reloadData];
        
        _tableView.pullTableIsLoadingMore = NO;
    }];
}

@end
