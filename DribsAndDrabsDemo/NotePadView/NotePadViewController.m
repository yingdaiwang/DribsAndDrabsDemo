//
//  NotePadViewController.m
//  DribsAndDrabsDemo
//
//  Created by  on 14-9-16.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "NotePadViewController.h"
#import "AddNewNoteViewController.h"
#import "NoteDetailViewController.h"
#import "NoteModel.h"
#import "NoteDB.h"

@implementation NotePadViewController

@synthesize noteArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    
    [[NoteDB shareNoteDataInstance] createNoteTable];
    
    [self.navigationItem setTitle:@"Notes"];
    
    UIBarButtonItem *addbtn = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(addNote)];
    
    self.navigationItem.rightBarButtonItem = addbtn;
    
}

//新增记事
- (void)addNote
{
    AddNewNoteViewController *detailViewCtrl = [[AddNewNoteViewController alloc]init];
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
}

-(void)loadData
{
    //刷新列表
    self.noteArray = [[NoteDB shareNoteDataInstance] findNotes];
    [self.tableView reloadData];
}
//自动刷新tableView列表
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    return [noteArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    NoteModel *note = [self.noteArray objectAtIndex:indexPath.row];
    cell.textLabel.text = note.content;
    cell.detailTextLabel.text = note.noteTime;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteModel *str = [self.noteArray objectAtIndex:indexPath.row];
    
    NoteModel *model = [[NoteModel alloc]init];
    model.content = str.content;
    model.noteTime = str.noteTime;
        
    NoteDetailViewController *modifyCtrl = [[NoteDetailViewController alloc]init];
    modifyCtrl.model2 = model;
    
    [self.navigationController pushViewController:modifyCtrl animated:NO];
}

@end
