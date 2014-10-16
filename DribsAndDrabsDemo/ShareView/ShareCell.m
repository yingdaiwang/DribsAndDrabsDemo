//
//  ShareCell.m
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ShareCell.h"

@implementation ShareCell

@synthesize titelLabel = _titelLabel;
@synthesize contentLabel = _contentLabel;
@synthesize timelabel = _timelabel;
@synthesize rightLabel = _rightLabel;
@synthesize shareLikeLabel = _shareLikeLabel;
@synthesize commentLabel = _commentLabel;

@synthesize lineImage = _lineImage;
@synthesize shareLikeImage = _shareLikeImage;
@synthesize commentImage = _commentImage;
@synthesize image = _image;
@synthesize userImage = _userImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initSubView
{
    _titelLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titelLabel];
    
    _contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_contentLabel];
    
    _timelabel = [[UILabel alloc] init];
    [self.contentView addSubview:_timelabel];
    
    _userImage = [[UIImageView alloc]init];
    [self.contentView addSubview:_userImage];
    
    _image = [[UIImageView alloc]init];
    [self.contentView addSubview:_image];
    
    _rightLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_rightLabel];
    
    _shareLikeImage = [[UIImageView alloc]init];
    [self.contentView addSubview:_shareLikeImage];
    
    _shareLikeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_shareLikeLabel];
    
    _commentImage = [[UIImageView alloc]init];
    [self.contentView addSubview:_commentImage];
    
    _commentLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_commentLabel];
    
    _lineImage = [[UIImageView alloc]init];
    [self.contentView addSubview:_lineImage];
    
}

-(void)layoutSubviews
{
    _titelLabel.frame = CGRectMake(20, 0, 270, 30);
    _titelLabel.font = [UIFont systemFontOfSize:16];
    
    _userImage.frame = CGRectMake(290, 5, 20, 20);

    
    _image.frame = CGRectMake(5, 35, 40, 40);
    _image.backgroundColor=[UIColor clearColor];
    
    _rightLabel.frame = CGRectMake(50, 30, 265, 50);
    _rightLabel.numberOfLines = 3;
    _rightLabel.font = [UIFont systemFontOfSize:13];
    
    _contentLabel.frame = CGRectMake(10, 30, 300, 50);
    _contentLabel.numberOfLines = 3;
    _contentLabel.font = [UIFont systemFontOfSize:13];
    
    
    _shareLikeImage.frame = CGRectMake(10, 80, 20, 19);
    
    _shareLikeLabel.frame = CGRectMake(35, 80, 20, 19);
    _shareLikeLabel.textColor = [UIColor grayColor];
    _shareLikeLabel.font = [UIFont systemFontOfSize:12];
    
    _commentImage.frame = CGRectMake(70, 80, 20, 19);
    
    _commentLabel.frame = CGRectMake(95, 80, 20, 19);
    _commentLabel.textColor = [UIColor grayColor];
    _commentLabel.font = [UIFont systemFontOfSize:12];
    
    _timelabel.frame = CGRectMake(200, 80, 120, 19);
    _timelabel.font = [UIFont systemFontOfSize:12];
    _timelabel.textColor = [UIColor grayColor];
    
    _lineImage.frame = CGRectMake(0, 99, 320, 1);
    
    
}

@end
