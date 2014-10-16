//
//  CalendarMonth.m
//  CalendarTest
//
//  Created by  on 14-9-28.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CalendarMonth.h"
#import "CalendarLogic.h"
#import "NoteDB.h"
#import "CalendarViewController.h"

#define kCalendarDayWidth	46.0f
#define kCalendarDayHeight	30.0f

@implementation CalendarMonth

@synthesize calendarLogic;
@synthesize datesIndex;
@synthesize buttonsIndex;
@synthesize numberOfDaysInWeek;
@synthesize selectedButton;
@synthesize selectedDate;

- (id)initWithFrame:(CGRect)frame logic:(CalendarLogic *)aLogic
{
    // Size is static
	NSInteger numberOfWeeks = 5;
	frame.size.width = 320;
	frame.size.height = ((numberOfWeeks + 1) * kCalendarDayHeight) + 60;
	selectedButton = -1;
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:[NSDate date]];	
	NSDate *todayDate = [calendar dateFromComponents:components];
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor redColor]; // Red should show up fails.
		self.opaque = YES;
		self.clipsToBounds = NO;
		self.clearsContextBeforeDrawing = NO;
		
		UIImageView *headerBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bkg_bottom.png"]];
		[headerBackground setFrame:CGRectMake(0, 0, 320, 60)];
		[self addSubview:headerBackground];
		
		UIImageView *calendarBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bkg_bottom.png"]];
		[calendarBackground setFrame:CGRectMake(0, 60, 320, (numberOfWeeks + 1) * kCalendarDayHeight)];
		[self addSubview:calendarBackground];
		
		
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		NSArray *daySymbols = [formatter shortWeekdaySymbols];
		self.numberOfDaysInWeek = [daySymbols count];
		
		
		UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
		aLabel.backgroundColor = [UIColor clearColor];
		aLabel.textAlignment = UITextAlignmentCenter;
		aLabel.font = [UIFont boldSystemFontOfSize:20];
