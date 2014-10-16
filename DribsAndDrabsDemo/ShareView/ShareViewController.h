//
//  ShareViewController.h
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareLoadData.h"
#import "ShareModel.h"
#import "PullTableView.h"

@interface ShareViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>
{
    PullTableView *_tableView;
    ShareModel *myShare;
}

@property(nonatomic,strong) NSArray *shareDataArray;

- (void) refreshTable;

@end
