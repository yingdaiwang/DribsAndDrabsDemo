//
//  myCellView.h
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-15.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCellView : UITableViewCell

@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UISwitch *mySwitch;

-(void)initSubView;

@end