//		aLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"calendar_item_click_bg.png"]];
        aLabel.textColor = [UIColor colorWithRed:56/250.f green:137/250.f blue:186/250.f alpha:1.0f];
        
		aLabel.shadowColor = [UIColor whiteColor];
		aLabel.shadowOffset = CGSizeMake(0, 1);
		
		[formatter setDateFormat:@"MMMM yyyy"];
		aLabel.text = [formatter stringFromDate:aLogic.referenceDate];
		[self addSubview:aLabel];
        
        aLogicNum = aLogic;
		
		
		UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, 320, 1)];
		lineView.backgroundColor = [UIColor lightGrayColor];
		[self addSubview:lineView];
		
		
		// Setup weekday names
		NSInteger firstWeekday = [calendar firstWeekday] - 1;
		for (NSInteger aWeekday = 0; aWeekday < numberOfDaysInWeek; aWeekday ++) {
 			NSInteger symbolIndex = aWeekday + firstWeekday;
			if (symbolIndex >= numberOfDaysInWeek) {
				symbolIndex -= numberOfDaysInWeek;
			}
			
			NSString *symbol = [daySymbols objectAtIndex:symbolIndex];
			CGFloat positionX = (aWeekday * kCalendarDayWidth) - 1;
			CGRect aFrame = CGRectMake(positionX, 40, kCalendarDayWidth, 20);
			
			aLabel = [[UILabel alloc] initWithFrame:aFrame];
			aLabel.backgroundColor = [UIColor clearColor];
			aLabel.textAlignment = UITextAlignmentCenter;
			aLabel.text = symbol;
			aLabel.textColor = [UIColor darkGrayColor];
			aLabel.font = [UIFont systemFontOfSize:12];
			aLabel.shadowColor = [UIColor whiteColor];
			aLabel.shadowOffset = CGSizeMake(0, 1);
			[self addSubview:aLabel];
    }
        
        // Build calendar buttons (6 weeks of 7 days)
		NSMutableArray *aDatesIndex = [[NSMutableArray alloc] init];
		NSMutableArray *aButtonsIndex = [[NSMutableArray alloc] init];
		
		for (NSInteger aWeek = 0; aWeek <= numberOfWeeks; aWeek ++) {
			CGFloat positionY = (aWeek * kCalendarDayHeight) + 60;
			
			for (NSInteger aWeekday = 1; aWeekday <= numberOfDaysInWeek; aWeekday ++) {
				CGFloat positionX = ((aWeekday - 1) * kCalendarDayWidth) - 1;
				CGRect dayFrame = CGRectMake(positionX, positionY, kCalendarDayWidth, kCalendarDayHeight);
				NSDate *dayDate = [CalendarLogic dateForWeekday:aWeekday 
														 onWeek:aWeek 
												  referenceDate:[aLogic referenceDate]];
				NSDateComponents *dayComponents = [calendar 
												   components:NSDayCalendarUnit fromDate:dayDate];
				
//				UIColor *titleColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"calendar_item_bg.png"]];
                UIColor *titleColor = [UIColor blackColor];
				if ([aLogic distanceOfDateFromCurrentMonth:dayDate] != 0) {
//					titleColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"calendar_item_with_memo_bg.png"]];
                    titleColor = [UIColor grayColor];
				}
				
				UIButton *dayButton = [UIButton buttonWithType:UIButtonTypeCustom];
				dayButton.opaque = YES;
				dayButton.clipsToBounds = NO;
				dayButton.clearsContextBeforeDrawing = NO;
				dayButton.frame = dayFrame;
				dayButton.titleLabel.shadowOffset = CGSizeMake(0, 1);
				dayButton.titleLabel.font = [UIFont systemFontOfSize:20];
				dayButton.tag = [aDatesIndex count];
				dayButton.adjustsImageWhenHighlighted = NO;
				dayButton.adjustsImageWhenDisabled = NO;
				dayButton.showsTouchWhenHighlighted = YES;
				
				
				// Normal
				[dayButton setTitle:[NSString stringWithFormat:@"%d", [dayComponents day]] 
						   forState:UIControlStateNormal];
				
				// Selected
				[dayButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
//				[dayButton setTitleShadowColor:[UIColor grayColor] forState:UIControlStateSelected];
				
				if ([dayDate compare:todayDate] != NSOrderedSame) {
					// Normal
					[dayButton setTitleColor:titleColor forState:UIControlStateNormal];
//					[dayButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
					[dayButton setBackgroundImage:[UIImage imageNamed:@"calendar_item_bg.png"] forState:UIControlStateNormal];
					
					// Selected
					[dayButton setBackgroundImage:[UIImage imageNamed:@"calendar_item_click_bg.png"] forState:UIControlStateSelected];
					
				} else {
					// Normal
					[dayButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//					[dayButton setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
					[dayButton setBackgroundImage:[UIImage imageNamed:@"calendar_item_with_memo_bg.png"] forState:UIControlStateNormal];
					
					// Selected
					[dayButton setBackgroundImage:[UIImage imageNamed:@"calendar_item_click_bg.png"] forState:UIControlStateSelected];
				}
                
				
				[dayButton addTarget:self action:@selector(dayButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
				[self addSubview:dayButton];
				
				// Save
				[aDatesIndex addObject:dayDate];
				[aButtonsIndex addObject:dayButton];
			}
		}
		
		// save
		self.calendarLogic = aLogic;
		self.datesIndex = [aDatesIndex copy];
		self.buttonsIndex = [aButtonsIndex copy];
    }
        
    return self;
}

//日期点击事件
- (void)dayButtonPressed:(UIButton *)sender
{
	[calendarLogic setReferenceDate:[datesIndex objectAtIndex:[sender tag]]];
    
//    NSDate *date = [NSDate dateWithTimeInterval:24*60*60 sinceDate:aLogicNum.referenceDate];
    
    //转换时间样式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *searchTime = [dateFormatter stringFromDate:aLogicNum.referenceDate];
    
    //数据库 条件查询
    dayNotesArray = [[NoteDB shareNoteDataInstance] findDayNotes:searchTime];
    
    //利用根视图控制器 传值
    UITabBarController *tabCtrl = (UITabBarController*)self.window.rootViewController;
    UINavigationController *nav = (UINavigationController*) [tabCtrl.childViewControllers objectAtIndex:1];
    CalendarViewController *calCtrl = (CalendarViewController*)[nav.childViewControllers lastObject];
    calCtrl.notesArray = dayNotesArray;
    
    [calCtrl.tableView reloadData];
    
    NSLog(@"=====%@",searchTime);
    NSLog(@"////%@",dayNotesArray);
    NSLog(@"*******%@",calCtrl.notesArray);
}

#pragma mark UI Controls
- (void)selectButtonForDate:(NSDate *)aDate
{
    if (selectedButton >= 0) {
		NSDate *todayDate = [CalendarLogic dateForToday];
		UIButton *button = [buttonsIndex objectAtIndex:selectedButton];
		
		CGRect selectedFrame = button.frame;
		if ([selectedDate compare:todayDate] != NSOrderedSame) {
			selectedFrame.origin.y = selectedFrame.origin.y + 1;
			selectedFrame.size.width = kCalendarDayWidth;
			selectedFrame.size.height = kCalendarDayHeight;
		}
		
		button.selected = NO;
		button.frame = selectedFrame;
		
		self.selectedButton = -1;
		self.selectedDate = nil;
	}
	
	if (aDate != nil) {
		// Save
		self.selectedButton = [calendarLogic indexOfCalendarDate:aDate];
		self.selectedDate = aDate;
		
		NSDate *todayDate = [CalendarLogic dateForToday];
		UIButton *button = [buttonsIndex objectAtIndex:selectedButton];
		
		CGRect selectedFrame = button.frame;
		if ([aDate compare:todayDate] != NSOrderedSame) {
			selectedFrame.origin.y = selectedFrame.origin.y - 1;
			selectedFrame.size.width = kCalendarDayWidth + 1;
			selectedFrame.size.height = kCalendarDayHeight + 1;
		}
		
		button.selected = YES;
		button.frame = selectedFrame;
		[self bringSubviewToFront:button];	
	}

}

@end
