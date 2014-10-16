//
//  ShareDetailViewController.h
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-18.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentLoadData.h"
#import "CommentModel.h"
#import "ShareModel.h"

@interface ShareDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, CommentLoadDataDelegate,UIGestureRecognizerDelegate>
{
    UITableView *_tableView;
}

@property(nonatomic,strong)ShareModel *detailMode;

@property(nonatomic,strong) NSArray *commentDataArray;

@property (nonatomic,retain)UIImageView *showImage;

@end
