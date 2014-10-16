//
//  CalendarViewController.m
//  CalendarTest
//
//  Created by  on 14-9-28.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarMonth.h"
#import "NoteModel.h"
#import "NoteDetailViewController.h"

@implementation CalendarViewController

@synthesize calendarViewControllerDelegate;

@synthesize calendarLogic;
@synthesize calendarView;
@synthesize calendarViewNew;
@synthesize selectedDate;

@synthesize leftButton;
@synthesize rightButton;

@synthesize notesArray;
@synthesize tableView = _tableView;

- (void)setSelectedDate:(NSDate *)aDate {
	selectedDate = aDate;
	
	[calendarLogic setReferenceDate:aDate];
	[calendarView selectButtonForDate:aDate];
}

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"日历", @"");
	self.view.bounds = CGRectMake(0, 0, 320, 480);
	self.view.clearsContextBeforeDrawing = NO;
	self.view.opaque = YES;
	self.view.clipsToBounds = NO;
    
    //UITableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 244, 320, 190) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
	NSDate *aDate = selectedDate;
	if (aDate == nil) {
		aDate = [CalendarLogic dateForToday];
	}
	
	CalendarLogic *aCalendarLogic = [[CalendarLogic alloc] initWithDelegate:self referenceDate:aDate];
	self.calendarLogic = aCalendarLogic;
	
	UIBarButtonItem *aClearButton = [[UIBarButtonItem alloc] 
									 initWithTitle:NSLocalizedString(@"Clear", @"") style:UIBarButtonItemStylePlain
									 target:self action:@selector(actionClearDate:)];
	self.navigationItem.rightBarButtonItem = aClearButton;
    
	
	CalendarMonth *aCalendarView = [[CalendarMonth alloc] initWithFrame:CGRectMake(0, 64, 320, 324) logic:calendarLogic];
	[aCalendarView selectButtonForDate:selectedDate];
	[self.view addSubview:aCalendarView];
	
	self.calendarView = aCalendarView;	
	
	
	UIButton *aLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
	aLeftButton.frame = CGRectMake(0, 64, 60, 60);
	aLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 20, 20);
	[aLeftButton setImage:[UIImage imageNamed:@"btn_back_Leftclick.png"] forState:UIControlStateNormal];
	[aLeftButton addTarget:calendarLogic 
					action:@selector(selectPreviousMonth) 
		  forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:aLeftButton];
	self.leftButton = aLeftButton;
	
	UIButton *aRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
	aRightButton.frame = CGRectMake(260, 64, 60, 60);
	aRightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 20, 0);
	[aRightButton setImage:[UIImage imageNamed:@"btn_back_Rightclick.png"] forState:UIControlStateNormal];
	[aRightButton addTarget:calendarLogic 
					 action:@selector(selectNextMonth) 
		   forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:aRightButton];
	self.rightButton = aRightButton;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.calendarLogic.calendarLogicDelegate = nil;
	self.calendarLogic = nil;
	
	self.calendarView = nil;
	self.calendarViewNew = nil;
	
	self.selectedDate = nil;
	
	self.leftButton = nil;
	self.rightButton = nil;
    
}

- (CGSize)contentSizeForViewInPopoverView 
{
	return CGSizeMake(320, 324);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad || interfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark UI events

- (void)actionClearDate:(id)sender {
	self.selectedDate = nil;
	[calendarView selectButtonForDate:nil];
	
	// Delegate called later.
	//[calendarViewControllerDelegate calendarViewController:self dateDidChange:nil];
}

#pragma mark CalendarLogic delegate

- (void)calendarLogic:(CalendarLogic *)aLogic dateSelected:(NSDate *)aDate {
	selectedDate = aDate;
	
	if ([calendarLogic distanceOfDateFromCurrentMonth:selectedDate] == 0) {
		[calendarView selectButtonForDate:selectedDate];
	}
	
	[calendarViewControllerDelegate calendarViewController:self dateDidChange:aDate];
}
- (void)calendarLogic:(CalendarLogic *)aLogic monthChangeDirection:(NSInteger)aDirection {
	BOOL animate = self.isViewLoaded;
	
	CGFloat distance = 320;
	if (aDirection < 0) {
		distance = -distance;
	}
	
	leftButton.userInteractionEnabled = NO;
	rightButton.userInteractionEnabled = NO;
	
	CalendarMonth *aCalendarView = [[CalendarMonth alloc] initWithFrame:CGRectMake(distance, 64, 320, 308) logic:aLogic];
	aCalendarView.userInteractionEnabled = NO;
	if ([calendarLogic distanceOfDateFromCurrentMonth:selectedDate] == 0) {
		[aCalendarView selectButtonForDate:selectedDate];
	}
	[self.view insertSubview:aCalendarView belowSubview:calendarView];
	
	self.calendarViewNew = aCalendarView;
	
	if (animate) {
		[UIView beginAnimations:NULL context:nil];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationMonthSlideComplete)];
		[UIView setAnimationDuration:0.3];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	}
	
	calendarView.frame = CGRectOffset(calendarView.frame, -distance, 0);
	aCalendarView.frame = CGRectOffset(aCalendarView.frame, -distance, 0);
	
	if (animate) {
		[UIView commitAnimations];
		
	} else {
		[self animationMonthSlideComplete];
	}
}

- (void)animationMonthSlideComplete {
	// Get rid of the old one.
	[calendarView removeFromSuperview];
	
	// replace
	self.calendarView = calendarViewNew;
	self.calendarViewNew = nil;
    
	leftButton.userInteractionEnabled = YES;
	rightButton.userInteractionEnabled = YES;
	calendarView.userInteractionEnabled = YES;
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
    
    return [notesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    NoteModel *dayNote = [self.notesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = dayNote.content;
    cell.detailTextLabel.text = dayNote.noteTime;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteModel *str = [self.notesArray objectAtIndex:indexPath.row];
    
    NoteModel *model = [[NoteModel alloc]init];
    model.content = str.content;
    model.noteTime = str.noteTime;
    
    NoteDetailViewController *modifyCtrl = [[NoteDetailViewController alloc]init];
    modifyCtrl.model2 = model;
    
    [self.navigationController pushViewController:modifyCtrl animated:NO];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
