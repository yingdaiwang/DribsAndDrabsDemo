//
//  CalendarViewController.h
//  CalendarTest
//
//  Created by  on 14-9-28.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarLogic.h"

@class CalendarViewController;

@protocol CalendarViewControllerDelegate

- (void)calendarViewController:(CalendarViewController *)aCalendarViewController dateDidChange:(NSDate *)aDate;

@end

@class CalendarMonth;

@interface CalendarViewController : UIViewController<CalendarLogicDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id <CalendarViewControllerDelegate> calendarViewControllerDelegate;

@property (nonatomic, strong) CalendarLogic *calendarLogic;
@property (nonatomic, strong) CalendarMonth *calendarView;
@property (nonatomic, strong) CalendarMonth *calendarViewNew;
@property (nonatomic, strong) NSDate *selectedDate;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) NSArray *notesArray;
@property (nonatomic, strong) UITableView *tableView;

- (void)animationMonthSlideComplete;

@end
