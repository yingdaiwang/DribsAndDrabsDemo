//
//  ShareLoadData.m
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ShareLoadData.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "ShareModel.h"

#define URL_String @"http://api.jijiriji.com/jijiapi/note/recommanded_notes_v2?page="

@implementation ShareLoadData

+(void)aSynchronous:(NSString *)pagNum block:(FinishData)block
{
    NSString *urlString = [URL_String stringByAppendingFormat:@"%@",pagNum];
    
    NSURL *url = [NSURL URLWithString:urlString];
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"GET"];
    [request setTimeOutSeconds:30];
    
    [request setDelegate:self];

    [request setCompletionBlock:^() {

        NSData *data = request.responseData;
        
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *shareArray = [NSArray array];
        
        shareArray = [resDict objectForKey:@"notes"];
        
        NSMutableArray *myArray = [NSMutableArray array];
        
        for(NSDictionary *dict in shareArray)
        {
            ShareModel *shareDatil = [[ShareModel alloc]init];
            
            shareDatil.title = [dict objectForKey:@"title"];
            shareDatil.content = [dict objectForKey:@"content"];
            shareDatil.time = [dict objectForKey:@"update_time"];
            shareDatil.nid = [dict objectForKey:@"nid"];
            shareDatil.favorcount = [dict objectForKey:@"favorcount"];
            shareDatil.comment_num = [dict objectForKey:@"comment_num"];
            
            NSDictionary *photosDict = [dict objectForKey:@"photos"];
            shareDatil.thumb = [photosDict objectForKey:@"thumb"];
            shareDatil.photo_url = [photosDict objectForKey:@"photo_url"];
            
            [myArray addObject:shareDatil];
        }
        
        block(myArray);
    }];
    
    [request setFailedBlock:^{
    
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"加载数据失败！网络连接失败！" delegate:Nil
                                            cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }];
    
//    //--------------------设置缓存----------------------
//    NSString *cachPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    ASIDownloadCache *cache = [[ASIDownloadCache alloc]init];
//    [cache setStoragePath:cachPath];
//    
//    //缓存策略
//    cache.defaultCachePolicy = ASIOnlyLoadIfNotCachedCachePolicy;
//    
//    //每次请求会将上次缓存文件清除掉
//    //request.cacheStoragePolicy = ASICacheForSessionDurationCacheStoragePolicy;
//    
//    //持久缓存，一直保存在本地
//    request.cacheStoragePolicy = ASICachePermanentlyCacheStoragePolicy;
//    
//    request.downloadCache = cache;
    
    
    //发送异步请求
    [request startAsynchronous];

}

//-(void)loadImageData:(NSString *)url
//{
//    NSURL *imageUrl = [NSURL URLWithString:url];
//    
//    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:imageUrl];
//    [request setRequestMethod:@"GET"];
//    [request setTimeOutSeconds:30];
//    
//    [request setDelegate:self];
//    
//    [request startAsynchronous];
//    
//    [request setCompletionBlock:^{
//    
//        NSData *iamgeData = [request responseData];
//        
//        UIImage *image = [UIImage imageWithData:iamgeData];
//        
////        [self.delegate reciveImage:image];
//    }];
//    
//    [request setFailedBlock:^{
//    
//    
//    }];
//    
//    
//}

@end
