//
//  NoteDetailViewController.m
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "NoteDetailViewController.h"
#import "NotePadViewController.h"
#import "NoteDB.h"
#import "NoteModel.h"

@implementation NoteDetailViewController

@synthesize timeLabe;
@synthesize mytextView;
@synthesize model2;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self.view endEditing:YES];
    
    //导航栏 按钮
    UIBarButtonItem *savebtn = [[UIBarButtonItem alloc]initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(saveclicked)];
    UIBarButtonItem *delbtn = [[UIBarButtonItem alloc]initWithTitle:@"delete" style:UIBarButtonItemStylePlain target:self action:@selector(deleteclicked)];
    
    NSArray *bararray = [NSArray arrayWithObjects:delbtn,savebtn, nil];
    self.navigationItem.rightBarButtonItems = bararray;
    
    //显示文本
    mytextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 20, 320, self.view.bounds.size.height-44-20-20)];
    mytextView.font = [UIFont systemFontOfSize:16];
    mytextView.text = self.model2.content;
    [self.view addSubview:mytextView];
    
    //显示时间
    timeLabe = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    timeLabe.textColor = [UIColor grayColor];
    timeLabe.text = self.model2.noteTime;
    [self.view addSubview:timeLabe];
     
}

//修改文本
- (void)saveclicked
{    
    NSString *content = mytextView.text;
    
    NSDate *theDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *saveTime = [dateFormatter stringFromDate:theDate];
    
    NoteModel *note = [[NoteModel alloc] init];
    note.content = content;
    note.noteTime = saveTime;
    
    [[NoteDB shareNoteDataInstance] addNote:note];
    [[NoteDB shareNoteDataInstance] removeNote:model2];
    
    [mytextView resignFirstResponder];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"save success!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
}

//删除文本
-(void)deleteclicked
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Are you sure to delete this note?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) 
    {
        return;
    }
    else if (buttonIndex == 1) 
    {
        [[NoteDB shareNoteDataInstance] removeNote:model2];
        [self.navigationController popViewControllerAnimated:YES];
    }
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

@end
