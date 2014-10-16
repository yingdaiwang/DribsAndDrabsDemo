//
//  CommentCell.m
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-25.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

@synthesize image = _image;
@synthesize label1 = _label1;
@synthesize label2 = _label2;

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
    _image = [[UIImageView alloc]init];
    [self addSubview:_image];
    
    _label1 = [[UILabel alloc]init];
    [self addSubview:_label1];
    
    _label2 = [[UILabel alloc]init];
    [self addSubview:_label2];
    
}

-(void)layoutSubviews
{
    _label1.backgroundColor = [UIColor clearColor];
    
    _label2.font = [UIFont systemFontOfSize:12];
    _label2.backgroundColor = [UIColor clearColor];
}

@end
