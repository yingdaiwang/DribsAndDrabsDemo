//
//  myCellView.m
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-15.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "myCellView.h"

@implementation myCellView

@synthesize label = _label;
@synthesize mySwitch = _mySwitch;

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
    _label = [[UILabel alloc]init];
    [self.contentView addSubview:_label];
    
    _mySwitch = [[UISwitch alloc]init];
    [self.contentView addSubview:_mySwitch];
}

-(void) layoutSubviews
{
    _label.frame = CGRectMake(15, 5, 80, 20);
    _mySwitch.frame = CGRectMake(230, 0, 30, 20);
}

@end
