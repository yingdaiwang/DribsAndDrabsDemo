//
//  CommentLoadData.m
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CommentLoadData.h"
#import "ASIHTTPRequest.h"
#import "CommentModel.h"

#define CommentUrl @"http://api.jijiriji.com/jijiapi/note/get_comments?nid="

@implementation CommentLoadData

@synthesize delegate;

-(void)aSynchronous:(NSString *)nid
{
    NSString *urlString = [CommentUrl stringByAppendingFormat:@"%@",nid];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"GET"];
    [request setTimeOutSeconds:30];
    
    [request setDelegate:self];
    
    [request setCompletionBlock:^() {
        
        NSData *data = request.responseData;
        
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *commentArray = [NSArray array];
        
        commentArray = [resDict objectForKey:@"comments"];
        
        NSMutableArray *myArray = [NSMutableArray array];
    
    for(NSDictionary *dict in commentArray)
    {
        CommentModel *commentDatil = [[CommentModel alloc]init];
        
        commentDatil.comment_content = [dict objectForKey:@"comment_content"];
        commentDatil.inputtime = [dict objectForKey:@"inputtime"];
        
        [myArray addObject:commentDatil];
    }
        
    [self.delegate reciveData:myArray];
    
    }];
    
    [request setFailedBlock:^{
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"加载数据失败！网络连接失败！" delegate:Nil
                                            cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }];
    
    //发送异步请求
    [request startAsynchronous];
    
}

@end
