//
//  ShareCell.h
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareCell : UITableViewCell

@property(nonatomic,strong) UILabel *titelLabel;
@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) UILabel *timelabel;
@property(nonatomic,strong) UILabel *shareLikeLabel;
@property(nonatomic,strong) UILabel *commentLabel;
@property(nonatomic,strong) UILabel *rightLabel;

@property(nonatomic,strong) UIImageView *lineImage;
@property(nonatomic,strong) UIImageView *image;
@property(nonatomic,strong) UIImageView *userImage;
@property(nonatomic,strong) UIImageView *shareLikeImage;
@property(nonatomic,strong) UIImageView *commentImage;

-(void)initSubView;

@end
