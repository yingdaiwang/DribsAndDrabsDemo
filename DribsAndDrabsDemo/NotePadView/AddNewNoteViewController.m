//
//  AddNewNoteViewController.m
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "AddNewNoteViewController.h"
#import "NoteDB.h"
#import "NoteModel.h"

@implementation AddNewNoteViewController

@synthesize mytextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *savebtn = [[UIBarButtonItem alloc]initWithTitle:@"save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveclicked)];
    self.navigationItem.rightBarButtonItem = savebtn;
    
    mytextView = [[UITextView alloc]initWithFrame: self.view.frame];
    mytextView.font = [UIFont systemFontOfSize:16];
    mytextView.backgroundColor = [UIColor colorWithRed:0.914 green:0.949 blue:0.635 alpha:1.0f];
    
    [mytextView becomeFirstResponder];
    
    [self.view addSubview:mytextView];
    
}

- (void)saveclicked
{
    [self.view endEditing:YES];
    
    NSString *content = mytextView.text;
    
    //保存时间的样式
    NSDate *theDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *saveTime = [dateFormatter stringFromDate:theDate];
    
    NoteModel *note = [[NoteModel alloc] init];
    note.content = content;
    note.noteTime = saveTime;
    
    //调用数据保存方法
    [[NoteDB shareNoteDataInstance] addNote:note];
    
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"add success!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{    
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//通过委托放弃"第一响应者"
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
