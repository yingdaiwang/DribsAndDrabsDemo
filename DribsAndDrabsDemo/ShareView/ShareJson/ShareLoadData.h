//
//  ShareLoadData.h
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

typedef void (^FinishData)(NSArray *);

@interface ShareLoadData : NSObject<ASIHTTPRequestDelegate>

+(void)aSynchronous:(NSString *)pagNum block:(FinishData)block;

//-(void)loadImageData:(NSString *)url;

@end
