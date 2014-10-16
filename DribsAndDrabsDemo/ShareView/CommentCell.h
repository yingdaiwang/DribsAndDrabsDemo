//
//  CommentCell.h
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-25.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell

@property(nonatomic,strong) UIImageView *image;
@property(nonatomic,strong) UILabel *label1;
@property(nonatomic,strong) UILabel *label2;

-(void)initSubView;

@end
