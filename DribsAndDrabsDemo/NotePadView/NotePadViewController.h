//
//  NotePadViewController.h
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteModel.h"

@interface NotePadViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *noteArray;

-(void)loadData;

@end
