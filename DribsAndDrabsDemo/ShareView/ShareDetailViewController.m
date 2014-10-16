//
//  ShareDetailViewController.m
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-18.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ShareDetailViewController.h"
#import "CommentModel.h"
#import "CommentLoadData.h"
#import "CommentCell.h"

@implementation ShareDetailViewController
{
    BOOL flag;
}

@synthesize detailMode;
@synthesize commentDataArray;
@synthesize showImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        flag=false;
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
    
    [self.navigationItem setTitle:self.detailMode.title];
    
    UILabel *test = [[UILabel alloc]init];
    test.frame = CGRectMake(20, 50, 200, 80);
    
    
    [self.view addSubview:test];
    
    CommentLoadData *loadData = [[CommentLoadData alloc]init];
    loadData.delegate = self;
    [loadData aSynchronous:detailMode.nid];
    
    //展示图片
    showImage =[[UIImageView alloc]initWithFrame:self.view.bounds];
    showImage.contentMode = UIViewContentModeScaleAspectFit;
    showImage.clipsToBounds = YES;
    [self.view addSubview:showImage];
    [self.view sendSubviewToBack:showImage];
    
}

#pragma mark - 实现接受数据代理方法
-(void)reciveData:(NSArray *)array
{
    commentDataArray = [NSArray array];
    commentDataArray = array;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.bounds.size.height-64-49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor redColor];
    [self.view addSubview:_tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
    {//section = 0时，只有2个row
        return 2;
    }
    return commentDataArray.count; //请求的数据
}

//判断是否有图片，适应不同Cell高度，
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 1)
    {//日记内容，是否有大图片
        CGSize size = [self.detailMode.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        if ([self.detailMode.photo_url length] == 0) {
            return size.height+40;
        }else{
            return size.height+220+50;
        }
        
    }
    else if(indexPath.section == 0 && indexPath.row == 0)
    {//标题
        return 50;
    }
    else
    {//评论详情
        CommentModel *commentModel = [[CommentModel alloc] init];
        commentModel = [commentDataArray objectAtIndex:indexPath.row];
        
        CGSize size1 = [commentModel.comment_content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        return size1.height+35;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"myCell";
    CommentCell *cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.label1.font = [UIFont systemFontOfSize:14];
    cell.label2.font = [UIFont systemFontOfSize:12];
    cell.label1.numberOfLines = 0;
    
    //布局坐标
    if (indexPath.section == 0 && indexPath.row == 0) 
    {
        cell.label1.frame = CGRectMake(20, 18, 280, 20);
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
        CGSize size = [self.detailMode.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        
        //判断是否有图片
        if([detailMode.photo_url length] == 0)
        {
            cell.label1.frame = CGRectMake(20, 5, 280, size.height);
            cell.label2.frame = CGRectMake(20, size.height + 10, 280, 20);
        }
        else
        {
            cell.image.frame = CGRectMake(20, 0, 280, 220);
            cell.image.contentMode = UIViewContentModeScaleAspectFit;
            cell.image.userInteractionEnabled = YES;
            cell.clipsToBounds = YES;
            
            
            cell.label1.frame = CGRectMake(20, 235, 280, size.height);
            
            cell.label2.frame = CGRectMake(20, size.height + 240, 280, 20);
        }
    }
    else
    {
        CommentModel *commentModel = [[CommentModel alloc] init];
        commentModel = [commentDataArray objectAtIndex:indexPath.row];
        
        CGSize size1 = [commentModel.comment_content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        cell.label1.frame = CGRectMake(20, 10, 280, size1.height);
        cell.label1.numberOfLines = 0;
        cell.label2.frame = CGRectMake(20, size1.height + 15, 280, 20);
    }
    
    
    //添加内容
    if(indexPath.section == 0 && indexPath.row == 0) 
    {
        cell.label1.text = detailMode.title;
        
    }
    else if(indexPath.section == 0 && indexPath.row == 1)
    {
        cell.label1.text = detailMode.content;
        cell.label2.text = [NSString stringWithFormat:@"%@条评论 ｜ %@个赞",detailMode.comment_num,detailMode.favorcount];
        cell.label2.textColor = [UIColor colorWithRed:0.259f green:0.631f blue:0.855f alpha:1.0f];
        
        //请求图片
        //创建一个队列
        dispatch_queue_t queue = dispatch_queue_create("image", NULL);
        //创建异步线程
        dispatch_async(queue, ^{
        
            //多线程
            NSURL *url=[NSURL URLWithString:detailMode.photo_url];
            NSData *data=[NSData dataWithContentsOfURL:url];
            UIImage *image=[UIImage imageWithData:data];
            
            
            //回到主线程执行
            dispatch_sync(dispatch_get_main_queue(), ^{
            
                cell.image.image = image;
                cell.image.clipsToBounds =YES;
                
                //图片手势
                cell.userInteractionEnabled = YES;
                cell.image.userInteractionEnabled = YES;
                UITapGestureRecognizer *singeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singeTapDid:)];
                singeTap.delegate = self;
                [cell.image addGestureRecognizer:singeTap];
                
            });
            
        });
    }
    else
    {
        CommentModel *commentModel = [[CommentModel alloc] init];
        commentModel = [commentDataArray objectAtIndex:indexPath.row];
        cell.label1.text = commentModel.comment_content;
        
        //转换时间显示样式
        NSDate *time = [NSDate dateWithTimeIntervalSince1970:[commentModel.inputtime floatValue]];
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *lastTime = [df stringFromDate:time];
        
        cell.label2.text = lastTime;
        cell.label2.textColor = [UIColor grayColor];
    }
    
    return cell;
}

//图片手势方法，及循环点击
-(void)singeTapDid:(UITapGestureRecognizer *)tap
{
    NSLog(@"tupian");
    
    flag =!flag;
    
    UIImageView *imgView = (UIImageView *)[tap view];
    
    if (flag) {
        showImage.image =imgView.image;
        [self.view bringSubviewToFront:showImage];
    }
    else{
        [self.view sendSubviewToBack:showImage];
    }
    
}

//设置图片点击为最高级别，防止被cell的点击事件截获
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    UIView *view =[gestureRecognizer view];
    
    if([view isKindOfClass:[UIImageView class]])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
