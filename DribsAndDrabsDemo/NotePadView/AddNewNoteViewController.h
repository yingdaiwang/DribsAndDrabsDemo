//
//  AddNewNoteViewController.h
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewNoteViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)UITextView *mytextView;

@end
