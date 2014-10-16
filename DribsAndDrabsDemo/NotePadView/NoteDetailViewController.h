//
//  NoteDetailViewController.h
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteModel.h"
#import "NotePadViewController.h"

@interface NoteDetailViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic,strong) UILabel *timeLabe;
@property (nonatomic,strong) UITextView *mytextView;
@property (nonatomic, strong) NoteModel *model2;

@end
