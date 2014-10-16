//
//  CommentLoadData.h
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

//设置代理
@class CommentLoadData;
@protocol  CommentLoadDataDelegate<NSObject>

@required

-(void)reciveData:(NSArray *)array;
//-(void)reciveImage:(UIImage *)image;

@end


@interface CommentLoadData : NSObject<ASIHTTPRequestDelegate>

@property (nonatomic, assign) id<CommentLoadDataDelegate> delegate;

-(void)aSynchronous:(NSString *)nid;

//-(void)loadImageData:(NSString *)url;

@end
